import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../app/controllers/auth_controller.dart';
import '../app/controllers/theme_controller.dart';

// 🧭 Screens
import '../app/views/category_screen.dart';
import '../app/views/favorite_screen.dart';
import '../app/views/notification_screen.dart';
import '../app/views/policy_privacy_screen.dart';
import '../app/views/cart_screen.dart';
import '../app/views/auth/login_screen.dart';
import '../app/views/profile_screen.dart';
import '../app/views/history_screen.dart';
import '../app/views/dashboard/dashboard_screen.dart';
// Controller
import '../app/controllers/language_controller.dart';

class DrawerMenu extends StatelessWidget {
  final ThemeController themeController;
  final AuthController authController;

  const DrawerMenu({
    super.key,
    required this.themeController,
    required this.authController,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.orange),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => ProfileScreen());
                  },
                  child: const CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  FirebaseAuth.instance.currentUser?.displayName ?? 'John Doe',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  FirebaseAuth.instance.currentUser?.email ??
                      'john.doe@example.com',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          ListTile(
            leading: const Icon(Icons.home),
            title: Text('home'.tr),
            onTap: () => Get.back(),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard), // Icon is specified
            title: const Text('Dashboard'),
            onTap: () => Get.to(() => DashboardScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: Text('category'.tr),
            onTap: () => Get.to(() => CategoryScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text("Favorite"),
            onTap: () => Get.to(() => FavoriteScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Notification"),
            onTap: () => Get.to(() => NotificationScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text("Privacy Policy"),
            onTap: () => Get.to(() => PolicyPrivacyScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text("Cart"),
            onTap: () => Get.to(() => CartScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text("History"),
            onTap: () => Get.to(() => HistoryScreen()),
          ),

          const Divider(),

          // 🌐 Language Selection
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Language"),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Select Language"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Text(
                          "🇰🇭",
                          style: TextStyle(fontSize: 24),
                        ),
                        title: const Text("ភាសាខ្មែរ"),
                        onTap: () {
                          Get.find<LanguageController>().changeLanguage('km');
                          Get.back();
                        },
                      ),
                      ListTile(
                        leading: const Text(
                          "🇺🇸",
                          style: TextStyle(fontSize: 24),
                        ),
                        title: const Text("English"),
                        onTap: () {
                          Get.find<LanguageController>().changeLanguage('en');
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // 🌗 Dark/Light Mode Toggle
          Obx(
            () => SwitchListTile(
              title: Text(
                themeController.isDarkMode.value ? 'Dark Mode' : 'Light Mode',
              ),
              secondary: Icon(
                themeController.isDarkMode.value
                    ? Icons.dark_mode
                    : Icons.light_mode,
                color: themeController.isDarkMode.value
                    ? Colors.amber
                    : Colors.blueGrey,
              ),
              value: themeController.isDarkMode.value,
              onChanged: themeController.toggleTheme,
            ),
          ),

          // 🚪 Logout
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Logout"),
            onTap: () {
              Get.defaultDialog(
                title: "Confirm Logout",
                middleText: "Do you really want to log out?",
                barrierDismissible: false,
                textCancel: "No",
                textConfirm: "Yes",
                onConfirm: () {
                  authController.signOut();
                  Get.offAll(() => LoginScreen());
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
