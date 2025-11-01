import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'my_shop.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products(
        id TEXT PRIMARY KEY,
        name TEXT,
        price REAL,
        category TEXT,
        description TEXT,
        image TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE cart(
        productId TEXT PRIMARY KEY,
        quantity INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE orders(
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

  // ------------------------- Cart CRUD -------------------------
  Future<void> addToCart(String productId, int quantity) async {
    final db = await instance.database;

    final existing = await db.query('cart', where: 'productId = ?', whereArgs: [productId]);

    if (existing.isNotEmpty) {
      int newQty = (existing.first['quantity'] as int) + quantity;
      if (newQty > 0) {
        await db.update('cart', {'quantity': newQty}, where: 'productId = ?', whereArgs: [productId]);
      } else {
        await removeCartItem(productId);
      }
    } else {
      if (quantity > 0) {
        await db.insert('cart', {'productId': productId, 'quantity': quantity});
      }
    }
  }

  Future<void> updateCartItem(String productId, int quantity) async {
    final db = await instance.database;
    if (quantity > 0) {
      await db.update('cart', {'quantity': quantity}, where: 'productId = ?', whereArgs: [productId]);
    } else {
      await removeCartItem(productId);
    }
  }

  Future<void> removeCartItem(String productId) async {
    final db = await instance.database;
    await db.delete('cart', where: 'productId = ?', whereArgs: [productId]);
  }

  Future<void> clearCart() async {
    final db = await instance.database;
    await db.delete('cart');
  }

  Future<List<Map<String, dynamic>>> getCartWithDetails() async {
    final db = await instance.database;
    final result = await db.rawQuery('''
      SELECT cart.quantity, products.*
      FROM cart
      LEFT JOIN products ON cart.productId = products.id
    ''');
    return result;
  }

  // ------------------------- Orders CRUD -------------------------
  Future<void> insertOrder(Map<String, dynamic> order) async {
    final db = await instance.database;
    await db.insert('orders', order);
  }
  Future<void> deleteOrder(int id) async {
  final db = await instance.database;
  await db.delete(
    'orders',
    where: 'id = ?',
    whereArgs: [id],
  );
}
  Future<List<Map<String, dynamic>>> getOrders() async {
    final db = await instance.database;
    return await db.query('orders', orderBy: 'id DESC');
  }

  // ------------------------- Close DB -------------------------
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

// import 'dart:async';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseHelper {
//   DatabaseHelper._privateConstructor();
//   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

//   static Database? _database;

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, 'my_shop.db');

//     return await openDatabase(path, version: 1, onCreate: _onCreate);
//   }

//   Future _onCreate(Database db, int version) async {
//     // ------------------------- Users Table -------------------------
//     await db.execute('''
//       CREATE TABLE users(
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         name TEXT,
//         email TEXT,
//         role TEXT, -- user, seller, admin
//         address TEXT,
//         profileImage TEXT
//       )
//     ''');

//     // ------------------------- Seller Requests Table -------------------------
//     await db.execute('''
//       CREATE TABLE seller_requests(
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         userId INTEGER,
//         name TEXT,
//         email TEXT,
//         phone TEXT,
//         address TEXT,
//         shopName TEXT,
//         card TEXT,
//         status TEXT, -- pending, approved, rejected
//         submittedAt TEXT
//       )
//     ''');

//     // ------------------------- Products Table -------------------------
//     await db.execute('''
//       CREATE TABLE products(
//         id TEXT PRIMARY KEY,
//         name TEXT,
//         price REAL,
//         category TEXT,
//         description TEXT,
//         image TEXT
//       )
//     ''');

//     // ------------------------- Cart Table -------------------------
//     await db.execute('''
//       CREATE TABLE cart(
//         productId TEXT PRIMARY KEY,
//         quantity INTEGER
//       )
//     ''');

//     // ------------------------- Orders Table -------------------------
//     await db.execute('''
//       CREATE TABLE orders(
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         items TEXT,
//         total REAL,
//         deliveryLat REAL,
//         deliveryLng REAL,
//         paymentMethod TEXT,
//         transactionId TEXT,
//         createdAt TEXT
//       )
//     ''');
//   }

//   // ------------------------- Users CRUD -------------------------
//   Future<int> addUser(String name, String email, String address, String role, {String? profileImage}) async {
//     final db = await database;
//     return await db.insert('users', {
//       'name': name,
//       'email': email,
//       'address': address,
//       'role': role,
//       'profileImage': profileImage ?? '',
//     });
//   }

//   Future<List<Map<String, dynamic>>> getUsers() async {
//     final db = await database;
//     return await db.query('users');
//   }

//   Future<void> updateUserRole(int id, String role) async {
//     final db = await database;
//     await db.update('users', {'role': role}, where: 'id = ?', whereArgs: [id]);
//   }

//   Future<void> deleteUser(int id) async {
//     final db = await database;
//     await db.delete('users', where: 'id = ?', whereArgs: [id]);
//   }

//   // ------------------------- Seller Requests CRUD -------------------------
//   Future<int> addSellerRequest({
//     required int userId,
//     required String shopName,
//     required String submittedAt,
//     required String name,
//     required String email,
//     required String phone,
//     required String address,
//     required String card,
//   }) async {
//     final db = await database;
//     return await db.insert('seller_requests', {
//       'userId': userId,
//       'name': name,
//       'email': email,
//       'phone': phone,
//       'address': address,
//       'shopName': shopName,
//       'card': card,
//       'status': 'pending',
//       'submittedAt': submittedAt,
//     });
//   }

//   Future<List<Map<String, dynamic>>> getSellerRequests() async {
//     final db = await database;
//     return await db.query('seller_requests');
//   }

//   Future<void> updateSellerRequestStatus(int id, String status) async {
//     final db = await database;
//     await db.update(
//       'seller_requests',
//       {'status': status},
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }

//   Future<void> deleteSellerRequest(int id) async {
//     final db = await database;
//     await db.delete('seller_requests', where: 'id = ?', whereArgs: [id]);
//   }

//   // ------------------------- Existing CRUD (Cart & Orders) -------------------------
//   Future<void> addToCart(String productId, int quantity) async {
//     final db = await database;
//     final existing = await db.query('cart', where: 'productId = ?', whereArgs: [productId]);
//     if (existing.isNotEmpty) {
//       int newQty = (existing.first['quantity'] as int) + quantity;
//       if (newQty > 0) {
//         await db.update('cart', {'quantity': newQty}, where: 'productId = ?', whereArgs: [productId]);
//       } else {
//         await removeCartItem(productId);
//       }
//     } else {
//       if (quantity > 0) {
//         await db.insert('cart', {'productId': productId, 'quantity': quantity});
//       }
//     }
//   }

//   Future<void> removeCartItem(String productId) async {
//     final db = await database;
//     await db.delete('cart', where: 'productId = ?', whereArgs: [productId]);
//   }

//   Future<List<Map<String, dynamic>>> getCartWithDetails() async {
//     final db = await database;
//     return await db.rawQuery('''
//       SELECT cart.quantity, products.*
//       FROM cart
//       LEFT JOIN products ON cart.productId = products.id
//     ''');
//   }

//   Future<void> insertOrder(Map<String, dynamic> order) async {
//     final db = await database;
//     await db.insert('orders', order);
//   }

//   Future<void> deleteOrder(int id) async {
//     final db = await instance.database;
//     await db.delete('orders', where: 'id = ?', whereArgs: [id]);
//   }

//   Future<List<Map<String, dynamic>>> getOrders() async {
//     final db = await database;
//     return await db.query('orders', orderBy: 'id DESC');
//   }

//   Future close() async {
//     final db = await database;
//     db.close();
//   }
// }
