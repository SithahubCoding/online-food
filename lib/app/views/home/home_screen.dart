// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controllers/theme_controller.dart';
// import '../../controllers/user_auth_controller.dart';
// import '../../models/category_model.dart';
// // 🧭 Screens
// import '../category_screen.dart';
// import '../favorite_screen.dart';
// import '../profile_screen.dart';
// import '../cart_screen.dart';

// // 🧩 Widgets
// import '../../../widgets/custom_appbar.dart';
// import '../../../widgets/drawer_menu.dart';
// import 'home_main_screen.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final ThemeController themeController = Get.put(ThemeController());
//   final AuthController authController = Get.put(AuthController());

//   int _currentIndex = 0;

//   final CategoryModel defaultCategory = CategoryModel(
//     id: 'default_id',
//     name: 'All Categories',
//     icon: 'assets/images/default_icon.png',
//   );

//   late final List<Widget> _pages = [
//     HomeMainScreen(),
//     CategoryScreen(category: defaultCategory),
//     CartScreen(),
//     FavoriteScreen(),
//     ProfileScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _currentIndex == 0 ? const CustomAppBar() : null,
//       drawer: _currentIndex == 0
//           ? DrawerMenu(
//               themeController: themeController,
//               authController: authController,
//             )
//           : null,
//       body: _pages[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: _currentIndex,
//         selectedItemColor: const Color(0xFFF36A05),
//         unselectedItemColor: Colors.grey,
//         onTap: (index) => setState(() => _currentIndex = index),
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.dashboard_outlined), label: 'Category'),
//           BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
//           BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.person_outline), label: 'Profile'),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controllers/theme_controller.dart';
// import '../../controllers/user_auth_controller.dart';
// import '../../models/category_model.dart';
// import '../category_screen.dart';
// import '../favorite_screen.dart';
// import '../profile_screen.dart';
// import '../cart_screen.dart';
// import '../../../widgets/custom_appbar.dart';
// import '../../../widgets/drawer_menu.dart';
// import 'home_main_screen.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final ThemeController themeController = Get.put(ThemeController());
//   final AuthController authController = Get.put(AuthController());

//   int _currentIndex = 0;
//   final GlobalKey<CurvedNavigationBarState> _navKey = GlobalKey();

//   final CategoryModel defaultCategory = CategoryModel(
//     id: 'default_id',
//     name: 'All Categories',
//     icon: 'assets/images/default_icon.png',
//   );

//   late final List<Widget> _pages = [
//     HomeMainScreen(),
//     CategoryScreen(category: defaultCategory),
//     CartScreen(),
//     FavoriteScreen(),
//     ProfileScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _currentIndex == 0 ? const CustomAppBar() : null,
//       drawer: _currentIndex == 0
//           ? DrawerMenu(
//               themeController: themeController,
//               authController: authController,
//             )
//           : null,
//       body: _pages[_currentIndex],
//       bottomNavigationBar: CurvedNavigationBar(
//         key: _navKey,
//         index: _currentIndex,
//         height: 60,
//         backgroundColor: Colors.transparent,
//         color: Colors.white,
//         buttonBackgroundColor: const Color(0xFFF36A05),
//         animationCurve: Curves.easeInOut,
//         animationDuration: const Duration(milliseconds: 500),
//         items: const [
//           Icon(Icons.home, size: 30, color: Colors.black),
//           Icon(Icons.dashboard_outlined, size: 30, color: Colors.black),
//           Icon(Icons.shopping_cart, size: 30, color: Colors.black),
//           Icon(Icons.favorite, size: 30, color: Colors.black),
//           Icon(Icons.person_outline, size: 30, color: Colors.black),
//         ],
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// import '../../controllers/theme_controller.dart';
// import '../../controllers/user_auth_controller.dart';
// import '../../models/category_model.dart';
// import '../category_screen.dart';
// import '../favorite_screen.dart';
// import '../profile_screen.dart';
// import '../cart_screen.dart';
// import '../../../widgets/custom_appbar.dart';
// import '../../../widgets/drawer_menu.dart';
// import 'home_main_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final ThemeController themeController = Get.put(ThemeController());
//   final AuthController authController = Get.put(AuthController());

//   int _currentIndex = 0;
//   final GlobalKey<CurvedNavigationBarState> _navKey = GlobalKey();

//   final CategoryModel defaultCategory = CategoryModel(
//     id: 'default_id',
//     name: 'All Categories',
//     icon: 'assets/images/default_icon.png',
//   );

//   late final List<Widget> _pages = [
//     HomeMainScreen(),
//     CategoryScreen(category: defaultCategory),
//     CartScreen(),
//     FavoriteScreen(),
//     ProfileScreen(),
//   ];

//   final List<IconData> _icons = [
//     Icons.home,
//     Icons.dashboard_outlined,
//     Icons.shopping_cart,
//     Icons.favorite,
//     Icons.person_outline,
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: _currentIndex == 0 ? const CustomAppBar() : null,
//       drawer: _currentIndex == 0
//           ? DrawerMenu(
//               themeController: themeController,
//               authController: authController,
//             )
//           : null,
//       body: AnimatedSwitcher(
//         duration: const Duration(milliseconds: 400),
//         child: _pages[_currentIndex],
//       ),
//       bottomNavigationBar: Container(
//         margin: const EdgeInsets.only(top: 2, left: 0, right: 0), 
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFFF36A05), Color(0xFFFFA726)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(25),
//             topRight: Radius.circular(25),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 10,
//               offset: Offset(0, -2),
//             ),
//           ],
//         ),
//         child: CurvedNavigationBar(
//           key: _navKey,
//           index: _currentIndex,
//           height: 60,
//           backgroundColor: Colors.transparent,
//           color: Colors.white,
//           buttonBackgroundColor: Colors.orangeAccent,
//           animationCurve: Curves.easeInOut,
//           animationDuration: const Duration(milliseconds: 500),
//           items: List.generate(_icons.length, (index) {
//             final isSelected = _currentIndex == index;
//             return SizedBox(
//               width: 50,
//               height: 50,
//               child: Icon(
//                 _icons[index],
//                 size: isSelected ? 30 : 24,
//                 color: isSelected ? Colors.white : Colors.black54,
//               ),
//             );
//           }),
//           onTap: (index) {
//             setState(() {
//               _currentIndex = index;
//             });
//           },
//         ),
//       ),
//     );
//   }
// }
// app/views/home/home_screen.dart

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// import '../../controllers/theme_controller.dart';
// import '../../controllers/user_auth_controller.dart';
// import '../../models/category_model.dart';
// import '../category_screen.dart';
// import '../favorite_screen.dart';
// import '../profile_screen.dart';
// import '../cart_screen.dart';
// import '../../../widgets/custom_appbar.dart';
// import '../../../widgets/drawer_menu.dart';
// import 'home_main_screen.dart';

// // Import custom_colors extension
// import '../../theme/custom_colors.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final ThemeController themeController = Get.put(ThemeController());
//   final AuthController authController = Get.put(AuthController());

//   int _currentIndex = 0;
//   final GlobalKey<CurvedNavigationBarState> _navKey = GlobalKey();

//   final CategoryModel defaultCategory = CategoryModel(
//     id: 'default_id',
//     name: 'All Categories',
//     icon: 'assets/images/default_icon.png',
//   );

//   late final List<Widget> _pages = [
//     HomeMainScreen(),
//     CategoryScreen(category: defaultCategory),
//     CartScreen(),
//     FavoriteScreen(),
//     ProfileScreen(),
//   ];

//   final List<IconData> _icons = [
//     Icons.home,
//     Icons.dashboard_outlined,
//     Icons.shopping_cart,
//     Icons.favorite,
//     Icons.person_outline,
//   ];

//   @override
//   Widget build(BuildContext context) {
//     // ទទួលបាន customColors
//     final customColors = context.customColors;

//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;

//     return Scaffold(
//       // ប្រើពណ៌ពី Theme សម្រាប់ផ្ទៃខាងក្រោយ
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: _currentIndex == 0 ? const CustomAppBar() : null,
//       drawer: _currentIndex == 0
//           ? DrawerMenu(
//               themeController: themeController,
//               authController: authController,
//             )
//           : null,
//       body: AnimatedSwitcher(
//         duration: const Duration(milliseconds: 400),
//         child: _pages[_currentIndex],
//       ),
//       bottomNavigationBar: Container(
//         margin: const EdgeInsets.only(top: 2, left: 0, right: 0),
//         decoration: BoxDecoration(
//           // ប្រើពណ៌ gradient ទៅតាម theme
//           gradient: isDarkMode
//               ? const LinearGradient(
//                   colors: [
//                     Color(0xFF333333), // ពណ៌ gradient សម្រាប់ dark mode
//                     Color(0xFF555555),
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 )
//               : const LinearGradient(
//                   colors: [Color(0xFFF36A05), Color(0xFFFFA726)], // ពណ៌ gradient សម្រាប់ light mode
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(25),
//             topRight: Radius.circular(25),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: isDarkMode ? Colors.white12 : Colors.black26,
//               blurRadius: 10,
//               offset: const Offset(0, -2),
//             ),
//           ],
//         ),
//         child: CurvedNavigationBar(
//           key: _navKey,
//           index: _currentIndex,
//           height: 60,
//           backgroundColor: Colors.transparent,
//           // កែប្រែពណ៌របស់ CurvedNavigationBar ទៅតាម theme
//           color: isDarkMode ? customColors.accentColor : Colors.white,
//           buttonBackgroundColor: isDarkMode ? Colors.black : Colors.orangeAccent,
//           animationCurve: Curves.easeInOut,
//           animationDuration: const Duration(milliseconds: 500),
//           items: List.generate(_icons.length, (index) {
//             final isSelected = _currentIndex == index;
//             return SizedBox(
//               width: 50,
//               height: 50,
//               child: Icon(
//                 _icons[index],
//                 size: isSelected ? 30 : 24,
//                 // កែប្រែពណ៌ icon ទៅតាម theme
//                 color: isSelected
//                     ? isDarkMode ? customColors.darkTextColor : Colors.white
//                     : isDarkMode ? customColors.darkTextColor!.withOpacity(0.5) : Colors.black54,
//               ),
//             );
//           }),
//           onTap: (index) {
//             setState(() {
//               _currentIndex = index;
//             });
//           },
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// import '../../controllers/theme_controller.dart';
// import '../../controllers/user_auth_controller.dart';
// import '../../models/category_model.dart';
// import '../category_screen.dart';
// import '../favorite_screen.dart';
// import '../profile_screen.dart';
// import '../cart_screen.dart';
// import '../../../widgets/custom_appbar.dart';
// import '../../../widgets/drawer_menu.dart';
// import 'home_main_screen.dart';

// // Import custom_colors extension
// import '../../theme/custom_colors.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final ThemeController themeController = Get.put(ThemeController());
//   final AuthController authController = Get.put(AuthController());

//   int _currentIndex = 0;
//   final GlobalKey<CurvedNavigationBarState> _navKey = GlobalKey();

//   final CategoryModel defaultCategory = CategoryModel(
//     id: 'default_id',
//     name: 'All Categories',
//     icon: 'assets/images/default_icon.png',
//   );

//   late final List<Widget> _pages = [
//     HomeMainScreen(),
//     CategoryScreen(category: defaultCategory),
//     CartScreen(),
//     FavoriteScreen(),
//     ProfileScreen(),
//   ];

//   final List<IconData> _icons = [
//     Icons.home,
//     Icons.dashboard_outlined,
//     Icons.shopping_cart,
//     Icons.favorite,
//     Icons.person_outline,
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final customColors = context.customColors;
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;

//     return Scaffold(
//       backgroundColor: isDarkMode ? Colors.grey.shade900 : Colors.grey[100],
//       appBar: _currentIndex == 0 ? const CustomAppBar() : null,
//       drawer: _currentIndex == 0
//           ? DrawerMenu(
//               themeController: themeController,
//               authController: authController,
//             )
//           : null,
//       body: AnimatedSwitcher(
//         duration: const Duration(milliseconds: 400),
//         child: _pages[_currentIndex],
//       ),
//       bottomNavigationBar: Container(
//         margin: const EdgeInsets.only(top: 2),
//         decoration: BoxDecoration(
//           gradient: isDarkMode
//               ? const LinearGradient(
//                   colors: [Color(0xFF333333), Color(0xFF555555)],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 )
//               : const LinearGradient(
//                   colors: [Color(0xFFFFC107), Color(0xFFFF6F00)],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(25),
//             topRight: Radius.circular(25),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: isDarkMode ? Colors.white12 : Colors.black26,
//               blurRadius: 10,
//               offset: const Offset(0, -2),
//             ),
//           ],
//         ),
//         child: CurvedNavigationBar(
//           key: _navKey,
//           index: _currentIndex,
//           height: 60,
//           backgroundColor: Colors.transparent,
//           color: isDarkMode ? Colors.grey.shade800 : Colors.white,
//           buttonBackgroundColor: isDarkMode ? Colors.black : const Color(0xFFFFA726),
//           animationCurve: Curves.easeInOut,
//           animationDuration: const Duration(milliseconds: 500),
//           items: List.generate(_icons.length, (index) {
//             final isSelected = _currentIndex == index;
//             return SizedBox(
//               width: 50,
//               height: 50,
//               child: Icon(
//                 _icons[index],
//                 size: isSelected ? 30 : 24,
//                 color: isSelected
//                     ? Colors.white
//                     : isDarkMode
//                         ? Colors.white54
//                         : Colors.black54,
//               ),
//             );
//           }),
//           onTap: (index) {
//             setState(() => _currentIndex = index);
//           },
//         ),
//       ),
//     );
//   }

//   /// Example of consistent TextField style across HomeScreen if needed
//   Widget buildSearchField(TextEditingController controller, String hint) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       decoration: BoxDecoration(
//         color: isDarkMode ? Colors.grey.shade900 : Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: isDarkMode
//             ? null
//             : [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 6,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//       ),
//       child: TextField(
//         controller: controller,
//         style: TextStyle(color: isDarkMode ? Colors.white : Colors.black87),
//         decoration: InputDecoration(
//           prefixIcon: Icon(Icons.search,
//               color: isDarkMode ? Colors.white70 : Colors.black54),
//           hintText: hint,
//           hintStyle:
//               TextStyle(color: isDarkMode ? Colors.white54 : Colors.black45),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: BorderSide.none,
//           ),
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//         ),
//         onChanged: (value) {
//           // Handle search query
//         },
//       ),
//     );
//   }
// }

// home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../../controllers/theme_controller.dart';
import '../../controllers/user_auth_controller.dart';
import '../../models/category_model.dart';
import '../category_screen.dart';
import '../favorite_screen.dart';
import '../profile_screen.dart';
import '../cart_screen.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/drawer_menu.dart';
import 'home_main_screen.dart';

// Import custom_colors extension
import '../../theme/custom_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ThemeController themeController = Get.put(ThemeController());
  final AuthController authController = Get.put(AuthController());

  int _currentIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _navKey = GlobalKey();

  final CategoryModel defaultCategory = CategoryModel(
    id: 'default_id',
    name: 'All Categories',
    icon: 'assets/images/default_icon.png',
  );

  late final List<Widget> _pages = [
    HomeMainScreen(),
    CategoryScreen(category: defaultCategory),
    CartScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  final List<IconData> _icons = [
    Icons.home,
    Icons.dashboard_outlined,
    Icons.shopping_cart,
    Icons.favorite,
    Icons.person_outline,
  ];

  @override
  Widget build(BuildContext context) {
    final customColors = context.customColors;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey.shade900 : Colors.grey[100],
      appBar: _currentIndex == 0 ? const CustomAppBar() : null,
      drawer: _currentIndex == 0
          ? DrawerMenu(
              themeController: themeController,
              authController: authController,
            )
          : null,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(top: 2),
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? const LinearGradient(
                  colors: [Color(0xFF333333), Color(0xFF555555)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : const LinearGradient(
                  colors: [Color(0xFFFFC107), Color(0xFFFF6F00)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? Colors.white12 : Colors.black26,
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: CurvedNavigationBar(
          key: _navKey,
          index: _currentIndex,
          height: 60,
          backgroundColor: Colors.transparent,
          color: isDarkMode ? Colors.grey.shade800 : Colors.white,
          buttonBackgroundColor: isDarkMode ? Colors.black : const Color(0xFFFFA726),
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 500),
          items: List.generate(_icons.length, (index) {
            final isSelected = _currentIndex == index;
            return SizedBox(
              width: 50,
              height: 50,
              child: Icon(
                _icons[index],
                size: isSelected ? 30 : 24,
                color: isSelected
                    ? Colors.white
                    : isDarkMode
                        ? Colors.white54
                        : Colors.black54,
              ),
            );
          }),
          onTap: (index) {
            setState(() => _currentIndex = index);
          },
        ),
      ),
    );
  }

  /// Modern search field style
  Widget buildSearchField(TextEditingController controller, String hint) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey : Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: isDarkMode
            ? null
            : [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black87),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search,
              color: isDarkMode ? Colors.white70 : Colors.black54),
          hintText: hint,
          hintStyle:
              TextStyle(color: isDarkMode ? Colors.white54 : Colors.black45),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        onChanged: (value) {
          // Handle search query
        },
      ),
    );
  }
}
