final String tableBill = 'Bills';
final String columnId = 'id';
final String columnCost = 'cost';
final String columnName = 'name';
final String columnCreatedAt = 'created_at';

class Bill {
  int id = 0;
  double cost = 0.0;
  DateTime createdAt = DateTime.now();
  String name = '';

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnCost: cost,
      columnCreatedAt: createdAt,
      columnName: name
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
    cost = map[columnCost] as double;
    createdAt = DateTime.parse(map[columnCreatedAt] as String);
    name = map[columnName] as String;
  }
}
