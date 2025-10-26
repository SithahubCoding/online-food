
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/product_model.dart';
import '../data/database_helper.dart';

class CartController extends GetxController {
  /// Cart items and their quantities
  var items = <FoodModel>[].obs;
  var quantities = <int>[].obs;

  /// Selected delivery location
  var deliveryLocation = Rx<LatLng?>(null);

  /// Delivery fee (can be dynamic later)
  var deliveryFee = 5.0.obs;

  /// Total price of all items
  double get totalPrice {
    double total = 0;
    for (int i = 0; i < items.length; i++) {
      total += items[i].price * quantities[i];
    }
    return total;
  }

  /// Load cart from SQLite (with JOIN for product details)
  Future<void> loadCart() async {
    final cartDataWithDetails = await DatabaseHelper.instance.getCartWithDetails();

    items.clear();
    quantities.clear();

    for (var entry in cartDataWithDetails) {
      final product = FoodModel.fromMap(entry);
      final quantity = entry['quantity'] as int;

      items.add(product);
      quantities.add(quantity);
    }
  }

  /// Add product to cart (+1, -1)
  Future<void> addToCart(FoodModel product, [int quantity = 1]) async {
    // Ensure product exists in products table
    await DatabaseHelper.instance.insertProduct(product);

    // Update cart quantity in DB (insert or update)
    await DatabaseHelper.instance.addToCart(product.id, quantity);

    // Refresh cart UI
    await loadCart();
  }

  /// Remove item completely from cart by index
  Future<void> removeItem(int index) async {
    if (index >= 0 && index < items.length) {
      final productId = items[index].id;

      // Remove from SQLite
      await DatabaseHelper.instance.removeCartItem(productId);

      // Remove from observable lists
      items.removeAt(index);
      quantities.removeAt(index);
    }
  }

  /// Set delivery location
  void setDeliveryLocation(LatLng location) {
    deliveryLocation.value = location;
  }

  /// Clear cart completely
  Future<void> clearCart() async {
    items.clear();
    quantities.clear();
    await DatabaseHelper.instance.clearCart();
  }

  /// Save order to SQLite
  Future<void> saveOrder(String paymentMethod, String transactionId) async {
    final orderItems = List.generate(items.length, (i) => {
          "id": items[i].id,
          "name": items[i].name,
          "price": items[i].price,
          "quantity": quantities[i],
        });

    await DatabaseHelper.instance.insertOrder({
      "items": orderItems.toString(),
      "total": totalPrice + deliveryFee.value,
      "deliveryLat": deliveryLocation.value?.latitude,
      "deliveryLng": deliveryLocation.value?.longitude,
      "paymentMethod": paymentMethod,
      "transactionId": transactionId,
      "createdAt": DateTime.now().toIso8601String(),
    });

    await clearCart();
  }
}
