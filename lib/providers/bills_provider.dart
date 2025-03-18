import 'package:fundsy/main.dart';
import 'package:fundsy/models/bill.dart';

final String tableBill = 'Bills';
final String columnId = 'id';
final String columnCost = 'cost';
final String columnName = 'name';
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
}
