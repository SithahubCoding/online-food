// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/product_model.dart';
// import './detail_screen.dart';
// import '../../app/controllers/product_controller.dart';
// import '../controllers/favorite_controller.dart';

// class ProductListScreen extends StatefulWidget {
//   final String? categoryName;
//   final String? subCategoryName;

//   const ProductListScreen({super.key, this.categoryName, this.subCategoryName});

//   @override
//   State<ProductListScreen> createState() => _ProductListScreenState();
// }

// class _ProductListScreenState extends State<ProductListScreen> {
//   final ProductController productController = Get.put(ProductController());
//   final TextEditingController _searchController = TextEditingController();
//   final FavoriteController favoriteController = Get.find<FavoriteController>();
//   String searchQuery = '';

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   Future<void> _refreshProducts() async {
//     setState(() {});
//   }

//   List<FoodModel> get filteredFoods {
//     return productController.productList.where((food) {
//       final matchesCategory =
//           widget.categoryName == null ||
//           food.category.toLowerCase() == widget.categoryName!.toLowerCase();
//       final matchesSubCategory =
//           widget.subCategoryName == null ||
//           food.subCategory.toLowerCase() ==
//               widget.subCategoryName!.toLowerCase();

//       final matchesSearch =
//           searchQuery.isEmpty ||
//           food.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
//           food.id.toLowerCase().contains(searchQuery.toLowerCase());

//       return matchesCategory && matchesSubCategory && matchesSearch;
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final title = widget.subCategoryName ?? widget.categoryName ?? "Products";

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         backgroundColor: Colors.green.shade700,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: RefreshIndicator(
//         onRefresh: _refreshProducts,
//         color: Colors.green.shade700,
//         child: SingleChildScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           child: Column(
//             children: [
//               // Search bar with modern style
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade100,
//                   borderRadius: BorderRadius.circular(30),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.shade300,
//                       blurRadius: 5,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(
//                     9.0,
//                   ), // padding around the TextField
//                   child: TextField(
//                     controller: _searchController,
//                     decoration: InputDecoration(
//                       hintText: "Search by name or ID",
//                       prefixIcon: const Icon(Icons.search, color: Colors.green),
//                       suffixIcon: IconButton(
//                         icon: const Icon(Icons.clear),
//                         onPressed: () {
//                           _searchController.clear();
//                           setState(() => searchQuery = '');
//                         },
//                       ),
//                       border: InputBorder.none,
//                       contentPadding: const EdgeInsets.symmetric(
//                         vertical: 14,
//                       ), // padding inside TextField
//                     ),
//                     onChanged: (value) {
//                       setState(() => searchQuery = value);
//                     },
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Products Grid
//               StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance
//                     .collection('product_db')
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) {
//                     return const Center(child: CircularProgressIndicator());
//                   }

//                   final allFoods = snapshot.data!.docs.map((doc) {
//                     final data = doc.data() as Map<String, dynamic>;
//                     return FoodModel.fromFirestore(doc.id, data);
//                   }).toList();

//                   productController.productList.value = allFoods;

//                   final foods = filteredFoods;

//                   if (foods.isEmpty) {
//                     return const Center(
//                       child: Padding(
//                         padding: EdgeInsets.only(top: 50),
//                         child: Text(
//                           "No products found",
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ),
//                     );
//                   }

//                   return buildFoodGrid(foods);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildFoodGrid(List<FoodModel> foods) {
//     return GridView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         mainAxisSpacing: 15,
//         crossAxisSpacing: 15,
//         childAspectRatio: 0.76,
//       ),
//       itemCount: foods.length,
//       itemBuilder: (context, index) {
//         final food = foods[index];
//         return InkWell(
//           onTap: () => Get.to(() => FoodDetailScreen(food: food)),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Theme.of(context).cardColor,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: const Color.fromARGB(37, 0, 0, 0),
//                   offset: const Offset(0, 4),
//                   blurRadius: 6,
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Stack(
//                   children: [
//                     ClipRRect(
//                       borderRadius: const BorderRadius.vertical(
//                         top: Radius.circular(12),
//                       ),
//                       child: Image.network(
//                         food.image,
//                         width: double.infinity,
//                         height: 150,
//                         fit: BoxFit.cover,
//                         errorBuilder: (c, e, s) =>
//                             const Icon(Icons.image_not_supported, size: 100),
//                       ),
//                     ),
//                     // ❤️ Favorite Button
//                     Positioned(
//                       top: 8,
//                       right: 8,
//                       child: Obx(() {
//                         final isFav = favoriteController.favoriteItems.any(
//                           (f) => f.id == food.id,
//                         );
//                         return InkWell(
//                           onTap: () => favoriteController.toggleFavorite(food),
//                           borderRadius: BorderRadius.circular(50),
//                           child: Padding(
//                             padding: const EdgeInsets.all(4.0),
//                             child: Icon(
//                               isFav ? Icons.favorite : Icons.favorite_border,
//                               color: isFav ? Colors.red : Colors.white,
//                               size: 26,
//                             ),
//                           ),
//                         );
//                       }),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         food.name,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       Row(
//                         children: [
//                           Text("\$${food.price.toStringAsFixed(2)}"),
//                           const Spacer(),
//                           const Icon(Icons.star, color: Colors.amber, size: 16),
//                           Text(
//                             "${food.rating}",
//                             style: const TextStyle(fontSize: 14),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';
import './detail_screen.dart';
import '../../app/controllers/product_controller.dart';
import '../controllers/favorite_controller.dart';

class ProductListScreen extends StatefulWidget {
  final String? categoryName;
  final String? subCategoryName;

  const ProductListScreen({super.key, this.categoryName, this.subCategoryName});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductController productController = Get.put(ProductController());
  final TextEditingController _searchController = TextEditingController();
  final FavoriteController favoriteController = Get.find<FavoriteController>();
  String searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _refreshProducts() async {
    setState(() {});
  }

  List<FoodModel> get filteredFoods {
    return productController.productList.where((food) {
      final matchesCategory =
          widget.categoryName == null ||
          food.category.toLowerCase() == widget.categoryName!.toLowerCase();
      final matchesSubCategory =
          widget.subCategoryName == null ||
          food.subCategory.toLowerCase() ==
              widget.subCategoryName!.toLowerCase();

      final matchesSearch =
          searchQuery.isEmpty ||
          food.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          food.id.toLowerCase().contains(searchQuery.toLowerCase());

      return matchesCategory && matchesSubCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final title = widget.subCategoryName ?? widget.categoryName ?? "Products";

    final backgroundColor = isDark ? Colors.black87 : const Color(0xFFF5F5F5);
    final cardColor = isDark ? Colors.grey[850] : Colors.white;
    final primaryColor = isDark ? Colors.orange : Colors.orange;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          title,
          textAlign: TextAlign.start, // ✅ Correct usage
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),

        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshProducts,
        color: primaryColor,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              // Search Bar
              SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[800] : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search by name or ID",
                      prefixIcon: Icon(Icons.search, color: primaryColor),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: isDark ? Colors.white : Colors.black54,
                        ),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => searchQuery = '');
                        },
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                    onChanged: (value) => setState(() => searchQuery = value),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Products Grid
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('product_db')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final allFoods = snapshot.data!.docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return FoodModel.fromFirestore(doc.id, data);
                  }).toList();

                  productController.productList.value = allFoods;

                  final foods = filteredFoods;

                  if (foods.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Text(
                          "No products found",
                          style: TextStyle(
                            fontSize: 16,
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                      ),
                    );
                  }

                  return buildFoodGrid(foods, cardColor, isDark, primaryColor);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFoodGrid(
    List<FoodModel> foods,
    Color? cardColor,
    bool isDark,
    Color primaryColor,
  ) {
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
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: isDark ? Colors.black54 : Colors.grey.shade300,
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
                        errorBuilder: (c, e, s) =>
                            const Icon(Icons.image_not_supported, size: 100),
                      ),
                    ),
                    // Favorite Button
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Obx(() {
                        final isFav = favoriteController.favoriteItems.any(
                          (f) => f.id == food.id,
                        );
                        return InkWell(
                          onTap: () => favoriteController.toggleFavorite(food),
                          borderRadius: BorderRadius.circular(50),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: isFav ? Colors.red : Colors.white,
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
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            "\$${food.price.toStringAsFixed(2)}",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          Text(
                            "${food.rating}",
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
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
  }
}
