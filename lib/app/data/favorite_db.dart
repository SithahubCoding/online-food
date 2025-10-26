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
      version: 2,
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
        if (oldVersion == 1) {
          await db.execute('DROP TABLE IF EXISTS favorites_old;');
          await db.execute('ALTER TABLE favorites RENAME TO favorites_old;');
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
          final oldData = await db.query('favorites_old');
          for (var row in oldData) {
            await db.insert('favorites', {
              'id': row['id'].toString(),
              'name': row['name'],
              'image': row['image'],
              'description': row['description'],
              'category': row['category'],
              'subCategory': row['subCategory'],
              'price': row['price'],
              'rating': row['rating'],
            });
          }
          await db.execute('DROP TABLE favorites_old;');
        }
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

  static Future<void> removeFavorite(String id) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<FoodModel>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');
    return List.generate(maps.length, (i) => FoodModel.fromMap(maps[i]));
  }

  static Future<bool> isFavorite(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty;
  }
}
