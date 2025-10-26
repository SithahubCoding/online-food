import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart'; // បញ្ជាក់ path របស់អ្នក

class ProductController extends GetxController {
  // RxList ដើម្បី observe changes
  var productList = <FoodModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() {
    FirebaseFirestore.instance.collection('product_db').snapshots().listen((snapshot) {
      var tempList = snapshot.docs.map((doc) {
        final data = doc.data();
        return FoodModel(
          id: doc.id, 
          name: data['name'] ?? '',
          description: data['description'] ?? '',
          price: (data['price'] ?? 0).toDouble(),
          category: data['category'] ?? '',
          subCategory: data['subCategory'] ?? '',
          image: data['image'] ?? '',
          rating: (data['rating'] ?? 0).toDouble(),
        );
      }).toList();

      productList.value = tempList;
    });
  }
}
