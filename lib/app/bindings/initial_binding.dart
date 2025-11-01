import 'package:get/get.dart';
import '../controllers/user_auth_controller.dart';
import '../controllers/language_controller.dart';
import '../controllers/cart_controller.dart';
import '../controllers/favorite_controller.dart';
class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.put(LanguageController());
    Get.put(CartController());
    Get.put(FavoriteController());
  }
}
