import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favorite_controller.dart';
// import '../models/product_model.dart';

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
            return ListTile(
              leading: Image.asset(food.image, width: 50, height: 50),
              title: Text(food.name),
              subtitle: Text("\$${food.price}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  await favoriteController.toggleFavorite(food);
                  Get.snackbar("Removed", "${food.name} removed from favorites");
                },
              ),
            );
          },
        );
      }),
    );
  }
}
