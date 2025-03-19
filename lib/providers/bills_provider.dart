import 'package:fundsy/database/database.dart';
import 'package:fundsy/main.dart';
import 'package:fundsy/models/bill.dart';
import 'package:fundsy/models/user.dart';

final String tableBill = 'Bills';
final String columnId = 'id';
final String columnBalance = 'balance';
final String columnCategory = 'category';
final String columnCompleted = 'completed';
final String columnCreatedAt = 'created_at';

class BillsProvider {
  Future<dynamic> insert(dynamic bill) async {
    await db!.database!.insert(tableBill, bill);
    return bill;
  }

  Future<int> complete(Bill bill, int id) async {
    await db!.database!.update(
        tableUser,
        {
          columnBalance: bill.completed
              ? user.balance - bill.balance
              : user.balance + bill.balance
        },
        where: "id = ?",
        whereArgs: [user.id]);

    user.setBalance(bill.completed
        ? user.balance - bill.balance
        : user.balance + bill.balance);

    return await db!.database!.update(
        tableBill,
        {
          columnBalance: bill.balance,
          columnCategory: bill.category,
          columnCompleted: bill.completed ? 1 : 0,
        },
        where: '$columnId = ?',
        whereArgs: [id]);
  }

  Future<int> update(Map<String, dynamic> bill, int id) async {
    return await db!.database!.update(
        tableBill,
        {
          columnBalance: bill[columnBalance],
          columnCategory: bill[columnCategory],
          columnCompleted: bill[columnCompleted],
        },
        where: '$columnId = ?',
        whereArgs: [id]);
  }

  Future<List<Bill>> getBills() async {
    List<Map<String, Object?>> maps = await db!.database!.query(
      tableBill,
      columns: [
        columnId,
        columnBalance,
        columnCreatedAt,
        columnCategory,
        columnCompleted
      ],
      orderBy: '$columnCreatedAt DESC',
    );

    List<Bill> resultSet = [];

    for (var bill in maps) {
      resultSet.add(Bill.fromMap(bill));
    }

    return resultSet;
  }

  Future<double> getLeftoverBillsAmount() async {
    var total = await db!.database!.rawQuery('''
      SELECT SUM(balance) as total 
      FROM $tableBill
      WHERE $columnCompleted = ?
      ORDER BY $columnCreatedAt DESC
    ''', [0]);

    double leftoverAmount = double.tryParse(total[0]['total'].toString()) ?? 0;

    return leftoverAmount;
  }
}
