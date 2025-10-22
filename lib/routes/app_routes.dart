import 'package:get/get.dart';
import '../app/views/home/home_screen.dart';
import '../app/views/category_screen.dart';
import '../app/views/favorite_screen.dart';
// import '../app/views/detail_screen.dart';
import '../app/views/profile_screen.dart';
import '../app/views/notification_screen.dart';
import '../app/views/policy_privacy_screen.dart';
import '../app/views/cart_screen.dart';
import '../app/views/auth/login_screen.dart';
// import 'app_routes.dart';

class AppRoutes {
  static const home = '/';
  static const category = '/category';
  static const favorite = '/favorite';
  static const profile = '/profile';
  static const notification = '/notification';
  static const policyPrivacy = '/policy_privacy';
  static const cart = '/cart';
  static const login = '/login';
  static const detail = '/detail';
}

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.home, page: () => const HomeScreen()),
    GetPage(name: AppRoutes.category, page: () => CategoryScreen()),
    GetPage(name: AppRoutes.favorite, page: () => FavoriteScreen()),
    GetPage(name: AppRoutes.profile, page: () => ProfileScreen()),
    GetPage(name: AppRoutes.notification, page: () => NotificationScreen()),
    GetPage(name: AppRoutes.policyPrivacy, page: () => PolicyPrivacyScreen()),
    GetPage(name: AppRoutes.cart, page: () => CartScreen()),
    GetPage(name: AppRoutes.login, page: () => LoginScreen()),
    // GetPage(name: AppRoutes.detail, page: () => FoodDetailScreen(food: F,)), // optional if you pass arguments
  ];
}
