// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/favorite_controller.dart';
// import 'detail_screen.dart';
// import '../../app/theme/custom_colors.dart';
// class FavoriteScreen extends StatelessWidget {
//   FavoriteScreen({super.key});
//   final FavoriteController favoriteController = Get.put(FavoriteController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: const Text("Favorite Foods"),
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.black,
//       ),
//       body: Obx(() {
//         final favorites = favoriteController.favoriteItems;
//         if (favorites.isEmpty) {
//           return Center(
//             child: Text(
//               "No favorite foods yet",
//               style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//             ),
//           );
//         }

//         return ListView.builder(
//           padding: const EdgeInsets.all(16),
//           itemCount: favorites.length,
//           itemBuilder: (context, index) {
//             final food = favorites[index];
//             return InkWell(
//               onTap: () => Get.to(() => FoodDetailScreen(food: food)),
//               borderRadius: BorderRadius.circular(16),
//               child: Container(
//                 margin: const EdgeInsets.only(bottom: 16),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color.fromARGB(37, 0, 0, 0),
//                       blurRadius: 6,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     ClipRRect(
//                       borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
//                       child: Image.network(
//                         food.image,
//                         height: 100,
//                         width: 100,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.all(12),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               food.name,
//                               style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               "\$${food.price.toStringAsFixed(2)}",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 14,
//                                 color: Theme.of(context).primaryColor,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(right: 12),
//                       child: Obx(() {
//                         final isFav = favoriteController.favoriteItems.any((f) => f.id == food.id);
//                         return InkWell(
//                           onTap: () => favoriteController.toggleFavorite(food),
//                           borderRadius: BorderRadius.circular(30),
//                           splashColor: Colors.red.withOpacity(0.2),
//                           child: Padding(
//                             padding: const EdgeInsets.all(6),
//                             child: Icon(
//                               isFav ? Icons.favorite : Icons.favorite_border,
//                               color: isFav ? Colors.red : Colors.grey[400],
//                               size: 28,
//                             ),
//                           ),
//                         );
//                       }),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/favorite_controller.dart';
// import '../controllers/cart_controller.dart';
// import 'detail_screen.dart';

// class FavoriteScreen extends StatelessWidget {
//   FavoriteScreen({super.key});

//   final FavoriteController favoriteController = Get.put(FavoriteController());
//   final CartController cartController = Get.put(CartController());

//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     final backgroundColor = isDarkMode ? Colors.black : Colors.grey[100];
//     final cardColor = isDarkMode ? Colors.grey[900] : Colors.white;

//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         title: const Text("Favorite Foods ❤️"),
//         elevation: 0,
//         centerTitle: true,
//         backgroundColor: Colors.orange,
//         foregroundColor: Colors.white,
//       ),
//       body: Obx(() {
//         final favorites = favoriteController.favoriteItems;

//         if (favorites.isEmpty) {
//           return const Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.favorite_border, size: 80, color: Colors.grey),
//                 SizedBox(height: 10),
//                 Text("No favorite foods yet 🍴",
//                     style: TextStyle(fontSize: 16, color: Colors.grey)),
//               ],
//             ),
//           );
//         }

//         return ListView.builder(
//           padding: const EdgeInsets.all(16),
//           itemCount: favorites.length,
//           itemBuilder: (context, index) {
//             final food = favorites[index];
//             final isFav = favoriteController.favoriteItems.any((f) => f.id == food.id);
//             final isInCart = cartController.items.any((item) => item.id == food.id);

//             return Container(
//               margin: const EdgeInsets.only(bottom: 16),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 color: cardColor,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 6,
//                     offset: const Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   // === Image ===
//                   ClipRRect(
//                     borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(16),
//                       bottomLeft: Radius.circular(16),
//                     ),
//                     child: Image.network(
//                       food.image,
//                       height: 110,
//                       width: 110,
//                       fit: BoxFit.cover,
//                     ),
//                   ),

//                   // === Info Section ===
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(12),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             food.name,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                               color: isDarkMode ? Colors.white : Colors.black87,
//                             ),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           const SizedBox(height: 6),
//                           Text(
//                             "\$${food.price.toStringAsFixed(2)}",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15,
//                               color: Colors.orange,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Row(
//                             children: [
//                               // === Add to Cart ===
//                               Expanded(
//                                 child: ElevatedButton.icon(
//                                   onPressed: () async {
//                                     await cartController.addToCart(food, 1);
//                                     Get.snackbar(
//                                       "Added to Cart 🛒",
//                                       "${food.name} added successfully!",
//                                       snackPosition: SnackPosition.BOTTOM,
//                                       backgroundColor: Colors.green.shade100,
//                                       colorText: Colors.green.shade800,
//                                     );
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.green,
//                                     padding: const EdgeInsets.symmetric(vertical: 8),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                   icon: Icon(
//                                     isInCart ? Icons.check_circle : Icons.shopping_cart_outlined,
//                                     size: 18,
//                                     color: Colors.white,
//                                   ),
//                                   label: Text(
//                                     isInCart ? "Added" : "Add to Cart",
//                                     style: const TextStyle(fontSize: 13, color: Colors.white),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 8),
//                               // === View Detail ===
//                               ElevatedButton(
//                                 onPressed: () => Get.to(() => FoodDetailScreen(food: food)),
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.blue.shade50,
//                                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                                 child: const Text(
//                                   "View",
//                                   style: TextStyle(
//                                     color: Colors.blue,
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),

//                   // === Favorite Button ===
//                   Padding(
//                     padding: const EdgeInsets.only(right: 12),
//                     child: InkWell(
//                       onTap: () => favoriteController.toggleFavorite(food),
//                       borderRadius: BorderRadius.circular(30),
//                       splashColor: Colors.red.withOpacity(0.2),
//                       child: Padding(
//                         padding: const EdgeInsets.all(6),
//                         child: Icon(
//                           isFav ? Icons.favorite : Icons.favorite_border,
//                           color: isFav ? Colors.red : Colors.grey[400],
//                           size: 26,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favorite_controller.dart';
import '../controllers/cart_controller.dart';
import 'detail_screen.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});

  final FavoriteController favoriteController = Get.put(FavoriteController());
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? Colors.black : Colors.grey[100];
    final cardColor = isDarkMode ? Colors.grey[900] : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text(
          "My Favorites ❤️",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.orange,
        foregroundColor: isDarkMode ? Colors.white : Colors.black,
      ),
      body: Obx(() {
        final favorites = favoriteController.favoriteItems;

        if (favorites.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                SizedBox(height: 10),
                Text(
                  "No favorite foods yet 🍴",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final food = favorites[index];
            final isFav = favoriteController.favoriteItems.any((f) => f.id == food.id);
            final isInCart = cartController.items.any((item) => item.id == food.id);

            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ===== Image =====
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                        child: Image.network(
                          food.image,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Favorite icon
                      Positioned(
                        top: 6,
                        right: 6,
                        child: GestureDetector(
                          onTap: () => favoriteController.toggleFavorite(food),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.85),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: isFav ? Colors.red : Colors.grey[600],
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // ===== Info =====
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            food.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: textColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "\$${food.price.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ===== Action Icons =====
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // View Detail Icon
                        IconButton(
                          icon: Icon(
                            Icons.visibility_outlined,
                            color: isDarkMode
                                ? Colors.white
                                : const Color(0xFF142338),
                          ),
                          tooltip: "View Details",
                          onPressed: () => Get.to(() => FoodDetailScreen(food: food)),
                        ),

                        // Add to Cart Icon
                        IconButton(
                          icon: Icon(
                            isInCart
                                ? Icons.check_circle
                                : Icons.add_shopping_cart_rounded,
                            color: isInCart
                                ? Colors.green
                                : (isDarkMode
                                    ? Colors.white
                                    : const Color(0xFF142338)),
                          ),
                          tooltip: "Add to Cart",
                          onPressed: () async {
                            await cartController.addToCart(food, 1);
                            Get.snackbar(
                              "Added to Cart 🛒",
                              "${food.name} added successfully!",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green.shade100,
                              colorText: Colors.green.shade800,
                              duration: const Duration(seconds: 2),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
