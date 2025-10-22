import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/product_model.dart';
import '../../theme/custom_colors.dart';
import '../category_screen.dart';
import '../detail_screen.dart';
import '../../controllers/favorite_controller.dart';

class HomeMainScreen extends StatelessWidget {
  const HomeMainScreen({super.key});

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
                            Image.asset(
                              categories[index].icon,
                              width: 100,
                              height: 100,
                            ),
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
              const Text(
                "Popular Food",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => Get.to(() => CategoryScreen()),
                child: const Row(
                  children: [
                    Text("See All", style: TextStyle(color: Colors.orange)),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.orange,
                      size: 14,
                    ),
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
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Obx(() {
                              final favController =
                                  Get.find<FavoriteController>();
                              final isFav = favController.favoriteItems.any(
                                (item) => item.id == foods[index].id,
                              );

                              return InkWell(
                                onTap: () {
                                  favController.toggleFavorite(foods[index]);
                                },
                                child: Icon(
                                  isFav
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.amber,
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
                              foods[index].name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Text("\$${foods[index].price}"),
                                const Spacer(),
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                Text(
                                  "${foods[index].rating}",
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
          ),
        ],
      ),
    );
  }
}
