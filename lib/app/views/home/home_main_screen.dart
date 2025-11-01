import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../theme/custom_colors.dart';
import '../../models/product_model.dart';
import '../../models/category_model.dart';
import '../../controllers/favorite_controller.dart';
import '../../controllers/product_controller.dart';
import '../category_screen.dart';
import '../detail_screen.dart';
import '../product_list_screen.dart';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({super.key});

  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  final ProductController productController = Get.put(ProductController());
  final FavoriteController favoriteController = Get.find<FavoriteController>();
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customColors =
        Theme.of(context).extension<CustomColors>() ??
        const CustomColors(
          accentColor: Colors.amber,
          darkTextColor: Colors.black,
        );
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 12),
            // 🔍 Search Bar
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: isDarkMode
                    ? null
                    : [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
              ),
              child: TextField(
                controller: _searchController,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                  suffixIcon: Icon(
                    Icons.tune,
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                  hintText: 'Search by name...',
                  hintStyle: TextStyle(
                    color: isDarkMode ? Colors.white54 : Colors.black45,
                  ),
                  filled: true,
                  fillColor: isDarkMode ? Colors.grey.shade900 : Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: isDarkMode ? Colors.white24 : Colors.black26,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: isDarkMode ? Colors.white24 : Colors.black26,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: isDarkMode ? Colors.white : Colors.black87.withOpacity(0.06),
                      width: 1.5,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
              ),
            ),

            const SizedBox(height: 16),

            // 🔹 Categories Horizontal List
            SizedBox(
              height: 180,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('category_db')
                    .snapshots(),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snap.hasData || snap.data!.docs.isEmpty) {
                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        const SizedBox(width: 12),
                        Container(
                          width: 150,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(child: Text("No categories")),
                        ),
                      ],
                    );
                  }

                  final docs = snap.data!.docs;
                  final cats = docs.map((d) {
                    final data = d.data() as Map<String, dynamic>;
                    return CategoryModel.fromFirestore(d.id, data);
                  }).toList();

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cats.length,
                    itemBuilder: (context, index) {
                      final category = cats[index];
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: InkWell(
                          onTap: () =>
                              Get.to(() => CategoryScreen(category: category)),
                          child: Container(
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(37, 0, 0, 0),
                                  offset: const Offset(0, 4),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (category.icon.startsWith('http'))
                                  Image.network(
                                    category.icon,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (c, e, s) => const Icon(
                                      Icons.image_not_supported,
                                      size: 60,
                                    ),
                                  )
                                else
                                  Image.asset(
                                    category.icon,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (c, e, s) => const Icon(
                                      Icons.image_not_supported,
                                      size: 60,
                                    ),
                                  ),
                                const SizedBox(height: 10),
                                Text(
                                  category.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 24),
            // 💥 Promotion Banner
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    // កែសម្រួលបន្ទាត់នេះដើម្បីប្រើពណ៌ថ្មី
                    color: isDarkMode
                        ? const Color(0xFF141414)
                        : customColors.accentColor,
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
                                // ប្រើពណ៌សនៅ Light Mode និង custom darkTextColor នៅ Dark Mode
                                color: isDarkMode
                                    ? customColors.darkTextColor
                                    : Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Order food on app and get 30% off",
                              style: TextStyle(
                                fontSize: 15,
                                // ប្រើពណ៌សនៅ Light Mode និង custom darkTextColor នៅ Dark Mode
                                color: isDarkMode
                                    ? customColors.darkTextColor
                                    : Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isDarkMode
                                    ? Colors.orange
                                    : Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                "Order Now",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? customColors.darkTextColor
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -30,
                  left: 0,
                  child: Image.asset(
                    "assets/images/download-removebg-preview.png",
                    width: 180,
                    errorBuilder: (c, e, s) => const SizedBox.shrink(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
            Row(
              children: [
                Text(
                  'Popular products',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    // ប្រើពណ៌ពី theme សម្រាប់អក្សរ
                    color: isDarkMode
                        ? customColors.darkTextColor
                        : Colors.black,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Get.to(() => ProductListScreen());
                  },
                  child: Row(
                    children: [
                      Text(
                        "see more",
                        style: TextStyle(
                          // ប្រើពណ៌ពី theme
                          color: Colors.amber,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        // ប្រើពណ៌ពី theme សម្រាប់ icon
                        color: Colors.amber,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
            // ⭐ Popular Foods Grid
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('product_db')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No food items found."));
                }

                List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
                final List<FoodModel> allFoods = [];
                for (var doc in docs) {
                  try {
                    final data = doc.data() as Map<String, dynamic>?;
                    if (data != null) {
                      allFoods.add(FoodModel.fromMap({'id': doc.id, ...data}));
                    }
                  } catch (e) {
                    debugPrint('FoodModel conversion error: $e');
                  }
                }

                productController.productList.value = allFoods;

                List<FoodModel> foods = allFoods;
                if (searchQuery.isNotEmpty) {
                  foods = allFoods.where((food) {
                    return food.name.toLowerCase().contains(searchQuery);
                  }).toList();
                }

                foods.sort(
                  (a, b) =>
                      a.name.toLowerCase().compareTo(b.name.toLowerCase()),
                );

                if (foods.isEmpty && searchQuery.isNotEmpty) {
                  return const Center(
                    child: Text("No matching food items found."),
                  );
                }

                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.76,
                  ),
                  itemCount: foods.length,
                  itemBuilder: (context, index) {
                    final food = foods[index];
                    return InkWell(
                      onTap: () => Get.to(() => FoodDetailScreen(food: food)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(37, 0, 0, 0),
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
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                  child: Image.network(
                                    food.image,
                                    width: double.infinity,
                                    height: 150,
                                    fit: BoxFit.cover,
                                    errorBuilder: (c, e, s) => const Icon(
                                      Icons.image_not_supported,
                                      size: 100,
                                    ),
                                  ),
                                ),
                                // ❤️ Favorite Button
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Obx(() {
                                    final isFav = favoriteController
                                        .favoriteItems
                                        .any((f) => f.id == food.id);
                                    return InkWell(
                                      onTap: () => favoriteController
                                          .toggleFavorite(food),
                                      borderRadius: BorderRadius.circular(50),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Icon(
                                          isFav
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: isFav
                                              ? Colors.red
                                              : Colors.white,
                                          size: 26,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    food.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "\៛${food.price.toStringAsFixed(2)}", style: TextStyle(color: Colors.orange),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 16,
                                      ),
                                      Text(
                                        "${food.rating}",
                                        style: const TextStyle(fontSize: 14),
                                      ),
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
