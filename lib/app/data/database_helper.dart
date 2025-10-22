import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 2, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY,
        name TEXT,
        description TEXT,
        category TEXT,
        image TEXT,
        price REAL,
        rating REAL
      )
    ''');

    await db.execute('''
      CREATE TABLE cart (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productId INTEGER,
        quantity INTEGER
      )
    ''');

    // Orders Table
    await db.execute('''
      CREATE TABLE orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        items TEXT,
        total REAL,
        deliveryLat REAL,
        deliveryLng REAL,
        paymentMethod TEXT,
        transactionId TEXT,
        createdAt TEXT
      )
    ''');
  }

  // Product & Cart CRUD...
  Future<void> insertProduct(FoodModel product) async {
    final db = await instance.database;
    await db.insert('products', product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<FoodModel>> getProducts() async {
    final db = await instance.database;
    final maps = await db.query('products');
    return maps.map((map) => FoodModel.fromMap(map)).toList();
  }

  Future<void> addToCart(int productId, int quantity) async {
    final db = await instance.database;
    final existing = await db.query('cart', where: 'productId=?', whereArgs: [productId]);
    if (existing.isNotEmpty) {
      int currentQty = existing.first['quantity'] as int;
      await db.update('cart', {'quantity': currentQty + quantity}, where: 'productId=?', whereArgs: [productId]);
    } else {
      await db.insert('cart', {'productId': productId, 'quantity': quantity});
    }
  }

  Future<List<Map<String,dynamic>>> getCart() async {
    final db = await instance.database;
    return await db.query('cart');
  }

  Future<void> removeCartItem(int productId) async {
    final db = await instance.database;
    await db.delete('cart', where: 'productId=?', whereArgs: [productId]);
  }

  Future<void> clearCart() async {
    final db = await instance.database;
    await db.delete('cart');
  }

  // ✅ Orders
  Future<void> insertOrder(Map<String, dynamic> order) async {
    final db = await instance.database;
    await db.insert('orders', order);
  }

  Future<List<Map<String,dynamic>>> getOrders() async {
    final db = await instance.database;
    return await db.query('orders', orderBy: 'id DESC');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
