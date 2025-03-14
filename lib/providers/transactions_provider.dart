import 'package:fundsy/main.dart';
import 'package:fundsy/models/transaction.dart';
import 'package:intl/intl.dart';

final String tableTransaction = 'Transactions';
final String columnId = 'id';
final String columnBalance = 'balance';
final String columnCreatedAt = 'created_at';
final String columnCategory = 'category';

class TransactionProvider {
  Future<Transaction> insert(Transaction transaction) async {
    transaction.id =
        await db!.database!.insert(tableTransaction, transaction.toMap());
    return transaction;
  }

  Future<int> update(Transaction transaction) async {
    return await db!.database!.update(tableTransaction, transaction.toMap(),
        where: '$columnId = ?', whereArgs: [transaction.id]);
  }

  Future<List<Transaction>> getTransactions() async {
    List<Map<String, Object?>> maps = await db!.database!.query(
      tableTransaction,
      columns: [columnId, columnBalance, columnCategory, columnCreatedAt],
      limit: 4,
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

    double spentToday = double.parse(total[0]['total'].toString());

    return spentToday;
  }

  Future close() async => db!.database!.close();
}
