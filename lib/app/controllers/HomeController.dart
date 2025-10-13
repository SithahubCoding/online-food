import 'package:get/get.dart';
import '../models/food_model.dart';
class HomeController extends GetxController{
  var selectedCategory = 'Burger'.obs;
  var popularFoodList = <FoodModel>[].obs;
  var categories = <CategoryModel>[].obs;
  @override
  void onInit(){
    super.onInit();
  }
}
