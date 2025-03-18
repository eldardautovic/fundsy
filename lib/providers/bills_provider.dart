import 'package:fundsy/main.dart';
import 'package:fundsy/models/bill.dart';

final String tableBill = 'Bills';
final String columnId = 'id';
final String columnBalance = 'balance';
final String columnCategory = 'category';
final String columnCompleted = 'completed';
final String columnCreatedAt = 'created_at';

class BillsProvider {
  Future<Bill> insert(Bill bill) async {
    bill.id = await db!.database!.insert(tableBill, bill.toMap());
    return bill;
  }

  Future<int> update(Bill bill) async {
    return await db!.database!.update(tableBill, bill.toMap(),
        where: '$columnId = ?', whereArgs: [bill.id]);
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
      WHERE date($columnCompleted) = ?
      ORDER BY $columnCreatedAt DESC
    ''', [1]);

    double leftoverAmount = double.tryParse(total[0]['total'].toString()) ?? 0;

    return leftoverAmount;
  }
}
