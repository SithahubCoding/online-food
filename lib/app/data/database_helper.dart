
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
    return await openDatabase(path, version: 4, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // តារាង Products (រួមបញ្ចូល subCategory ដូចកូដដើមរបស់អ្នក)
    await db.execute('''
      CREATE TABLE products (
        id TEXT PRIMARY KEY, 
        name TEXT,
        description TEXT,
        category TEXT,
        subCategory TEXT,
        image TEXT,
        price REAL,
        rating REAL
      )
    ''');

    // តារាង Cart
    await db.execute('''
      CREATE TABLE cart (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productId TEXT, 
        quantity INTEGER
      )
    ''');

    // តារាង Orders
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

  // --- Product CRUD ---

  Future<void> insertProduct(FoodModel product) async {
    final db = await instance.database;
    // ធានាថា ID ត្រូវបានបំប្លែង និងបញ្ចូលតែបើសិនជា ID ត្រឹមត្រូវ
    if (int.tryParse(product.id) != null) { 
      await db.insert('products', product.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<List<FoodModel>> getProducts() async {
    final db = await instance.database;
    final maps = await db.query('products');
    return maps.map((map) => FoodModel.fromMap(map)).toList();
  }

  // --- Cart CRUD ---

  Future<void> addToCart(String productIdString, int quantity) async {
    final productId = int.tryParse(productIdString) ?? 0;
    
    final db = await instance.database;
    final existing = await db.query('cart', where: 'productId=?', whereArgs: [productId]);
    
    if (existing.isNotEmpty) {
      int currentQty = existing.first['quantity'] as int;
      await db.update('cart', {'quantity': currentQty + quantity}, 
                      where: 'productId=?', whereArgs: [productId]);
    } else {
      await db.insert('cart', {'productId': productId, 'quantity': quantity});
    }
  }

  // ✅ មុខងារ JOIN ដើម្បី Loading Cart ឱ្យមានប្រសិទ្ធភាព
  Future<List<Map<String, dynamic>>> getCartWithDetails() async {
    final db = await instance.database;
    final result = await db.rawQuery('''
      SELECT 
        T1.quantity, 
        T2.* FROM cart T1
      LEFT JOIN products T2 
      ON T1.productId = T2.id
    ''');
    return result; 
  }
  
  Future<List<Map<String,dynamic>>> getCart() async {
    final db = await instance.database;
    return await db.query('cart');
  }

  Future<void> removeCartItem(String productIdString) async {
    final productId = int.tryParse(productIdString) ?? 0;
    
    final db = await instance.database;
    await db.delete('cart', where: 'productId=?', whereArgs: [productId]);
  }

  Future<void> clearCart() async {
    final db = await instance.database;
    await db.delete('cart');
  }

  // --- Orders CRUD ---
  
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