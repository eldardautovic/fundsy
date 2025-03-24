import 'package:fundsy/database/database.dart';
import 'package:fundsy/main.dart';
import 'package:fundsy/models/transaction.dart';
import 'package:fundsy/models/user.dart';
import 'package:intl/intl.dart';
import 'dart:async';

final String tableTransaction = 'Transactions';
final String columnId = 'id';
final String columnBalance = 'balance';
final String columnCreatedAt = 'created_at';
final String columnCategory = 'category';

class TransactionProvider {
  // Stream controller to notify listeners when transactions change
  final _transactionController = StreamController<void>.broadcast();

  // Stream that widgets can listen to
  Stream<void> get onTransactionsChanged => _transactionController.stream;

  Future<Map<String, dynamic>> insert(dynamic transaction) async {
    await db!.database!.insert(tableTransaction, transaction);

    await db!.database!.update(
        tableUser, {columnBalance: user.balance - transaction['balance']},
        where: "id = ?", whereArgs: [user.id]);

    user.setBalance(user.balance - transaction['balance']);

    // Notify listeners that transactions have changed
    _transactionController.add(null);

    return transaction;
  }

  Future<int> update(Transaction transaction) async {
    final result = await db!.database!.update(
        tableTransaction, transaction.toMap(),
        where: '$columnId = ?', whereArgs: [transaction.id]);

    // Notify listeners that transactions have changed
    _transactionController.add(null);

    return result;
  }

  Future<List<Transaction>> getTransactions(bool areAllIncluded) async {
    List<Map<String, Object?>> maps = await db!.database!.query(
      tableTransaction,
      columns: [columnId, columnBalance, columnCategory, columnCreatedAt],
      limit: areAllIncluded ? null : 4,
      orderBy: '$columnCreatedAt DESC',
    );

    List<Transaction> resultSet = [];

    for (var transact in maps) {
      resultSet.add(Transaction.fromMap(transact));
    }

    return resultSet;
  }

  Future<double> getDailyTransactions() async {
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    var total = await db!.database!.rawQuery('''
      SELECT SUM(balance) as total 
      FROM Transactions
      WHERE date($columnCreatedAt) = ?
      ORDER BY $columnCreatedAt DESC
    ''', [today]);

    double spentToday = double.tryParse(total[0]['total'].toString()) ?? 0;

    return spentToday;
  }

  // Dispose the controller when no longer needed
  void dispose() {
    _transactionController.close();
  }

  Future close() async => db!.database!.close();
}
