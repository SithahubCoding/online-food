import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/language_controller.dart';
import '../controllers/cart_controllrt.dart';
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
