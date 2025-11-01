
import 'dart:async';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/product_model.dart';

class CartController extends GetxController {
  // Observable lists for UI
  final RxList<FoodModel> items = <FoodModel>[].obs;
  final RxList<int> quantities = <int>[].obs;

  // Delivery / pricing
  final RxDouble deliveryFee = 5.0.obs;
  final Rx<LatLng?> deliveryLocation = Rx<LatLng?>(null);

  Database? _db;

  // --- Initialization & DB helper ---
  @override
  void onInit() {
    super.onInit();
    // load DB & cart
    initDb().then((_) => loadCart());
  }

  Future<void> initDb() async {
    if (_db != null) return;
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'app_cart.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cart (
            id TEXT PRIMARY KEY,
            name TEXT,
            image TEXT,
            description TEXT,
            category TEXT,
            subCategory TEXT,
            price REAL,
            rating REAL,
            quantity INTEGER
          )
        ''');
      },
    );
  }

  /// Load cart rows from sqlite into memory
  Future<void> loadCart() async {
    if (_db == null) await initDb();

    final rows = await _db!.query('cart');
    items.clear();
    quantities.clear();

    for (final row in rows) {
      final model = FoodModel.fromMap(row); // expects id as string
      final qty = (row['quantity'] as int?) ?? 1;
      items.add(model);
      quantities.add(qty);
    }
  }

  /// Add to cart (delta can be +1 or -1)
  Future<void> addToCart(FoodModel product, int delta) async {
    final idx = items.indexWhere((e) => e.id == product.id);
    if (idx == -1 && delta > 0) {
      // insert new
      items.add(product);
      quantities.add(delta);
      await _upsertLocal(product, delta);
    } else if (idx != -1) {
      final newQty = quantities[idx] + delta;
      if (newQty <= 0) {
        await removeItem(idx);
      } else {
        quantities[idx] = newQty;
        await _upsertLocal(items[idx], newQty);
      }
    }
  }

  /// Remove item at index
  Future<void> removeItem(int index) async {
    if (index < 0 || index >= items.length) return;
    final id = items[index].id;
    items.removeAt(index);
    quantities.removeAt(index);
    await _db?.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  /// Clear cart fully
  Future<void> clearCart() async {
    items.clear();
    quantities.clear();
    await _db?.delete('cart');
  }

  /// Upsert a cart item to sqlite (insert or update)
  Future<void> _upsertLocal(FoodModel product, int quantity) async {
    if (_db == null) await initDb();
    await _db!.insert(
      'cart',
      {
        ...product.toMap(), // contains id,name,image,...price,rating
        'quantity': quantity,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Replace cart content entirely (useful if loading from remote)
  Future<void> replaceCart(List<FoodModel> newItems, List<int> newQtys) async {
    if (newItems.length != newQtys.length) return;
    await _db?.transaction((txn) async {
      await txn.delete('cart');
      for (int i = 0; i < newItems.length; i++) {
        final product = newItems[i];
        final q = newQtys[i];
        await txn.insert('cart', {...product.toMap(), 'quantity': q});
      }
    });
    await loadCart();
  }

  /// Convenience getters
  double get totalPrice {
    double sum = 0.0;
    for (int i = 0; i < items.length; i++) {
      final price = items[i].price;
      final qty = (i < quantities.length) ? quantities[i] : 1;
      sum += price * qty;
    }
    return sum;
  }

  void setDeliveryLocation(LatLng loc) {
    deliveryLocation.value = loc;
  }

  // Save an order placeholder (you can implement upload to Firestore)
  Future<void> saveOrder(String paymentMethod, String transactionId) async {
    // Implement if needed: upload order to firestore, include items/qty, userId, etc.
  }
}
