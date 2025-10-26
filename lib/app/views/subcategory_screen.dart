import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'package:get/get.dart';
import '../models/category_model.dart';
import './detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubCategoryOneScreen extends StatelessWidget {
  final CategoryModel category;
  final String subCategoryName;

  const SubCategoryOneScreen({
    super.key,
    required this.category,
    required this.subCategoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$subCategoryName Items")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('product_db')
            .where('category', isEqualTo: category.name)
            .where('subCategory', isEqualTo: subCategoryName)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No items found."));
          }

          final foods = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return FoodModel.fromFirestore(doc.id, data);
          }).toList();

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: foods.length,
            itemBuilder: (context, index) {
              final food = foods[index];
              return GestureDetector(
                onTap: () {
                    // TODO: ត្រូវធានាថា FoodDetailScreen ត្រូវបាន Import និងអាចចូលប្រើបាន
                    // Get.to(() => FoodDetailScreen(food: food));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Expanded(
                          child: Image.network(food.image,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.image, size: 50)),
                      ),
                      const SizedBox(height: 10),
                      Text(food.name, textAlign: TextAlign.center),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}