import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

// 🧩 Import your own files
import '../models/food_model.dart';
import '../theme/custom_colors.dart';
import '../controllers/themeController.dart';
import '../controllers/authController.dart';

// 🧭 Screens
import './category_screen.dart';
import './favorite_screen.dart';
import './notification_screen.dart';
import './policy_privacy_screen.dart';
import './profile_screen.dart';
import './cart_screen.dart';
import './auth/login_screen.dart';
import './detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ThemeController themeController = Get.put(ThemeController());
  final AuthController authController = Get.put(AuthController());

  int _currentIndex = 0;

  // 🧭 Pages for bottom navigation
  final List<Widget> _pages = [
    const _HomeMainScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Foodies"),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Row(
              children: [
                Icon(Icons.notifications),
                SizedBox(width: 12),
                Icon(Icons.shopping_cart),
              ],
            ),
          ),
        ],
      ),

      drawer: _buildDrawer(context),

      // 🧭 Switch screen by bottom navigation
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFFF36A05),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  // ================================
  // 🧭 Drawer Section
  // ================================
  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.orange),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
                const SizedBox(height: 12),
                Text(
                  FirebaseAuth.instance.currentUser?.displayName ?? 'John Doe',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  FirebaseAuth.instance.currentUser?.email ?? 'john.doe@example.com',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () => Get.back(),
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categories'),
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
            onTap: () => Get.to(() => PoliPrSCreen()),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text("Cart"),
            onTap: () => Get.to(() => CartSCreen()),
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
                        leading: const Text("🇰🇭", style: TextStyle(fontSize: 24)),
                        title: const Text("Khmer"),
                        onTap: () => Navigator.pop(context),
                      ),
                      ListTile(
                        leading: const Text("🇺🇸", style: TextStyle(fontSize: 24)),
                        title: const Text("English"),
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // 🌗 Dark/Light Mode Toggle
          Obx(() => SwitchListTile(
                title: Text(themeController.isDarkMode.value ? 'Dark Mode' : 'Light Mode'),
                secondary: Icon(
                  themeController.isDarkMode.value ? Icons.dark_mode : Icons.light_mode,
                  color: themeController.isDarkMode.value ? Colors.amber : Colors.blueGrey,
                ),
                value: themeController.isDarkMode.value,
                onChanged: themeController.toggleTheme,
              )),

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

// ================================
// 🏠 Home Main Screen (Default Page)
// ================================
class _HomeMainScreen extends StatelessWidget {
  const _HomeMainScreen();

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // 🔍 Search Bar
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: customColors.accentColor,
            ),
            child: const Padding(
              padding: EdgeInsets.all(9.0),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search your favorite food",
                  suffixIcon: Icon(Icons.tune),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // 🍔 Categories
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () => Get.to(() => CategoryScreen()),
                    child: Container(
                      decoration: BoxDecoration(
                        color: customColors.accentColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(0, 4),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Image.asset(categories[index].icon, width: 100, height: 100),
                            const SizedBox(height: 10),
                            Text(
                              categories[index].name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: customColors.darkTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 30),

          // 🧾 Discount Banner
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: customColors.accentColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 200),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "30% Discount",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: customColors.darkTextColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Order food on app and get 30% off",
                            style: TextStyle(
                              fontSize: 15,
                              color: customColors.darkTextColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text("Order Now"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -40,
                left: 0,
                child: Image.asset(
                  "assets/images/burger_splash.png",
                  width: 180,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ⭐ Popular Food Section
          Row(
            children: [
              const Text("Popular Food", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Spacer(),
              TextButton(
                onPressed: () => Get.to(() => CategoryScreen()),
                child: const Row(
                  children: [
                    Text("See All", style: TextStyle(color: Colors.orange)),
                    Icon(Icons.arrow_forward_ios, color: Colors.orange, size: 14),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.7,
            ),
            itemCount: foods.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Get.to(() => FoodDetailScreen(food: foods[index])),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        offset: const Offset(0, 4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            foods[index].image,
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          const Positioned(
                            top: 8,
                            right: 8,
                            child: Icon(Icons.favorite, color: Colors.amber),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              foods[index].name,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Text("\$${foods[index].price}"),
                                const Spacer(),
                                const Icon(Icons.star, color: Colors.amber, size: 16),
                                Text("${foods[index].rating}", style: const TextStyle(fontSize: 14)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
