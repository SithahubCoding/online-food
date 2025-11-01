// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/product_model.dart';
// import './detail_screen.dart';
// import '../../app/theme/custom_colors.dart';
// import '../../app/controllers/product_controller.dart';

// class SubCategoryOneScreen extends StatefulWidget {
//   final FoodModel food;
//   const SubCategoryOneScreen({super.key, required this.food});
//   @override
//   State<SubCategoryOneScreen> createState() => _SubCategoryOneScreenState();
// }

// class _SubCategoryOneScreenState extends State<SubCategoryOneScreen> {
//   final ProductController productController = Get.put(ProductController());
//   final TextEditingController _searchController = TextEditingController();
//   String searchQuery = '';

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   Future<void> _refreshProducts() async {
//     setState(() {});
//   }

//   // Filter foods by id, name, category, or subCategory
//   List<FoodModel> get filteredFoods {
//     if (searchQuery.isEmpty) return productController.productList;
//     final q = searchQuery.toLowerCase();
//     return productController.productList.where((food) {
//       return food.id.toLowerCase().contains(q) ||
//           food.name.toLowerCase().contains(q) ||
//           food.category.toLowerCase().contains(q) ||
//           food.subCategory.toLowerCase().contains(q);
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final customColors =
//         Theme.of(context).extension<CustomColors>() ??
//         const CustomColors(
//           accentColor: Colors.amber,
//           darkTextColor: Colors.black,
//         );
//     bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.food.subCategory),
//         elevation: 0,
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
//       ),
//       body: RefreshIndicator(
//         onRefresh: _refreshProducts,
//         child: SingleChildScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               // Modern Search Bar
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30),
//                   color: isDarkMode ? Colors.white : Colors.white,
//                   border: isDarkMode
//                       ? null
//                       : Border.all(color: const Color(0xFF142338), width: 1),
//                   boxShadow: isDarkMode
//                       ? null
//                       : [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.3),
//                             spreadRadius: 1,
//                             blurRadius: 5,
//                             offset: const Offset(0, 3),
//                           ),
//                         ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(4.0),
//                   child: TextField(
//                     controller: _searchController,
//                     style: TextStyle(
//                       color: isDarkMode
//                           ? Colors.black
//                           : const Color(0xFF142338),
//                     ),
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       prefixIcon: Icon(
//                         Icons.search,
//                         color: isDarkMode
//                             ? Colors.black54
//                             : const Color(0xFF142338),
//                       ),
//                       hintText: "Search by ID, Name, Category or SubCategory",
//                       hintStyle: TextStyle(
//                         color: isDarkMode
//                             ? Colors.black38
//                             : const Color(0xFF142338).withOpacity(0.5),
//                       ),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           Icons.clear,
//                           color: isDarkMode
//                               ? Colors.black54
//                               : const Color(0xFF142338),
//                         ),
//                         onPressed: () {
//                           _searchController.clear();
//                           setState(() => searchQuery = '');
//                         },
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(vertical: 14),
//                     ),
//                     onChanged: (value) {
//                       setState(() => searchQuery = value.toLowerCase());
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
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                     return const Center(child: Text("No food items found."));
//                   }

//                   // Populate productController
//                   final allFoods = snapshot.data!.docs
//                       .map((doc) {
//                         final data = doc.data() as Map<String, dynamic>?;
//                         return data != null
//                             ? FoodModel.fromFirestore(doc.id, data)
//                             : null;
//                       })
//                       .whereType<FoodModel>()
//                       .toList();

//                   productController.productList.value = allFoods;

//                   final foods = filteredFoods;

//                   if (foods.isEmpty) {
//                     return const Center(
//                       child: Text("No matching food items found."),
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

//   // Grid builder
//   Widget buildFoodGrid(List<FoodModel> foods) {
//     return GridView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         mainAxisSpacing: 3,
//         crossAxisSpacing: 3,
//         childAspectRatio: 0.63,
//       ),
//       itemCount: foods.length,
//       itemBuilder: (context, index) {
//         final food = foods[index];
//         return buildFoodCard(food);
//       },
//     );
//   }

//   // Modern card for food
//   Widget buildFoodCard(FoodModel food) {
//     return GestureDetector(
//       onTap: () => Get.to(() => FoodDetailScreen(food: food)),
//       child: MouseRegion(
//         cursor: SystemMouseCursors.click,
//         child: Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           elevation: 3,
//           color: Theme.of(context).cardColor,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Food Image
//               ClipRRect(
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(16),
//                 ),
//                 child: Image.network(
//                   food.image,
//                   width: double.infinity,
//                   height: 110,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) =>
//                       const Icon(Icons.image_not_supported, size: 60),
//                 ),
//               ),
//               // Food Info
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
//                 child: Column(
//                   // crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       food.name,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                         letterSpacing: 0.3,
//                         height: 1.4,
//                         // ប្រើ customColors.darkTextColor ដើម្បីប្ដូរពណ៌អត្ថបទតាម theme
//                         color: context.customColors.darkTextColor,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 4),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             "\៛${food.price.toStringAsFixed(2)}",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 12,

//                               // ប្រើ customColors.darkTextColor សម្រាប់តម្លៃ
//                               color: Colors.amber,
//                             ),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/product_model.dart';
// import './detail_screen.dart';
// import '../../app/theme/custom_colors.dart';
// import '../../app/controllers/product_controller.dart';

// class SubCategoryOneScreen extends StatefulWidget {
//   final FoodModel food;
//   const SubCategoryOneScreen({super.key, required this.food});
//   @override
//   State<SubCategoryOneScreen> createState() => _SubCategoryOneScreenState();
// }

// class _SubCategoryOneScreenState extends State<SubCategoryOneScreen>
//     with TickerProviderStateMixin {
//   final ProductController productController = Get.put(ProductController());
//   final TextEditingController _searchController = TextEditingController();
//   String searchQuery = '';

//   late AnimationController _searchAnimController;
//   late AnimationController _gridAnimController;
//   late Animation<double> _searchAnimation;
//   late Animation<double> _gridAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _searchAnimController =
//         AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
//     _gridAnimController =
//         AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

//     _searchAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _searchAnimController, curve: Curves.easeOut),
//     );

//     _gridAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _gridAnimController, curve: Curves.easeOut),
//     );

//     _searchAnimController.forward();
//     Future.delayed(const Duration(milliseconds: 200), () {
//       _gridAnimController.forward();
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _searchAnimController.dispose();
//     _gridAnimController.dispose();
//     super.dispose();
//   }

//   Future<void> _refreshProducts() async {
//     setState(() {});
//   }

//   List<FoodModel> get filteredFoods {
//     if (searchQuery.isEmpty) return productController.productList;
//     final q = searchQuery.toLowerCase();
//     return productController.productList.where((food) {
//       return food.id.toLowerCase().contains(q) ||
//           food.name.toLowerCase().contains(q) ||
//           food.category.toLowerCase().contains(q) ||
//           food.subCategory.toLowerCase().contains(q);
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final customColors =
//         Theme.of(context).extension<CustomColors>() ??
//             const CustomColors(accentColor: Colors.amber, darkTextColor: Colors.black);

//     bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.food.subCategory,
//           style: const TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         elevation: 4,
//         shadowColor: Colors.black26,
//         automaticallyImplyLeading: true,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFFFFC107), Color(0xFFFF6F00)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: SafeArea(
//         child: RefreshIndicator(
//           onRefresh: _refreshProducts,
//           child: SingleChildScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               children: [
//                 // Animated Search Bar
//                 FadeTransition(
//                   opacity: _searchAnimation,
//                   child: SlideTransition(
//                     position: Tween<Offset>(
//                       begin: const Offset(0, -0.2),
//                       end: Offset.zero,
//                     ).animate(_searchAnimController),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(30),
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 8,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: TextField(
//                         controller: _searchController,
//                         style: const TextStyle(color: Colors.black87),
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           prefixIcon: const Icon(Icons.search, color: Colors.black54),
//                           hintText: "Search by ID, Name, Category or SubCategory",
//                           hintStyle: const TextStyle(color: Colors.black38),
//                           suffixIcon: IconButton(
//                             icon: const Icon(Icons.clear, color: Colors.black54),
//                             onPressed: () {
//                               _searchController.clear();
//                               setState(() => searchQuery = '');
//                             },
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(vertical: 14),
//                         ),
//                         onChanged: (value) {
//                           setState(() => searchQuery = value.toLowerCase());
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // Animated Products Grid
//                 StreamBuilder<QuerySnapshot>(
//                   stream: FirebaseFirestore.instance
//                       .collection('product_db')
//                       .snapshots(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator());
//                     }
//                     if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                       return const Center(child: Text("No food items found."));
//                     }

//                     final allFoods = snapshot.data!.docs
//                         .map((doc) {
//                           final data = doc.data() as Map<String, dynamic>?;
//                           return data != null
//                               ? FoodModel.fromFirestore(doc.id, data)
//                               : null;
//                         })
//                         .whereType<FoodModel>()
//                         .toList();

//                     productController.productList.value = allFoods;

//                     final foods = filteredFoods;

//                     if (foods.isEmpty) {
//                       return const Center(
//                         child: Text("No matching food items found."),
//                       );
//                     }

//                     return FadeTransition(
//                       opacity: _gridAnimation,
//                       child: buildFoodGrid(foods, customColors),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildFoodGrid(List<FoodModel> foods, CustomColors customColors) {
//     return GridView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         mainAxisSpacing: 6,
//         crossAxisSpacing: 6,
//         childAspectRatio: 0.63,
//       ),
//       itemCount: foods.length,
//       itemBuilder: (context, index) {
//         final food = foods[index];
//         return buildFoodCard(food, customColors);
//       },
//     );
//   }

//   Widget buildFoodCard(FoodModel food, CustomColors customColors) {
//     return GestureDetector(
//       onTap: () => Get.to(() => FoodDetailScreen(food: food)),
//       child: MouseRegion(
//         cursor: SystemMouseCursors.click,
//         child: Card(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           elevation: 4,
//           shadowColor: Colors.black26,
//           color: Colors.white,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ClipRRect(
//                 borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
//                 child: Image.network(
//                   food.image,
//                   width: double.infinity,
//                   height: 110,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) =>
//                       const Icon(Icons.image_not_supported, size: 60),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
//                 child: Column(
//                   children: [
//                     Text(
//                       food.name,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                         color: customColors.darkTextColor,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       "\៛${food.price.toStringAsFixed(2)}",
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 12,
//                         color: Colors.amber,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';
import './detail_screen.dart';
import '../../app/theme/custom_colors.dart';
import '../../app/controllers/product_controller.dart';

class SubCategoryOneScreen extends StatefulWidget {
  final FoodModel food;
  const SubCategoryOneScreen({super.key, required this.food});

  @override
  State<SubCategoryOneScreen> createState() => _SubCategoryOneScreenState();
}

class _SubCategoryOneScreenState extends State<SubCategoryOneScreen>
    with TickerProviderStateMixin {
  final ProductController productController = Get.put(ProductController());
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  late AnimationController _searchAnimController;
  late Animation<double> _searchAnimation;

  late AnimationController _gridAnimController;

  @override
  void initState() {
    super.initState();

    // Search bar animation
    _searchAnimController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _searchAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _searchAnimController, curve: Curves.easeOut),
    );
    _searchAnimController.forward();

    // Grid stagger animation controller
    _gridAnimController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _gridAnimController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchAnimController.dispose();
    _gridAnimController.dispose();
    super.dispose();
  }

  Future<void> _refreshProducts() async {
    setState(() {});
  }

  List<FoodModel> get filteredFoods {
    if (searchQuery.isEmpty) return productController.productList;
    final q = searchQuery.toLowerCase();
    return productController.productList.where((food) {
      return food.id.toLowerCase().contains(q) ||
          food.name.toLowerCase().contains(q) ||
          food.category.toLowerCase().contains(q) ||
          food.subCategory.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final customColors =
        Theme.of(context).extension<CustomColors>() ??
            const CustomColors(accentColor: Colors.amber, darkTextColor: Colors.black);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.food.subCategory,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.black26,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFC107), Color(0xFFFF6F00)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshProducts,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                SizedBox(height: 12,),
                // Animated Search Bar
                FadeTransition(
                  opacity: _searchAnimation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, -0.2),
                      end: Offset.zero,
                    ).animate(_searchAnimController),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4)),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.black54),
                          hintText: "Search by ID, Name, Category or SubCategory",
                          hintStyle: const TextStyle(color: Colors.black38),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear, color: Colors.black54),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => searchQuery = '');
                            },
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onChanged: (value) {
                          setState(() => searchQuery = value.toLowerCase());
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Products Grid with staggered animation
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

                    final allFoods = snapshot.data!.docs
                        .map((doc) {
                          final data = doc.data() as Map<String, dynamic>?;
                          return data != null
                              ? FoodModel.fromFirestore(doc.id, data)
                              : null;
                        })
                        .whereType<FoodModel>()
                        .toList();

                    productController.productList.value = allFoods;

                    final foods = filteredFoods;

                    if (foods.isEmpty) {
                      return const Center(
                          child: Text("No matching food items found."));
                    }

                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 6,
                        crossAxisSpacing: 6,
                        childAspectRatio: 0.63,
                      ),
                      itemCount: foods.length,
                      itemBuilder: (context, index) {
                        final food = foods[index];

                        final double start = index * 0.05;
                        final double end = start + 0.5;
                        final animation = CurvedAnimation(
                          parent: _gridAnimController,
                          curve: Interval(
                              start.clamp(0.0, 1.0), end.clamp(0.0, 1.0),
                              curve: Curves.easeOut),
                        );

                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                                    begin: const Offset(0, 0.2), end: Offset.zero)
                                .animate(animation),
                            child: buildFoodCard(food, customColors),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFoodCard(FoodModel food, CustomColors customColors) {
    return GestureDetector(
      onTap: () => Get.to(() => FoodDetailScreen(food: food)),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          shadowColor: Colors.black26,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  food.image,
                  width: double.infinity,
                  height: 110,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported, size: 60),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                child: Column(
                  children: [
                    Text(
                      food.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Theme.of(context).brightness == Brightness.dark
        ? Colors.black      // Dark Mode -> White text
        : customColors.darkTextColor,),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "\៛${food.price.toStringAsFixed(2)}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.amber),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
