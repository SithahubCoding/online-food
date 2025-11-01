
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

//   // 🔹 Toggle favorite
//   Future<void> toggleFavorite(FoodModel food) async { 
//     final exists = favoriteItems.any((f) => f.id == food.id);

//     if (exists) {
//       // 1. លុបចេញពី DB
//       await FavoriteDB.removeFavorite(food.id);
//       // 2. លុបចេញពី Reactive List (Update UI)
//       favoriteItems.removeWhere((f) => f.id == food.id);
//     } else {
//       // 1. បន្ថែមទៅ DB
//       await FavoriteDB.addFavorite(food);
//       // 2. បន្ថែមទៅ Reactive List (Update UI)
//       favoriteItems.add(food);
//     }
//   }

//   // 🔹 Check favorite by ID (ប្រើសម្រាប់ UI)
//   bool isFavorite(String foodId) {
//     return favoriteItems.any((f) => f.id == foodId);
//   }
// }

// import 'package:get/get.dart';
// import '../models/product_model.dart';
// import '../data/favorite_db.dart';

// class FavoriteController extends GetxController {
//   // បញ្ជី favorite products
//   var favorites = <FoodModel>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     loadFavorites(); // បញ្ចូល favorites ពេលចាប់ផ្ដើម
//   }

//   // ✅ Load favorites ពី database
//   Future<void> loadFavorites() async {
//     final favList = await FavoriteDB.getFavorites();
//     favorites.assignAll(favList);
//   }

//   // ✅ បន្ថែមទៅ favorites
//   Future<void> addFavorite(FoodModel food) async {
//     final exists = await FavoriteDB.isFavorite(food.id);
//     if (!exists) {
//       await FavoriteDB.addFavorite(food);
//       favorites.add(food);
//     }
//   }

//   // ✅ លុបពី favorites
//   Future<void> removeFavorite(String id) async {
//     await FavoriteDB.removeFavorite(id);
//     favorites.removeWhere((item) => item.id == id);
//   }

//   // ✅ ពិនិត្យថា product មួយមានក្នុង favorites ឬទេ
//   Future<bool> isFavorite(String id) async {
//     return await FavoriteDB.isFavorite(id);
//   }

//   // ✅ ប្តូរបានជាបន្ថែម/លុបស្វ័យប្រវត្តិ
//   Future<void> toggleFavorite(FoodModel food) async {
//     final isFav = await FavoriteDB.isFavorite(food.id);
//     if (isFav) {
//       await removeFavorite(food.id);
//     } else {
//       await addFavorite(food);
//     }
//   }
// }

// import 'package:get/get.dart';
// import '../models/product_model.dart';
// import '../data/favorite_db.dart';
// class FavoriteController extends GetxController {
//   var favorites = <FoodModel>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     loadFavorites();
//   }

//   // ✅ បន្ថែម getter ដើម្បីឲ្យ UI ប្រើ favoriteItems ដដែល
//   List<FoodModel> get favoriteItems => favorites;

//   Future<void> loadFavorites() async {
//     final items = await FavoriteDB.getFavorites();
//     favorites.assignAll(items);
//   }

//   Future<void> toggleFavorite(FoodModel food) async {
//     bool exists = favorites.any((f) => f.id == food.id);

//     if (exists) {
//       await FavoriteDB.removeFavorite(food.id);
//       favorites.removeWhere((f) => f.id == food.id);
//     } else {
//       await FavoriteDB.addFavorite(food);
//       favorites.add(food);
//     }
//   }

//   Future<bool> isFavorite(String id) async {
//     return await FavoriteDB.isFavorite(id);
//   }
// }

import 'package:get/get.dart';
import '../models/product_model.dart';
import '../data/favorite_db.dart';

class FavoriteController extends GetxController {
  var favoriteItems = <FoodModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  // Load favorites from local DB
  Future<void> loadFavorites() async {
    final items = await FavoriteDB.getFavorites();
    favoriteItems.assignAll(items);
  }

  // Toggle favorite
  Future<void> toggleFavorite(FoodModel food) async {
    final isFav = favoriteItems.any((f) => f.id == food.id);

    if (isFav) {
      await FavoriteDB.removeFavorite(food.id);
      favoriteItems.removeWhere((f) => f.id == food.id);
    } else {
      await FavoriteDB.addFavorite(food);
      favoriteItems.add(food);
    }

    favoriteItems.refresh(); // 🔥 បង្ខំអោយ Obx update UI
  }

  bool isFavorite(String id) {
    return favoriteItems.any((f) => f.id == id);
  }
}
