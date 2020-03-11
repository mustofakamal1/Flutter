import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../database/user.dart';

class DBHelper {
  static Database _db;
  static const String DB_NAME = 'ecounter.db';

//  static const String UID = 'id';
//  static const String NAME = 'name';
//  static const String email = 'email';
//  static const String image = 'image';
//  static const String password = 'pass';
//  static const String role = 'role';
//  static const String TABLE = 'user';
//
//  static const String OID = 'id';
//  static const String NUMBER = 'number';
//  static const String PID = 'pid';


//
//  static const String ID = 'id';
//  static const String NAME = 'name';
//  static const String TABLE = 'User';
  // Check Database
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }
  // Create Database
  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  // Create Table
  _onCreate(Database db, int version) async {
//    await db.execute("CREATE TABLE role (""id INTEGER PRIMARY KEY,"
//        "role TEXT"")");
//    await db.execute("CREATE TABLE user_role (""id INTEGER PRIMARY KEY,"
//        "uid INTEGER," "rid INTEGER"")");
    await db.execute("CREATE TABLE user (""id INTEGER PRIMARY KEY,"
        "name TEXT," "email TEXT," "image TEXT," "password TEXT,"
        "last_active TEXT"")");
//    await db.execute("CREATE TABLE order (""id INTEGER PRIMARY KEY,"
//        "number INTEGER," "pid INTEGER," "jid INTEGER," "nominal INTEGER,"
//        "order_date TEXT"")");
//    await db.execute("CREATE TABLE stock (""id INTEGER PRIMARY KEY,"
//        "nominal TEXT," "quantity INTEGER," "price INTEGER,"
//        "last_update TEXT"")");
//    await db.execute("CREATE TABLE stock_category (""id INTEGER PRIMARY KEY,"
//        "pid INTEGER," "jid INTEGER"")");
//    await db.execute("CREATE TABLE type (""id INTEGER PRIMARY KEY," "type TEXT"")");
//    await db.execute("CREATE TABLE provider (""id INTEGER PRIMARY KEY," "provider TEXT"")");
  }
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

  // Close Database
  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
