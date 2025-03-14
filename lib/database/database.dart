import 'dart:io';

import 'package:fundsy/models/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:path/path.dart' as p;

final user = User();

class Store {
  Database? database;

  Store() {
    initTables();
  }

  Future<void> initTables() async {
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
    }

    databaseFactory = databaseFactoryFfi;

    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();

    String dbPath = p.join(appDocumentsDir.path, "databases", "fundsy_db.db");
    database = await databaseFactory.openDatabase(
      dbPath,
    );

    await database!.execute('''
      CREATE TABLE IF NOT EXISTS User (
        id INTEGER PRIMARY KEY,
        balance DOUBLE
      )
    ''');

    var result = await database!.query("User");

    if (result.isEmpty) {
      await database!.insert("User", {"balance": 0.0});
    } else {
      user.id = result[0]['id'] as int;
      user.setBalance(result[0]['balance'] as double);
    }

    await database!.execute('''
      CREATE TABLE IF NOT EXISTS Transactions (
        id INTEGER PRIMARY KEY,
        balance DOUBLE,
        created_at TEXT,
        category TEXT
      )
    ''');

    await database!.insert("Transactions", {
      "balance": 5.0,
      "created_at": DateTime.now().toIso8601String(),
      "category": "Eating out"
    });

    await database!.execute('''
      CREATE TABLE IF NOT EXISTS Bills (
        id INTEGER PRIMARY KEY,
        cost DOUBLE,
        name TEXT,
        created_at TEXT
      )
    ''');
  }
}
