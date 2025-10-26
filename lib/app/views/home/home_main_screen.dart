import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../theme/custom_colors.dart';
import '../../models/category_model.dart';
import '../category_screen.dart';
import '../detail_screen.dart';
import '../../controllers/favorite_controller.dart';
import '../../models/product_model.dart'; // FoodModel
import '../../controllers/product_controller.dart';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({super.key});

  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  // Initialize GetX Controllers (must be done before use)
  final FavoriteController favoriteController = Get.put(FavoriteController());
  final ProductController productController = Get.put(ProductController());

  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Mock CustomColors for demonstration (replace with your actual Theme Extension logic)
    final customColors =
        Theme.of(context).extension<CustomColors>() ??
        const CustomColors(
          accentColor: Colors.amber,
          darkTextColor: Colors.black,
        );

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // 🔍 Search Bar
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: customColors.accentColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search your favorite food",
                    suffixIcon: Icon(Icons.tune),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase();
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),
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
                            color: Colors.grey.shade200, // ប្រើពណ៌ default
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
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () =>
                              Get.to(() => CategoryScreen(category: category)),
                          child: Container(
                            width: 150, // កំណត់ទទឹងដើម្បីបង្ហាញបានល្អ
                            decoration: BoxDecoration(
                              color: Colors.white, // ប្រើពណ៌ default
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: const Offset(0, 4),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // ត្រូវប្រាកដថា category.icon គឺជា Image URL ឬ Asset Path ត្រឹមត្រូវ
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
                    errorBuilder: (c, e, s) =>
                        const SizedBox.shrink(), // Placeholder for missing asset
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ⭐ Popular Foods from Firestore
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

                // Convert to FoodModel safely
                final List<FoodModel> allFoods = [];
                for (var doc in docs) {
                  try {
                    final data = doc.data() as Map<String, dynamic>?;
                    if (data != null) {
                      allFoods.add(FoodModel.fromFirestore(doc.id, data));
                    }
                  } catch (e) {
                    debugPrint(
                      'FoodModel conversion error for doc ID: ${doc.id}, Error: $e',
                    );
                  }
                }

                // Update ProductController list for use in other screens (e.g. FoodDetailScreen)
                productController.productList.value = allFoods;

                // Filter search query
                List<FoodModel> foods = allFoods;
                if (searchQuery.isNotEmpty) {
                  foods = allFoods.where((food) {
                    return food.name.toLowerCase().contains(searchQuery);
                  }).toList();
                }

                // Sort by name
                foods.sort(
                  (a, b) =>
                      a.name.toLowerCase().compareTo(b.name.toLowerCase()),
                );

                if (foods.isEmpty && searchQuery.isNotEmpty) {
                  return const Center(
                    child: Text("No matching food items found."),
                  );
                } else if (foods.isEmpty) {
                  return const Center(child: Text("No food items found."));
                }

                return GridView.builder(
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
                    final food = foods[index];
                    return InkWell(
                      onTap: () => Get.to(() => FoodDetailScreen(food: food)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
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

                                // Favorite Button
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Obx(() {
                                    // Assuming food.id is unique and used for identification
                                    final isFav = favoriteController.isFavorite(
                                      food.id.toString(),
                                    );
                                    return Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(50),
                                        onTap: () {
                                          favoriteController.toggleFavorite(
                                            food,
                                          );
                                        },
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
                                        "\$${food.price.toStringAsFixed(2)}",
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
