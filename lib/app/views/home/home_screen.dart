
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/theme_controller.dart';
import '../../controllers/auth_controller.dart';

// 🧭 Screens
import '../category_screen.dart';
import '../favorite_screen.dart';
import '../profile_screen.dart';
import '../cart_screen.dart';

// 🧩 Widgets
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/drawer_menu.dart';
import 'home_main_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ThemeController themeController = Get.put(ThemeController());
  final AuthController authController = Get.put(AuthController());

  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeMainScreen(),
    CategoryScreen(),
    CartScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ បង្ហាញ AppBar និង Drawer តែពេល currentIndex == 0 (Home tab)
      appBar: _currentIndex == 0 ? const CustomAppBar() : null,
      drawer: _currentIndex == 0
          ? DrawerMenu(
              themeController: themeController,
              authController: authController,
            )
          : null,

      // 🧭 Body
      body: _pages[_currentIndex],

      // 🧭 Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFFF36A05),
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Favorite'),
        ],
      ),
    );
  }
}
