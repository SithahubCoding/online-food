

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favorite_controller.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteController favoriteController = Get.find<FavoriteController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Favorite List")),
      body: Obx(() {
        final favorites = favoriteController.favoriteItems;

        if (favorites.isEmpty) {
          return const Center(child: Text("No favorite items yet."));
        }

        return ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final food = favorites[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: food.image.startsWith('http')
                    ? Image.network(food.image, width: 50, height: 50, fit: BoxFit.cover)
                    : Image.asset(food.image, width: 50, height: 50, fit: BoxFit.cover),
                title: Text(food.name),
                subtitle: Text("\$${food.price.toStringAsFixed(2)}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await favoriteController.toggleFavorite(food);
                    Get.snackbar(
                      "Removed",
                      "${food.name} removed from favorites",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red.withOpacity(0.8),
                      colorText: Colors.white,
                      margin: const EdgeInsets.all(10),
                      duration: const Duration(seconds: 2),
                    );
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
