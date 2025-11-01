
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import '../models/product_model.dart';

// class FavoriteDB {
//   static Database? _db;

//   static Future<Database> get database async {
//     if (_db != null) return _db!;
//     _db = await _initDB();
//     return _db!;
//   }

//   static Future<Database> _initDB() async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, 'favorite.db');

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute('''
//           CREATE TABLE favorites(
//             id TEXT PRIMARY KEY,
//             name TEXT,
//             image TEXT,
//             description TEXT,
//             category TEXT,
//             subCategory TEXT,
//             price REAL,
//             rating REAL
//           )
//         ''');
//       },
//     );
//   }

//   static Future<void> addFavorite(FoodModel food) async {
//     final db = await database;
//     await db.insert(
//       'favorites',
//       food.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   static Future<void> removeFavorite(String id) async {
//     final db = await database;
//     await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
//   }

//   static Future<List<FoodModel>> getFavorites() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('favorites');
//     return maps.map((e) => FoodModel.fromMap(e)).toList();
//   }

//   static Future<bool> isFavorite(String id) async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps =
//         await db.query('favorites', where: 'id = ?', whereArgs: [id]);
//     return maps.isNotEmpty;
//   }
// }

// import 'dart:io';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import '../models/product_model.dart';

// class FavoriteDB {
//   static Database? _db;

//   static Future<Database> get database async {
//     if (_db != null) return _db!;
//     _db = await _initDB();
//     return _db!;
//   }

//   // ✅ កែត្រឹមត្រូវ៖ បង្កើត database path ប្រសិនបើមិនមាន
//   static Future<Database> _initDB() async {
//     final dbPath = await getDatabasesPath();
//     await Directory(dbPath).create(recursive: true); // ensure folder exists
//     final path = join(dbPath, 'favorite.db');

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute('''
//           CREATE TABLE favorites(
//             id TEXT PRIMARY KEY,
//             name TEXT,
//             image TEXT,
//             description TEXT,
//             category TEXT,
//             subCategory TEXT,
//             price REAL,
//             rating REAL
//           )
//         ''');
//       },
//     );
//   }

//   // ✅ ការបន្ថែម favorite
//   static Future<void> addFavorite(FoodModel food) async {
//     final db = await database;
//     await db.insert(
//       'favorites',
//       food.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   // ✅ ការលុប favorite ត្រឡប់ជា int (ចំនួន row)
//   static Future<int> removeFavorite(String id) async {
//     final db = await database;
//     return await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
//   }

//   // ✅ ការទាញយក favorites ទាំងអស់
//   static Future<List<FoodModel>> getFavorites() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('favorites');
//     return maps.map((e) => FoodModel.fromMap(e)).toList();
//   }

//   // ✅ ពិនិត្យថា product មានក្នុង favorite ឬអត់
//   static Future<bool> isFavorite(String id) async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps =
//         await db.query('favorites', where: 'id = ?', whereArgs: [id]);
//     return maps.isNotEmpty;
//   }
// }

import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product_model.dart';

class FavoriteDB {
  static Database? _db;

  // បង្កើត database version = 2 ដើម្បី add subCategory column
  static const int _dbVersion = 2;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    await Directory(dbPath).create(recursive: true); // ensure folder exists
    final path = join(dbPath, 'favorite.db');

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorites(
            id TEXT PRIMARY KEY,
            name TEXT,
            image TEXT,
            description TEXT,
            category TEXT,
            subCategory TEXT,
            price REAL,
            rating REAL
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // បើ database ចាស់ version < 2 → បន្ថែម subCategory
        if (oldVersion < 2) {
          try {
            await db.execute('ALTER TABLE favorites ADD COLUMN subCategory TEXT');
          } catch (e) {
            print('Column subCategory មានរួចហើយ: $e');
          }
        }
      },
    );
  }

  // ------------------------- CRUD -------------------------
  static Future<void> addFavorite(FoodModel food) async {
    final db = await database;
    await db.insert(
      'favorites',
      food.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> removeFavorite(String id) async {
    final db = await database;
    return await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<FoodModel>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');
    return maps.map((e) => FoodModel.fromMap(e)).toList();
  }

  static Future<bool> isFavorite(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('favorites', where: 'id = ?', whereArgs: [id]);
    return maps.isNotEmpty;
  }
}
