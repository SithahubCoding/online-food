// import 'package:get/get.dart';
// import '../data/favorite_db.dart';
// import '../models/product_model.dart';

// class FavoriteController extends GetxController {
//   var favoriteItems = <FoodModel>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     loadFavorites();
//   }

//   Future<void> loadFavorites() async {
//     final data = await FavoriteDB.getFavorites();
//     favoriteItems.assignAll(data);
//   }

//   Future<void> toggleFavorite(FoodModel food) async {
//     final exists = await FavoriteDB.isFavorite(food.id);

//     if (exists) {
//       await FavoriteDB.removeFavorite(food.id);
//       favoriteItems.removeWhere((f) => f.id == food.id);
//     } else {
//       await FavoriteDB.addFavorite(food);
//       favoriteItems.add(food);
//     }
//   }

//   Future<bool> isFavorite(FoodModel food) async {
//     return await FavoriteDB.isFavorite(food.id);
//   }
// }


// import 'package:get/get.dart';
// import '../data/favorite_db.dart';
// import '../models/product_model.dart';

// class FavoriteController extends GetxController {
//   var favoriteItems = <FoodModel>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     loadFavorites();
//   }

//   Future<void> loadFavorites() async {
//     final data = await FavoriteDB.getFavorites();
//     favoriteItems.assignAll(data);
//   }

//   Future<void> toggleFavorite(FoodModel food) async {
//     final exists = await FavoriteDB.isFavorite(food.id);

//     if (exists) {
//       await FavoriteDB.removeFavorite(food.id);
//       favoriteItems.removeWhere((f) => f.id == food.id);
//     } else {
//       await FavoriteDB.addFavorite(food);
//       favoriteItems.add(food);
//     }
//   }

//   Future<bool> isFavorite(FoodModel food) async {
//     return await FavoriteDB.isFavorite(food.id);
//   }
// }

// ឯកសារ: favorite_controller.dart

import 'package:get/get.dart';
import '../data/favorite_db.dart';
// ⚠️ ខ្ញុំសន្មត់ថា product_model.dart គឺជាឯកសារដែលមាន FoodModel
import '../models/product_model.dart'; 

class FavoriteController extends GetxController {
  // ខ្ញុំសន្មត់ថា ProductModel គឺសំដៅលើ FoodModel
  var favoriteItems = <FoodModel>[].obs; 

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  // 🔹 Load favorites from local DB
  Future<void> loadFavorites() async {
    final data = await FavoriteDB.getFavorites();
    favoriteItems.assignAll(data);
  }

  // 🔹 Toggle favorite
  Future<void> toggleFavorite(FoodModel food) async { 
    // ✅ ដំណោះស្រាយ: ប្រើ .any() លើ favoriteItems (Obs) ដើម្បីឆែកមើលក្នុង memory
    final exists = favoriteItems.any((f) => f.id == food.id);

    if (exists) {
      // 1. លុបចេញពី DB
      await FavoriteDB.removeFavorite(food.id);
      // 2. លុបចេញពី Reactive List (Update UI)
      favoriteItems.removeWhere((f) => f.id == food.id);
    } else {
      // 1. បន្ថែមទៅ DB
      await FavoriteDB.addFavorite(food);
      // 2. បន្ថែមទៅ Reactive List (Update UI)
      favoriteItems.add(food);
    }
  }

  // 🔹 Check favorite by ID (ប្រើសម្រាប់ UI)
  bool isFavorite(String foodId) {
    return favoriteItems.any((f) => f.id == foodId);
  }
}