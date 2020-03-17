import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

class DBHelper {
  static Database _db;
  static const String DB_NAME = 'ecounter.db';
  String NOW = new DateFormat('kk:mm:ss \n EEE d MMM').format(DateTime.now());

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
    await db.execute('''
      CREATE TABLE user (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        image TEXT,
        password TEXT,
        lastActive TEXT
      )
      ''');
    await db.execute('''
      CREATE TABLE role (
        id INTEGER PRIMARY KEY,
        role TEXT
        )
        ''');
    await db.execute('''
    CREATE TABLE user_role (
      id INTEGER PRIMARY KEY,
      uid INTEGER,
      rid INTEGER
      )
      ''');
//    await db.execute('''
//    CREATE TABLE order (
//      id INTEGER PRIMARY KEY AUTOINCREMENT,
//      number TEXT,
//      pid INTEGER,
//      jid INTEGER,
//      nominal INTEGER,
//      order_date TEXT
//      )
//      ''');
    await db.execute('''
      CREATE TABLE stock (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nominal TEXT,
        quantity INTEGER,
        price INTEGER,
        last_update TEXT
        )
        ''');
    await db.execute('''
    CREATE TABLE stock_category 
    (
    id INTEGER PRIMARY KEY,
    pid INTEGER,
    jid INTEGER
    )
    ''');
    await db.execute('''
    CREATE TABLE type 
    (
    id INTEGER PRIMARY KEY,
    type TEXT
    )
    ''');
    await db.execute('''
    CREATE TABLE provider 
    (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    provider TEXT
    )
    ''');

    //Data Init
    await db.execute('''
      INSERT INTO user (name, password, lastActive) VALUES (
      "root", "root", "$NOW"
      )
      ''');
    await db.execute('''
      INSERT INTO role VALUES (
      1, "Admin"), (
      2, "User"
      )
      ''');
//    await db.execute('''
//      INSERT INTO order VALUES (
//      1, "085155499891", 1, 1, 100000, "$NOW"
//      )
//      ''');
//    await db.execute('''
//      INSERT INTO user_role VALUES (
//      1, 1, 1
//      )
//      ''');
  }
  // Close Database
  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
