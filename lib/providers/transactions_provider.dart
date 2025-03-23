import 'package:fundsy/database/database.dart';
import 'package:fundsy/main.dart';
import 'package:fundsy/models/transaction.dart';
import 'package:fundsy/models/user.dart';
import 'package:intl/intl.dart';

final String tableTransaction = 'Transactions';
final String columnId = 'id';
final String columnBalance = 'balance';
final String columnCreatedAt = 'created_at';
final String columnCategory = 'category';

class TransactionProvider {
  Future<Map<String, dynamic>> insert(dynamic transaction) async {
    await db!.database!.insert(tableTransaction, transaction);

    await db!.database!.update(
        tableUser, {columnBalance: user.balance - transaction['balance']},
        where: "id = ?", whereArgs: [user.id]);

    user.setBalance(user.balance - transaction['balance']);

    return transaction;
  }

  Future<int> update(Transaction transaction) async {
    return await db!.database!.update(tableTransaction, transaction.toMap(),
        where: '$columnId = ?', whereArgs: [transaction.id]);
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

  Future close() async => db!.database!.close();
}
