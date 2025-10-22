import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product_model.dart';

class FavoriteDB {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'favorite.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorites(
            id INTEGER PRIMARY KEY,
            name TEXT,
            image TEXT,
            description TEXT,
            category TEXT,
            price REAL,
            rating REAL
          )
        ''');
      },
    );
  }

  static Future<void> addFavorite(FoodModel food) async {
    final db = await database;
    await db.insert(
      'favorites',
      food.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> removeFavorite(int id) async {
    final db = await database;
    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<FoodModel>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');
    return List.generate(maps.length, (i) => FoodModel.fromMap(maps[i]));
  }

  static Future<bool> isFavorite(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('favorites', where: 'id = ?', whereArgs: [id]);
    return maps.isNotEmpty;
  }
}
