
import 'package:sqflite/sqflite.dart';

import '../model/MyOrderModel.dart';
import 'package:path/path.dart';
class OrderDatabase{
  static const int _version = 1;
  static const String _databaseName = "Orders2.db";
  static Future<Database> _getDatabase() async {

    return openDatabase(
        join(await getDatabasesPath(), _databaseName),
        onCreate: (db, version) async =>
        await db.execute('''
    CREATE TABLE $OrderTable(
    ${OrderFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${OrderFields.products} TEXT,
    ${OrderFields.adress} TEXT,
    ${OrderFields.phone} TEXT);
    '''
        ),
        version: _version
    );
  }

  static Future<int> add(MyOrderModel order) async {
    final db = await _getDatabase();
    return await db.insert(
        OrderTable,
        order.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<int> update(MyOrderModel order) async {
    final db = await _getDatabase();
    return await db.update(
      OrderTable,
      order.toJson(),
      where: 'id = ?',
      whereArgs: [order.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> delete(int id) async {
    final db = await _getDatabase();
    return await db.delete(
      OrderTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<MyOrderModel>?> getAll() async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(OrderTable);
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => MyOrderModel.fromJson(maps[index])
    );
  }
}

