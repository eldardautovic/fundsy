import 'package:fundsy/main.dart';
import 'package:fundsy/models/user.dart';

import "package:fundsy/database/database.dart";

final String tableUser = 'User';
final String columnId = 'id';
final String columnBalance = 'balance';

class UserProvider {
  Future<User> insert(User userPayload) async {
    userPayload.id = await db!.database!.insert(tableUser, userPayload.toMap());
    return userPayload;
  }

  Future<int> update(Map<String, dynamic> userPayload) async {
    await user.setBalance(userPayload['balance']);

    return await db!.database!.update(
        tableUser, {"balance": userPayload['balance']},
        where: '$columnId = ?', whereArgs: [1]);
  }

  Future close() async => db!.database!.close();
}
