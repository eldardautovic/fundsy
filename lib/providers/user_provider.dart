import 'package:fundsy/main.dart';
import 'package:fundsy/models/user.dart';

final String tableUser = 'User';
final String columnId = 'id';
final String columnBalance = 'balance';

class UserProvider {
  Future<User> insert(User user) async {
    user.id = await db!.insert(tableUser, user.toMap());
    return user;
  }

  Future<int> delete(int id) async {
    return await db!.delete(tableUser, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(User user) async {
    return await db!.update(tableUser, user.toMap(),
        where: '$columnId = ?', whereArgs: [user.id]);
  }

  Future close() async => db!.close();
}
