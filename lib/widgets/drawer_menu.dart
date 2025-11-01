// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../app/controllers/theme_controller.dart';
// import '../app/controllers/user_auth_controller.dart';
// import '../app/controllers/language_controller.dart';
// import '../app/views/profile_screen.dart';
// import '../app/views/history_screen.dart';
// import '../app/views/category_screen.dart';
// import '../app/views/favorite_screen.dart';
// import '../app/views/notification_screen.dart';
// import '../app/views/policy_privacy_screen.dart';
// import '../app/views/cart_screen.dart';
// import '../app/views/dashboard/dashboard_screen.dart';
// import '../app/views/auth/user_auth/login_screen.dart';
// import '../app/models/category_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class DrawerMenu extends StatelessWidget {
//   final ThemeController themeController;
//   final AuthController authController;

//   const DrawerMenu({
//     super.key,
//     required this.themeController,
//     required this.authController,
//   });

//   Future<String> _getUserRole() async {
//     final uid = FirebaseAuth.instance.currentUser?.uid;
//     if (uid == null) return '';
//     final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
//     if (doc.exists && doc.data()!.containsKey('role')) {
//       return doc['role'] as String;
//     }
//     return '';
//   }

//   @override
//   Widget build(BuildContext context) {
//     final defaultCategory = CategoryModel(
//       id: 'default_id',
//       name: 'All Categories',
//       icon: 'assets/images/default_icon.png', 
//     );

//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: const BoxDecoration(color: Colors.orange),
//             child: Column(
//               children: [
//                 InkWell(
//                   onTap: () => Get.to(() => ProfileScreen()),
//                   child: const CircleAvatar(
//                     radius: 35,
//                     backgroundImage: AssetImage('assets/images/profile.jpg'),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   FirebaseAuth.instance.currentUser?.displayName ?? 'John Doe',
//                   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//                 ),
//                 Text(
//                   FirebaseAuth.instance.currentUser?.email ?? 'john.doe@example.com',
//                   style: const TextStyle(color: Colors.white70),
//                 ),
//               ],
//             ),
//           ),

//           // Home
//           ListTile(
//             leading: const Icon(Icons.home),
//             title: Text('home'.tr,style: TextStyle(fontFamily: 'Poppins', fontSize: 18,
//             fontWeight: FontWeight.bold,),),
//             onTap: () => Get.back(),
//           ),

//           // Admin Dashboard
//           FutureBuilder<String>(
//             future: _getUserRole(),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) return const SizedBox();
//               if (snapshot.data == 'admin') {
//                 return ListTile(
//                   leading: const Icon(Icons.dashboard),
//                    title: Text('dashboard'.tr),
//                   onTap: () => Get.to(() => const DashboardScreen()),
//                 );
//               }
//               return const SizedBox();
//             },
//           ),

//           // Category
//           ListTile(
//             leading: const Icon(Icons.category),
//             title: Text('category'.tr),
//             onTap: () {
//               // Use defaultCategory to avoid recursion
//               Get.to(() => CategoryScreen(category: defaultCategory));
//             },
//           ),

//           // Favorite
//           ListTile(
//             leading: const Icon(Icons.favorite),
//             title: Text('favorite'.tr),
//             onTap: () => Get.to(() => FavoriteScreen()),
//           ),

//           // Notification
//           ListTile(
//             leading: const Icon(Icons.notifications),
//             title: Text('notification'.tr),
//             onTap: () => Get.to(() => NotificationScreen()),
//           ),

//           // Privacy Policy
//           ListTile(
//             leading: const Icon(Icons.privacy_tip),
//             title: Text('privacy'.tr),
//             onTap: () => Get.to(() => PolicyPrivacyScreen()),
//           ),

//           // Cart
//           ListTile(
//             leading: const Icon(Icons.shopping_cart),
//             title: Text('cart'.tr),
//             onTap: () => Get.to(() => CartScreen()),
//           ),

//           // History
//           ListTile(
//             leading: const Icon(Icons.history),
//             title: Text('history'.tr),
//             onTap: () => Get.to(() => HistoryScreen()),
//           ),

//           const Divider(),

//           // Language
//           ListTile(
//             leading: const Icon(Icons.language),
//             title: Text('language'.tr),
//             onTap: () {
//               showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: const Text("Select Language"),
//                   content: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       ListTile(
//                         leading: const Text("🇰🇭", style: TextStyle(fontSize: 24)),
//                         title: const Text("ភាសាខ្មែរ"),
//                         onTap: () {
//                           Get.find<LanguageController>().changeLanguage('km');
//                           Get.back();
//                         },
//                       ),
//                       ListTile(
//                         leading: const Text("🇺🇸", style: TextStyle(fontSize: 24)),
//                         title: const Text("English"),
//                         onTap: () {
//                           Get.find<LanguageController>().changeLanguage('en');
//                           Get.back();
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),

//           // Dark/Light Theme
//           Obx(
//             () => SwitchListTile(
//               title: Text(themeController.isDarkMode.value ? 'Dark Mode' : 'Light Mode'),
//               secondary: Icon(
//                 themeController.isDarkMode.value ? Icons.dark_mode : Icons.light_mode,
//                 color: themeController.isDarkMode.value ? Colors.amber : Colors.blueGrey,
//               ),
//               value: themeController.isDarkMode.value,
//               onChanged: themeController.toggleTheme,
//             ),
//           ),

//           // Logout
//           ListTile(
//             leading: const Icon(Icons.exit_to_app),
//             title: Text('logout'.tr),
//             onTap: () {
//               Get.defaultDialog(
//                 title: "Confirm Logout",
//                 middleText: "Do you really want to log out?",
//                 barrierDismissible: false,
//                 textCancel: "No",
//                 textConfirm: "Yes",
//                 onConfirm: () {
//                   authController.signOut();
//                   Get.offAll(() => LoginScreen());
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../app/controllers/theme_controller.dart';
import '../app/controllers/user_auth_controller.dart';
import '../app/controllers/language_controller.dart';
import '../app/views/profile_screen.dart';
import '../app/views/history_screen.dart';
import '../app/views/category_screen.dart';
import '../app/views/favorite_screen.dart';
import '../app/views/notification_screen.dart';
import '../app/views/policy_privacy_screen.dart';
import '../app/views/cart_screen.dart';
import '../app/views/dashboard/dashboard_screen.dart';
import '../app/views/auth/user_auth/login_screen.dart';
import '../app/models/category_model.dart';

class DrawerMenu extends StatelessWidget {
  final ThemeController themeController;
  final AuthController authController;

  const DrawerMenu({
    super.key,
    required this.themeController,
    required this.authController,
  });

  Future<String> _getUserRole() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return '';
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (doc.exists && doc.data()!.containsKey('role')) {
      return doc['role'] as String;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = themeController.isDarkMode.value;
    final defaultCategory = CategoryModel(
      id: 'default_id',
      name: 'All Categories',
      icon: 'assets/images/default_icon.png',
    );

    return Drawer(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [Colors.black87, Colors.grey.shade900]
                : [Colors.white, Colors.grey.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildAnimatedHeader(context),

            const SizedBox(height: 10),

            _buildDrawerTile(
              icon: Icons.home,
              title: 'home'.tr,
              onTap: () => Get.back(),
              color: Colors.amber,
            ),

            FutureBuilder<String>(
              future: _getUserRole(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(height: 0);
                }
                if (snapshot.hasData && snapshot.data == 'admin') {
                  return _buildDrawerTile(
                    icon: Icons.dashboard_rounded,
                    title: 'dashboard'.tr,
                    onTap: () => Get.to(() => const DashboardScreen()),
                    color: Colors.amber,
                  );
                }
                return const SizedBox();
              },
            ),

            _buildDrawerTile(
              icon: Icons.category_rounded,
              title: 'category'.tr,
              onTap: () => Get.to(() => CategoryScreen(category: defaultCategory)),
              color: Colors.amber,
            ),

            _buildDrawerTile(
              icon: Icons.favorite_rounded,
              title: 'favorite'.tr,
              onTap: () => Get.to(() => FavoriteScreen()),
              color: Colors.amber,
            ),

            _buildDrawerTile(
              icon: Icons.notifications_rounded,
              title: 'notification'.tr,
              onTap: () => Get.to(() => const NotificationScreen()),
              color: Colors.amber,
            ),

            _buildDrawerTile(
              icon: Icons.privacy_tip_rounded,
              title: 'privacy'.tr,
              onTap: () => Get.to(() => const PolicyPrivacyScreen()),
              color: Colors.amber,
            ),

            _buildDrawerTile(
              icon: Icons.shopping_cart_rounded,
              title: 'cart'.tr,
              onTap: () => Get.to(() => const CartScreen()),
              color: Colors.amber,
            ),

            _buildDrawerTile(
              icon: Icons.history_rounded,
              title: 'history'.tr,
              onTap: () => Get.to(() => const HistoryScreen()),
              color: Colors.amber,
            ),

            const Divider(height: 30),

            _buildDrawerTile(
              icon: Icons.language_rounded,
              title: 'language'.tr,
              onTap: () => _showLanguageDialog(context),
              color: Colors.amber,
            ),

            Obx(() => SwitchListTile(
                  title: Text(
                    themeController.isDarkMode.value ? 'Dark Mode' : 'Light Mode',
                    style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  ),
                  secondary: Icon(
                    themeController.isDarkMode.value ? Icons.dark_mode : Icons.light_mode,
                    color: themeController.isDarkMode.value ? Colors.amber : Colors.blueGrey,
                  ),
                  value: themeController.isDarkMode.value,
                  onChanged: themeController.toggleTheme,
                )),

            _buildDrawerTile(
              icon: Icons.exit_to_app_rounded,
              title: 'logout'.tr,
              color: const Color.fromARGB(255, 254, 0, 0),
              onTap: () {
                Get.defaultDialog(
                  title: "Confirm Logout",
                  middleText: "Do you really want to log out?",
                  barrierDismissible: false,
                  textCancel: "No",
                  textConfirm: "Yes",
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    authController.signOut();
                    Get.offAll(() => LoginScreen());
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Animated Drawer Header
  Widget _buildAnimatedHeader(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Container(
      height: 180,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange, Colors.deepOrangeAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutBack,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'profile_pic',
                child: InkWell(
                  onTap: () => Get.to(() =>ProfileScreen()),
                  borderRadius: BorderRadius.circular(50),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: const AssetImage('assets/images/profile.jpg'),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                user?.displayName ?? 'John Doe',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                user?.email ?? 'john.doe@example.com',
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Reusable Drawer Tile
  Widget _buildDrawerTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 400),
      builder: (context, value, child) => Transform.translate(
        offset: Offset(0, (1 - value) * 20),
        child: Opacity(opacity: value, child: child),
      ),
      child: ListTile(
        leading: Icon(icon, color: color ?? Colors.blueGrey),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  // 🔹 Language Dialog
  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Select Language"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Text("🇰🇭", style: TextStyle(fontSize: 24)),
              title: const Text("ភាសាខ្មែរ"),
              onTap: () {
                Get.find<LanguageController>().changeLanguage('km');
                Get.back();
              },
            ),
            ListTile(
              leading: const Text("🇺🇸", style: TextStyle(fontSize: 24)),
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
  }
}
