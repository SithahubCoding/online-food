
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/category_model.dart';
import '../models/sub_category_model.dart'; 
import 'subcategory_screen.dart'; // ត្រូវធានាថាឯកសារនេះមាន
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryScreen extends StatelessWidget {
  final CategoryModel category;

  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // ⚠️ ខ្ញុំសន្មតថា customColors គឺជា class ដែលអាចចូលប្រើបាន
    // final customColors = Theme.of(context).extension<CustomColors>()!;
    
    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('category_db')
            .doc(category.id)
            .collection('subCategories') 
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No subcategories found."));
          }

          final subCategories = snapshot.data!.docs.map((doc) {
            return SubCategoryModel.fromFirestore(doc);
          }).toList();

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.8,
            ),
            itemCount: subCategories.length,
            itemBuilder: (context, index) {
              final sub = subCategories[index];
              return InkWell(
                onTap: () {
                  Get.to(() => SubCategoryOneScreen(
                          category: category,
                          subCategoryName: sub.name,
                      ));
                },
                child: Container(
                  // ខ្ញុំដកកូដ UI មួយចំនួនដែលត្រូវការ customColors ចេញដើម្បីឱ្យកូដនេះដំណើរការ
                  decoration: BoxDecoration(
                    color: Colors.grey[200], 
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 4),
                            blurRadius: 8,
                        ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (sub.icon.startsWith('http'))
                        Image.network(sub.icon,
                            width: 100, height: 100, fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported, size: 60))
                      else
                        Image.asset(sub.icon,
                            width: 100, height: 100, fit: BoxFit.cover),
                      const SizedBox(height: 10),
                      Text(sub.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
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