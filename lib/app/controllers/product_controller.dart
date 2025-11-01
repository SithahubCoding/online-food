// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/product_model.dart'; // បញ្ជាក់ path របស់អ្នក

// class ProductController extends GetxController {
//   // RxList ដើម្បី observe changes
//   var productList = <FoodModel>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchProducts();
//   }

//   void fetchProducts() {
//     FirebaseFirestore.instance.collection('product_db').snapshots().listen((snapshot) {
//       var tempList = snapshot.docs.map((doc) {
//         final data = doc.data();
//         return FoodModel(
//           id: doc.id, 
//           name: data['name'] ?? '',
//           description: data['description'] ?? '',
//           price: (data['price'] ?? 0).toDouble(),
//           category: data['category'] ?? '',
//           subCategory: data['subCategory'] ?? '',
//           image: data['image'] ?? '',
//           rating: (data['rating'] ?? 0).toDouble(),
//         );
//       }).toList();

//       productList.value = tempList;
//     });
//   }
// }

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class ProductController extends GetxController {
  // List of products
  var productList = <FoodModel>[].obs;

  // Loading state (optional but useful)
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  /// Fetch all products from Firestore in real time
  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      // Listen to realtime updates
      FirebaseFirestore.instance
          .collection('product_db')
          .snapshots()
          .listen((snapshot) {
        var tempList = snapshot.docs.map((doc) {
          final data = doc.data();
          return FoodModel(
            id: doc.id,
            name: data['name'] ?? '',
            description: data['description'] ?? '',
            price: _toDouble(data['price']),
            category: data['category'] ?? '',
            subCategory: data['subCategory'] ?? '',
            image: data['image'] ?? '',
            rating: _toDouble(data['rating']),
          );
        }).toList();

        productList.value = tempList;
      });
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Helper: convert dynamic to double safely
  double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }

  /// Filter function by category or search query
  List<FoodModel> filterByCategory(String category) {
    return productList
        .where((item) => item.category.toLowerCase() == category.toLowerCase())
        .toList();
  }
}
