import 'package:fundsy/models/financial_item.dart';

final String tableBill = 'Bills';
final String columnId = 'id';
final String columnBalance = 'balance';
final String columnCategory = 'category';
final String columnCreatedAt = 'created_at';
final String columnCompleted = 'completed';

class Bill extends FinancialItem {
  int id = 0;
  double balance = 0.0;
  DateTime createdAt = DateTime.now();
  String category = '';
  bool completed = false;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnBalance: balance,
      columnCreatedAt: createdAt,
      columnCategory: category
    };
    // ignore: unnecessary_null_comparison
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Bill();

  Bill.fromMap(Map<String, Object?> map) {
    id = map[columnId] as int;
    balance = map[columnBalance] as double;
    createdAt = DateTime.parse(map[columnCreatedAt] as String);
    category = map[columnCategory] as String;
    completed = map[columnCompleted] as bool;
  }
}
