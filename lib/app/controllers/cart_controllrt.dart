// import 'package:get/get.dart';
// import '../models/product_model.dart';
// import '../data/database_helper.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class CartController extends GetxController {
//   var items = <FoodModel>[].obs;
//   var quantities = <int>[].obs;
//   var deliveryLocation = Rx<LatLng?>(null);
//   var deliveryFee = 5.0.obs;

//   double get totalPrice {
//     double total = 0;
//     for (int i = 0; i < items.length; i++) {
//       total += items[i].price * quantities[i];
//     }
//     return total;
//   }

//   // Load cart from DB
//   Future<void> loadCartFromDB() async {
//     final cartData = await DatabaseHelper.instance.getCart();
//     final products = await DatabaseHelper.instance.getProducts();

//     items.clear();
//     quantities.clear();

//     for (var entry in cartData) {
//       final productId = entry['productId'] as int;
//       final quantity = entry['quantity'] as int;
//       final product = products.firstWhere(
//         (p) => p.id == productId,
//         orElse: () => FoodModel(
//           id: productId,
//           name: 'Unknown',
//           description: '',
//           category: '',
//           image: '',
//           price: 0.0,
//           rating: 0.0,
//         ),
//       );
//       items.add(product);
//       quantities.add(quantity);
//     }
//   }

//   Future<void> addToCart(FoodModel product, [int quantity = 1]) async {
//     int index = items.indexWhere((p) => p.id == product.id);
//     if (index != -1) {
//       quantities[index] += quantity;
//     } else {
//       items.add(product);
//       quantities.add(quantity);
//     }
//     await DatabaseHelper.instance.insertProduct(product);
//     await DatabaseHelper.instance.addToCart(product.id, quantity);
//     update();
//   }

//   Future<void> removeItem(int index) async {
//     final productId = items[index].id;
//     items.removeAt(index);
//     quantities.removeAt(index);
//     await DatabaseHelper.instance.removeCartItem(productId);
//     update();
//   }

//   void setDeliveryLocation(LatLng location) {
//     deliveryLocation.value = location;
//     update();
//   }

//   Future<void> clearCart() async {
//     items.clear();
//     quantities.clear();
//     await DatabaseHelper.instance.clearCart();
//     update();
//   }

//   // Save order to SQLite / Firestore
//   Future<void> saveOrder(String paymentMethod, String transactionId) async {
//     final orderItems = List.generate(items.length, (i) => {
//           "id": items[i].id,
//           "name": items[i].name,
//           "price": items[i].price,
//           "quantity": quantities[i],
//         });

//     await DatabaseHelper.instance.insertOrder({
//       "items": orderItems.toString(),
//       "total": totalPrice + deliveryFee.value,
//       "deliveryLat": deliveryLocation.value?.latitude,
//       "deliveryLng": deliveryLocation.value?.longitude,
//       "paymentMethod": paymentMethod,
//       "transactionId": transactionId,
//       "createdAt": DateTime.now().toIso8601String(),
//     });

//     await clearCart();
//   }
// }

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/product_model.dart';
import '../data/database_helper.dart';

class CartController extends GetxController {
  var items = <FoodModel>[].obs;
  var quantities = <int>[].obs;
  var deliveryLocation = Rx<LatLng?>(null);
  var deliveryFee = 5.0.obs;

  double get totalPrice {
    double total = 0;
    for (int i = 0; i < items.length; i++) {
      total += items[i].price * quantities[i];
    }
    return total;
  }

  /// Load cart from SQLite
  Future<void> loadCart() async {
    final cartData = await DatabaseHelper.instance.getCart();
    final products = await DatabaseHelper.instance.getProducts();

    items.clear();
    quantities.clear();

    for (var entry in cartData) {
      final productId = entry['productId'] as int;
      final quantity = entry['quantity'] as int;
      final product = products.firstWhere(
        (p) => p.id == productId,
        orElse: () => FoodModel(
          id: productId,
          name: 'Unknown',
          description: '',
          category: '',
          image: '',
          price: 0.0,
          rating: 0.0,
        ),
      );
      items.add(product);
      quantities.add(quantity);
    }
  }

  /// Add product to cart
  Future<void> addToCart(FoodModel product, [int quantity = 1]) async {
    int index = items.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      quantities[index] += quantity;
    } else {
      items.add(product);
      quantities.add(quantity);
    }
    await DatabaseHelper.instance.insertProduct(product);
    await DatabaseHelper.instance.addToCart(product.id, quantity);
  }

  /// Remove item
  Future<void> removeItem(int index) async {
    final productId = items[index].id;
    items.removeAt(index);
    quantities.removeAt(index);
    await DatabaseHelper.instance.removeCartItem(productId);
  }

  /// Set delivery location
  void setDeliveryLocation(LatLng location) {
    deliveryLocation.value = location;
  }

  /// Clear cart
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
