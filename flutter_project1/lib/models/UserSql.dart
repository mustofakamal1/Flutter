import 'DBHelper.dart';
import '../database/user.dart';

class UserSql extends DBHelper {

  DBHelper uHelper = new DBHelper();

  //Insert Tuples
  Future<User> save(User user) async {
    var dbClient = await db;
    user.id = await dbClient.insert("user", user.toMap());
    return user;
    /*
  await dbClient.transaction((txn) async {
    var query = "INSERT INTO $TABLE ($NAME) VALUES ('" + user.name + "')";
    return await txn.rawInsert(query);
  });
  */
  }

  // Select Tuples
  Future<List<User>> getUsers() async {
    var dbClient = await db;
    //List<Map> maps = await dbClient.query("user", columns: ["id", "name",
    //  "email", "image", "password", "last_active"]);
    List<Map> maps = await dbClient.rawQuery('SELECT * FROM user');
    List<User> users = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        users.add(User.fromMap(maps[i] ?? ''));
      }
    }
    return users;
  }

  // Delete Tuples
  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete("user", where: '"id" = ?', whereArgs: [id]);
  }

  // Update Tuples
  Future<int> update(User user) async {
    var dbClient = await db;
    return await dbClient.update("user", user.toMap(),
        where: '"id" = ?', whereArgs: [user.id]);
  }
}