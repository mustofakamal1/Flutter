import 'DBHelper.dart';
import '../database/order.dart';

class OrderSql extends DBHelper {

  DBHelper oHelper = new DBHelper();

  //Insert Tuples
  Future<Order> save(Order order) async {
    var dbClient = await db;
    order.id = await dbClient.insert("order", order.toMap());
    return order;
  }

  // Select Tuples
  Future<List<Order>> getOrders() async {
    var dbClient = await db;
    //List<Map> maps = await dbClient.query("order", columns: ["id", "name",
    //  "email", "image", "password", "last_active"]);
    List<Map> maps = await dbClient.rawQuery('SELECT * FROM order');
    List<Order> orders = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        orders.add(Order.fromMap(maps[i] ?? ''));
      }
    }
    return orders;
  }

  // Delete Tuples
  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete("order", where: '"id" = ?', whereArgs: [id]);
  }

  // Update Tuples
  Future<int> update(Order order) async {
    var dbClient = await db;
    return await dbClient.update("order", order.toMap(),
        where: '"id" = ?', whereArgs: [order.id]);
  }
}