import 'package:get/get.dart';
import '../app/views/home/home_screen.dart';
import '../app/views/category_screen.dart';
import '../app/views/favorite_screen.dart';
import '../app/views/profile_screen.dart';
import '../app/views/notification_screen.dart';
import '../app/views/policy_privacy_screen.dart';
import '../app/views/cart_screen.dart';

// User Auth
import '../app/views/auth/user_auth/login_screen.dart';
import '../app/views/auth/user_auth/register_screen.dart';
import '../app/views/auth/user_auth/forget_password_screen.dart';
import '../app/views/auth/user_auth/reset_password.dart';

// Admin Auth
import '../app/views/auth/admin_auth/admin_login_screen.dart';
import '../app/views/auth/admin_auth/admin_signup_screen.dart';
import '../app/views/auth/admin_auth/admin_forget_password.dart';
import '../app/views/auth/admin_auth/admin_reset_password.dart';
import '../app/views/auth/admin_auth/admin_send_otp.dart';

import '../app/views/dashboard/dashboard_screen.dart';
import '../app/models/category_model.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    // User Auth
    GetPage(name: AppRoutes.userLogin, page: () => LoginScreen()),
    GetPage(name: AppRoutes.userSignUp, page: () => SignUpScreen()),
    GetPage(name: AppRoutes.userForgetPassword, page: () => ForgetPasswordScreen()),
    GetPage(name: AppRoutes.userResetPassword, page: () => ResetPasswordScreen()),

    // Admin Auth
    GetPage(name: AppRoutes.adminLogin, page: () => AdminLoginScreen()),
    GetPage(name: AppRoutes.adminSignUp, page: () => AdminSignUpScreen()),
    GetPage(name: AppRoutes.adminForgetPassword, page: () => AdminForgetPasswordScreen()),
    GetPage(name: AppRoutes.adminResetPassword, page: () => AdminResetPasswordScreen()),
    GetPage(
      name: AppRoutes.adminSendOtp,
      page: () {
        final String email = Get.arguments as String? ?? '';
        return AdminSendOtpScreen(email: email);
      },
    ),

    // Dashboard
    GetPage(name: AppRoutes.dashboard, page: () => const DashboardScreen()),

    // Common screens
    GetPage(name: AppRoutes.home, page: () => const HomeScreen()),

    // CategoryScreen with argument
    GetPage(
      name: AppRoutes.category,
      page: () {
        final CategoryModel category = Get.arguments as CategoryModel;
        return CategoryScreen(category: category);
      },
    ),

    GetPage(name: AppRoutes.favorite, page: () => FavoriteScreen()),
    GetPage(name: AppRoutes.profile, page: () => ProfileScreen()),
    GetPage(name: AppRoutes.notification, page: () => NotificationScreen()),
    GetPage(name: AppRoutes.policyPrivacy, page: () => PolicyPrivacyScreen()),
    GetPage(name: AppRoutes.cart, page: () => CartScreen()),
  ];
}
