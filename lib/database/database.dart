import 'package:fundsy/main.dart';
import 'package:fundsy/models/user.dart';

final user = User();

Future<void> initTables() async {
  await db?.execute('''
  CREATE TABLE IF NOT EXISTS User (
    id INTEGER PRIMARY KEY,
    balance DOUBLE
  )
  ''');

  var result = await db?.query("User");

  if (result!.isEmpty) {
    await db?.insert("User", {"balance": 0.0});
  } else {
    user.id = result[0]['id'] as int;
    user.setBalance(result[0]['balance'] as double);
  }

  await db?.execute('''
  CREATE TABLE IF NOT EXISTS Transactions (
    id INTEGER PRIMARY KEY,
    balance DOUBLE,
    created_at TEXT,
    category TEXT
  )
  ''');

  await db?.execute('''
  CREATE TABLE IF NOT EXISTS Bills (
    id INTEGER PRIMARY KEY,
    cost DOUBLE,
    name TEXT
    created_at TEXT
  )
  ''');
}
