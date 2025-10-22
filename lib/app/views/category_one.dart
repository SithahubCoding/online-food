import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'package:get/get.dart';
// import 'home/home_screen.dart';
// import '../models/product_model.dart';
// import './category_screen.dart';
import './detail_screen.dart';

class CategoryOne extends StatelessWidget {
  final CategoryModel category;
  const CategoryOne({required this.category});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${category.name} Subcategories")),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemCount: category.subCategories.length,
        itemBuilder: (context, index) {
          final sub = category.subCategories[index];
          return GestureDetector(
            onTap: () {
              final food = FoodModel(
                id: DateTime.now().millisecondsSinceEpoch, // unique id
                name: sub.name,
                image: sub.icon,
                description: "Delicious ${sub.name}",
                price: 5.0,
                category: category.name,
                rating: 4.5, // <-- REQUIRED field, placeholder value
              );

              Get.to(() => FoodDetailScreen(food: food));
            },

            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.asset(sub.icon),
                  const SizedBox(height: 10),
                  Text(sub.name),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
