import 'package:get/get.dart';
import '../data/favorite_db.dart';
import '../models/product_model.dart';

class FavoriteController extends GetxController {
  var favoriteItems = <FoodModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final data = await FavoriteDB.getFavorites();
    favoriteItems.assignAll(data);
  }

  Future<void> toggleFavorite(FoodModel food) async {
    final exists = await FavoriteDB.isFavorite(food.id);

    if (exists) {
      await FavoriteDB.removeFavorite(food.id);
      favoriteItems.removeWhere((f) => f.id == food.id);
    } else {
      await FavoriteDB.addFavorite(food);
      favoriteItems.add(food);
    }
  }

  Future<bool> isFavorite(FoodModel food) async {
    return await FavoriteDB.isFavorite(food.id);
  }
}
