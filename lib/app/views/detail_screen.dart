// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../models/product_model.dart';
// import '../controllers/cart_controller.dart';
// import '../controllers/favorite_controller.dart';
// import '../controllers/product_controller.dart';
// import '../theme/custom_colors.dart';
// import './cart_screen.dart';

// class FoodDetailScreen extends StatefulWidget {
//   final FoodModel food;
//   const FoodDetailScreen({super.key, required this.food});

//   @override
//   State<FoodDetailScreen> createState() => _FoodDetailScreenState();
// }

// class _FoodDetailScreenState extends State<FoodDetailScreen>
//     with SingleTickerProviderStateMixin {
//   final CartController cartController = Get.put(CartController());
//   final ProductController productController = Get.find<ProductController>();
//   final FavoriteController favoriteController = Get.find<FavoriteController>();

//   late TabController _tabController;
//   int _quantity = 1;
//   int _currentPage = 0;
//   late List<FoodModel> foodVariants;
//   final PageController _pageController = PageController();
//   final int maxSliderCount = 3;

//   final Map<String, Map<String, String>> foodIngredients = {
//     '1': {
//       'Bun': '2 pcs',
//       'Patty': '1 pc',
//       'Cheese': '1 slice',
//       'Lettuce': '20 gm',
//     },
//     '2': {
//       'Dough': '200 gm',
//       'Cheese': '100 gm',
//       'Tomato': '50 gm',
//       'Pepperoni': '50 gm',
//     },
//     '3': {'Chicken': '12 pcs', 'Flour': '50 gm', 'Spices': '10 gm'},
//     '4': {
//       'Rice': '100 gm',
//       'Salmon': '50 gm',
//       'Seaweed': '20 gm',
//       'Avocado': '30 gm',
//     },
//   };

//   @override
//   void initState() {
//     super.initState();

//     _tabController = TabController(length: 2, vsync: this);

//     foodVariants = productController.productList
//         .where((f) => f.category == widget.food.category)
//         .take(maxSliderCount)
//         .toList();

//     if (!foodVariants.any((f) => f.id == widget.food.id)) {
//       foodVariants.insert(0, widget.food);
//     }

//     int initialPage = foodVariants.indexWhere((f) => f.id == widget.food.id);
//     if (initialPage != -1 && initialPage != 0) {
//       final currentFood = foodVariants.removeAt(initialPage);
//       foodVariants.insert(0, currentFood);
//     }

//     _pageController.addListener(() {
//       if (_pageController.page != null) {
//         int next = _pageController.page!.round();
//         if (_currentPage != next) {
//           setState(() {
//             _currentPage = next;
//           });
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     _tabController.dispose();
//     super.dispose();
//   }

//   void _onThumbnailTap(int index) {
//     _pageController.animateToPage(
//       index,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }

//   List<Widget> _buildIngredientList(
//     Map<String, String> ingredients,
//     CustomColors? colors,
//   ) {
//     if (ingredients.isEmpty) {
//       return [const Center(child: Text('No ingredients specified'))];
//     }
//     return ingredients.entries.map((entry) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 4.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               entry.key,
//               style: TextStyle(color: colors?.darkTextColor, fontSize: 16),
//             ),
//             Text(
//               entry.value,
//               style: TextStyle(
//                 color: Theme.of(context).disabledColor,
//                 fontSize: 16,
//               ),
//             ),
//           ],
//         ),
//       );
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colors =
//         Theme.of(context).extension<CustomColors>() ??
//         const CustomColors(
//           accentColor: Colors.amber,
//           darkTextColor: Colors.black,
//         );

//     final currentIngredients = foodIngredients[widget.food.id] ?? {};

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: Stack(
//         children: [
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             height: 300,
//             child: Container(color: colors.accentColor),
//           ),
//           ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               SizedBox(
//                 height: 350,
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: 80,
//                       padding: const EdgeInsets.only(top: 80, left: 10),
//                       child: Column(
//                         children: List.generate(foodVariants.length, (index) {
//                           return Padding(
//                             padding: const EdgeInsets.only(bottom: 10),
//                             child: InkWell(
//                               onTap: () => _onThumbnailTap(index),
//                               child: Container(
//                                 width: 60,
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   border: Border.all(
//                                     color: index == _currentPage
//                                         ? colors.accentColor ?? Colors.amber
//                                         : Theme.of(context).dividerColor,
//                                     width: index == _currentPage ? 3 : 1,
//                                   ),
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(8),
//                                   child: Image.network(
//                                     foodVariants[index].image,
//                                     fit: BoxFit.cover,
//                                     errorBuilder: (c, e, s) =>
//                                         const Icon(Icons.fastfood, size: 40),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         }),
//                       ),
//                     ),
//                     Expanded(
//                       child: Container(
//                         padding: const EdgeInsets.only(top: 50),
//                         child: PageView.builder(
//                           controller: _pageController,
//                           itemCount: foodVariants.length,
//                           itemBuilder: (context, index) {
//                             return Center(
//                               child: Image.network(
//                                 foodVariants[index].image,
//                                 width: 250,
//                                 height: 250,
//                                 fit: BoxFit.cover,
//                                 errorBuilder: (c, e, s) =>
//                                     const Icon(Icons.fastfood, size: 200),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).cardColor,
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30),
//                   ),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: const Color.fromARGB(37, 0, 0, 0),
//                       blurRadius: 10,
//                       offset: Offset(0, -2),
//                     ),
//                   ],
//                 ),
//                 padding: const EdgeInsets.all(24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: Text(
//                             widget.food.name,
//                             style: TextStyle(
//                               fontSize: 28,
//                               fontWeight: FontWeight.bold,
//                               color: colors.darkTextColor,
//                             ),
//                           ),
//                         ),
//                         Obx(() {
//                           bool isFav = favoriteController.favoriteItems.any(
//                             (f) => f.id == widget.food.id,
//                           );

//                           return IconButton(
//                             icon: Icon(
//                               isFav ? Icons.favorite : Icons.favorite_border,
//                               color: Colors.amber,
//                             ),
//                             onPressed: () =>
//                                 favoriteController.toggleFavorite(widget.food),
//                           );
//                         }),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         const Icon(
//                           Icons.location_on,
//                           color: Colors.amber,
//                           size: 16,
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           widget.food.category,
//                           style: TextStyle(
//                             color: Theme.of(context).textTheme.bodySmall?.color,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     TabBar(
//                       controller: _tabController,
//                       labelColor: colors.darkTextColor,
//                       unselectedLabelColor: Theme.of(context).disabledColor,
//                       indicatorColor: colors.accentColor,
//                       tabs: const [
//                         Tab(text: "Details"),
//                         Tab(text: "Ingredients"),
//                         Tab(text: "Reviews"),
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                     SizedBox(
//                       height: 200,
//                       child: TabBarView(
//                         controller: _tabController,
//                         children: [
//                           SingleChildScrollView(
//                             child: Text(
//                               widget.food.description,
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Theme.of(
//                                   context,
//                                 ).textTheme.bodyMedium?.color,
//                               ),
//                             ),
//                           ),
//                           ListView(
//                             children: _buildIngredientList(
//                               currentIngredients,
//                               colors,
//                             ),
//                           ),
//                           Center(
//                             child: Text(
//                               "⭐ Reviews will be here",
//                               style: TextStyle(
//                                 color: Theme.of(context).disabledColor,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16.0,
//                   vertical: 8.0,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.arrow_back_ios),
//                       onPressed: () => Get.back(),
//                     ),
//                     // 🔥 CartButton with Badge
//                     Stack(
//                       children: [
//                         IconButton(
//                           icon: const Icon(
//                             Icons.shopping_cart,
//                             color: Colors.black87,
//                           ),
//                           onPressed: () => Get.to(() => const CartScreen()),
//                         ),
//                         Positioned(
//                           right: 4,
//                           top: 4,
//                           child: Obx(() {
//                             int totalCount = cartController.quantities.fold(
//                               0,
//                               (a, b) => a + b,
//                             );
//                             if (totalCount == 0) return const SizedBox.shrink();
//                             return Container(
//                               padding: const EdgeInsets.all(4),
//                               decoration: BoxDecoration(
//                                 color: Colors.redAccent,
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                   color: Colors.white,
//                                   width: 1.5,
//                                 ),
//                               ),
//                               constraints: const BoxConstraints(
//                                 minWidth: 20,
//                                 minHeight: 20,
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   '$totalCount',
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         decoration: BoxDecoration(
//           color: Theme.of(context).cardColor,
//           boxShadow: const [
//             BoxShadow(
//               color: const Color.fromARGB(37, 0, 0, 0),
//               blurRadius: 5,
//               offset: Offset(0, -2),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.remove_circle, color: colors.accentColor),
//                   onPressed: () => setState(() {
//                     if (_quantity > 1) _quantity--;
//                   }),
//                 ),
//                 Text(
//                   '$_quantity',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: colors.darkTextColor,
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.add_circle, color: colors.accentColor),
//                   onPressed: () => setState(() => _quantity++),
//                 ),
//               ],
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: colors.accentColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 30,
//                   vertical: 15,
//                 ),
//               ),
//               onPressed: () async {
//                 await cartController.addToCart(widget.food, _quantity);

//                 Get.snackbar(
//                   "🛒 Cart Updated",
//                   "$_quantity x ${widget.food.name} added to cart",
//                   snackPosition: SnackPosition.BOTTOM,
//                   backgroundColor: Colors.green.shade600,
//                   colorText: Colors.white,
//                   margin: const EdgeInsets.all(10),
//                   duration: const Duration(seconds: 2),
//                 );

//                 setState(() {
//                   _quantity = 1;
//                 });
//               },

//               child: Text(
//                 "Add to Cart - \$${(widget.food.price * _quantity).toStringAsFixed(2)}",
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../models/product_model.dart';
// import '../controllers/cart_controller.dart';
// import '../controllers/favorite_controller.dart';
// import '../controllers/product_controller.dart';
// import '../theme/custom_colors.dart';
// import './cart_screen.dart';

// class FoodDetailScreen extends StatefulWidget {
//   final FoodModel food;
//   const FoodDetailScreen({super.key, required this.food});

//   @override
//   State<FoodDetailScreen> createState() => _FoodDetailScreenState();
// }

// class _FoodDetailScreenState extends State<FoodDetailScreen>
//     with SingleTickerProviderStateMixin {
//   final CartController cartController = Get.put(CartController());
//   final ProductController productController = Get.find<ProductController>();
//   final FavoriteController favoriteController = Get.find<FavoriteController>();

//   late TabController _tabController;
//   int _quantity = 1;
//   int _currentPage = 0;
//   late List<FoodModel> foodVariants;
//   final PageController _pageController = PageController();
//   final int maxSliderCount = 3;

//   final Map<String, Map<String, String>> foodIngredients = {
//     '1': {
//       'Bun': '2 pcs',
//       'Patty': '1 pc',
//       'Cheese': '1 slice',
//       'Lettuce': '20 gm',
//     },
//     '2': {
//       'Dough': '200 gm',
//       'Cheese': '100 gm',
//       'Tomato': '50 gm',
//       'Pepperoni': '50 gm',
//     },
//     '3': {'Chicken': '12 pcs', 'Flour': '50 gm', 'Spices': '10 gm'},
//     '4': {
//       'Rice': '100 gm',
//       'Salmon': '50 gm',
//       'Seaweed': '20 gm',
//       'Avocado': '30 gm',
//     },
//   };

//   @override
//   void initState() {
//     super.initState();

//     _tabController = TabController(length: 3, vsync: this);

//     foodVariants = productController.productList
//         .where((f) => f.category == widget.food.category)
//         .take(maxSliderCount)
//         .toList();

//     if (!foodVariants.any((f) => f.id == widget.food.id)) {
//       foodVariants.insert(0, widget.food);
//     }

//     int initialPage = foodVariants.indexWhere((f) => f.id == widget.food.id);
//     if (initialPage != -1 && initialPage != 0) {
//       final currentFood = foodVariants.removeAt(initialPage);
//       foodVariants.insert(0, currentFood);
//     }

//     _pageController.addListener(() {
//       if (_pageController.page != null) {
//         int next = _pageController.page!.round();
//         if (_currentPage != next) {
//           setState(() {
//             _currentPage = next;
//           });
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     _tabController.dispose();
//     super.dispose();
//   }

//   void _onThumbnailTap(int index) {
//     _pageController.animateToPage(
//       index,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }

//   List<Widget> _buildIngredientList(
//     Map<String, String> ingredients,
//     CustomColors? colors,
//   ) {
//     if (ingredients.isEmpty) {
//       return [const Center(child: Text('No ingredients specified'))];
//     }
//     return ingredients.entries.map((entry) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 4.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               entry.key,
//               style: TextStyle(color: colors?.darkTextColor, fontSize: 16),
//             ),
//             Text(
//               entry.value,
//               style: TextStyle(
//                 color: Theme.of(context).disabledColor,
//                 fontSize: 16,
//               ),
//             ),
//           ],
//         ),
//       );
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colors =
//         Theme.of(context).extension<CustomColors>() ??
//             const CustomColors(
//               accentColor: Colors.amber,
//               darkTextColor: Colors.black,
//             );

//     final currentIngredients = foodIngredients[widget.food.id] ?? {};

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: Stack(
//         children: [
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             height: 300,
//             child: Container(color: colors.accentColor),
//           ),
//           ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               // --- IMAGE SLIDER WITH THUMBNAILS ---
//               SizedBox(
//                 height: 350,
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: 80,
//                       padding: const EdgeInsets.only(top: 80, left: 10),
//                       child: Column(
//                         children: List.generate(foodVariants.length, (index) {
//                           return Padding(
//                             padding: const EdgeInsets.only(bottom: 10),
//                             child: InkWell(
//                               onTap: () => _onThumbnailTap(index),
//                               child: Container(
//                                 width: 60,
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   border: Border.all(
//                                     color: index == _currentPage
//                                         ? colors.accentColor
//                                         : Theme.of(context).dividerColor,
//                                     width: index == _currentPage ? 3 : 1,
//                                   ),
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(8),
//                                   child: Image.network(
//                                     foodVariants[index].image,
//                                     fit: BoxFit.cover,
//                                     errorBuilder: (c, e, s) =>
//                                         const Icon(Icons.fastfood, size: 40),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         }),
//                       ),
//                     ),
//                     Expanded(
//                       child: Container(
//                         padding: const EdgeInsets.only(top: 50),
//                         child: PageView.builder(
//                           controller: _pageController,
//                           itemCount: foodVariants.length,
//                           itemBuilder: (context, index) {
//                             return Center(
//                               child: Image.network(
//                                 foodVariants[index].image,
//                                 width: 250,
//                                 height: 250,
//                                 fit: BoxFit.cover,
//                                 errorBuilder: (c, e, s) =>
//                                     const Icon(Icons.fastfood, size: 200),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // --- DETAILS, INGREDIENTS, REVIEWS ---
//               Container(
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).cardColor,
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30),
//                   ),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Color.fromARGB(37, 0, 0, 0),
//                       blurRadius: 10,
//                       offset: Offset(0, -2),
//                     ),
//                   ],
//                 ),
//                 padding: const EdgeInsets.all(24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // --- NAME + FAVORITE BUTTON ---
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: Text(
//                             widget.food.name,
//                             style: TextStyle(
//                               fontSize: 28,
//                               fontWeight: FontWeight.bold,
//                               color: colors.darkTextColor,
//                             ),
//                           ),
//                         ),
//                         Obx(() {
//                           bool isFav = favoriteController.favoriteItems.any(
//                             (f) => f.id == widget.food.id,
//                           );

//                           return IconButton(
//                             icon: Icon(
//                               isFav ? Icons.favorite : Icons.favorite_border,
//                               color: Colors.amber,
//                             ),
//                             onPressed: () =>
//                                 favoriteController.toggleFavorite(widget.food),
//                           );
//                         }),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         const Icon(Icons.location_on, color: Colors.amber, size: 16),
//                         const SizedBox(width: 4),
//                         Text(
//                           widget.food.category,
//                           style: TextStyle(
//                             color: Theme.of(context).textTheme.bodySmall?.color,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),

//                     // --- TAB BAR ---
//                     TabBar(
//                       controller: _tabController,
//                       labelColor: colors.darkTextColor,
//                       unselectedLabelColor: Theme.of(context).disabledColor,
//                       indicatorColor: colors.accentColor,
//                       tabs: const [
//                         Tab(text: "Details"),
//                         Tab(text: "Ingredients"),
//                         Tab(text: "Reviews"),
//                       ],
//                     ),
//                     const SizedBox(height: 12),

//                     // --- TAB BAR VIEW ---
//                     SizedBox(
//                       height: 250,
//                       child: TabBarView(
//                         controller: _tabController,
//                         children: [
//                           // --- DETAILS TAB ---
//                           SingleChildScrollView(
//                             padding: const EdgeInsets.all(8),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   widget.food.name,
//                                   style: TextStyle(
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.bold,
//                                     color: colors.darkTextColor,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 6),
//                                 Row(
//                                   children: [
//                                     const Icon(Icons.category,
//                                         size: 16, color: Colors.amber),
//                                     const SizedBox(width: 6),
//                                     Text(
//                                       widget.food.category,
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         color: Theme.of(context)
//                                             .textTheme
//                                             .bodySmall
//                                             ?.color,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 12),
//                                 Text(
//                                   "Price: \៛${widget.food.price.toStringAsFixed(2)}",
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: colors.accentColor,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 12),
//                                 Text(
//                                   widget.food.description,
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     color: Theme.of(context)
//                                         .textTheme
//                                         .bodyMedium
//                                         ?.color,
//                                     height: 1.4,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           // --- INGREDIENTS TAB ---
//                           SingleChildScrollView(
//                             padding: const EdgeInsets.all(8),
//                             child: Column(
//                               children: _buildIngredientList(currentIngredients, colors),
//                             ),
//                           ),

//                           // --- REVIEWS TAB ---
//                           Center(
//                             child: Text(
//                               "⭐ Reviews will be here",
//                               style: TextStyle(
//                                 color: Theme.of(context).disabledColor,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),

//           // --- TOP BAR (BACK + CART) ---
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.arrow_back_ios),
//                       onPressed: () => Get.back(),
//                     ),
//                     Stack(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.shopping_cart, color: Colors.black87),
//                           onPressed: () => Get.to(() => const CartScreen()),
//                         ),
//                         Positioned(
//                           right: 4,
//                           top: 4,
//                           child: Obx(() {
//                             int totalCount = cartController.quantities.fold(0, (a, b) => a + b);
//                             if (totalCount == 0) return const SizedBox.shrink();
//                             return Container(
//                               padding: const EdgeInsets.all(4),
//                               decoration: BoxDecoration(
//                                 color: Colors.redAccent,
//                                 shape: BoxShape.circle,
//                                 border: Border.all(color: Colors.white, width: 1.5),
//                               ),
//                               constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
//                               child: Center(
//                                 child: Text(
//                                   '$totalCount',
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),

//       // --- BOTTOM BAR (QUANTITY + ADD TO CART) ---
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         decoration: BoxDecoration(
//           color: Theme.of(context).cardColor,
//           boxShadow: const [
//             BoxShadow(
//               color: Color.fromARGB(37, 0, 0, 0),
//               blurRadius: 5,
//               offset: Offset(0, -2),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.remove_circle, color: colors.accentColor),
//                   onPressed: () => setState(() {
//                     if (_quantity > 1) _quantity--;
//                   }),
//                 ),
//                 Text(
//                   '$_quantity',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: colors.darkTextColor,
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.add_circle, color: colors.accentColor),
//                   onPressed: () => setState(() => _quantity++),
//                 ),
//               ],
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: colors.accentColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//               ),
//               onPressed: () async {
//                 await cartController.addToCart(widget.food, _quantity);

//                 Get.snackbar(
//                   "🛒 Cart Updated",
//                   "$_quantity x ${widget.food.name} added to cart",
//                   snackPosition: SnackPosition.BOTTOM,
//                   backgroundColor: Colors.green.shade600,
//                   colorText: Colors.white,
//                   margin: const EdgeInsets.all(10),
//                   duration: const Duration(seconds: 2),
//                 );

//                 setState(() {
//                   _quantity = 1;
//                 });
//               },
//               child: Text(
//                 "Add to Cart - \$${(widget.food.price * _quantity).toStringAsFixed(2)}",
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../models/product_model.dart';
import '../controllers/cart_controller.dart';
import '../controllers/favorite_controller.dart';
import '../controllers/product_controller.dart';
import '../theme/custom_colors.dart';
import './cart_screen.dart';

class FoodDetailScreen extends StatefulWidget {
  final FoodModel food;
  const FoodDetailScreen({super.key, required this.food});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen>
    with SingleTickerProviderStateMixin {
  final CartController cartController = Get.put(CartController());
  final ProductController productController = Get.find<ProductController>();
  final FavoriteController favoriteController = Get.find<FavoriteController>();

  late TabController _tabController;
  int _quantity = 1;
  int _currentPage = 0;
  late List<FoodModel> foodVariants;
  final PageController _pageController = PageController();
  final int maxSliderCount = 3;

  final Map<String, Map<String, String>> foodIngredients = {
    '1': {'Bun': '2 pcs', 'Patty': '1 pc', 'Cheese': '1 slice', 'Lettuce': '20 gm'},
    '2': {'Dough': '200 gm', 'Cheese': '100 gm', 'Tomato': '50 gm', 'Pepperoni': '50 gm'},
    '3': {'Chicken': '12 pcs', 'Flour': '50 gm', 'Spices': '10 gm'},
    '4': {'Rice': '100 gm', 'Salmon': '50 gm', 'Seaweed': '20 gm', 'Avocado': '30 gm'},
  };

  // --- Animation variables ---
  double _detailsOpacity = 0.0;
  double _detailsOffset = 50.0;
  bool _pricePulse = false;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);

    // Animate Details Tab on init
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _detailsOpacity = 1.0;
          _detailsOffset = 0.0;
          _pricePulse = true;
        });
      }
    });

    // Price pulse animation loop
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        _pricePulse = !_pricePulse;
      });
    });

    // --- Food Variants ---
    foodVariants = productController.productList
        .where((f) => f.category == widget.food.category)
        .take(maxSliderCount)
        .toList();

    if (!foodVariants.any((f) => f.id == widget.food.id)) {
      foodVariants.insert(0, widget.food);
    }

    int initialPage = foodVariants.indexWhere((f) => f.id == widget.food.id);
    if (initialPage != -1 && initialPage != 0) {
      final currentFood = foodVariants.removeAt(initialPage);
      foodVariants.insert(0, currentFood);
    }

    _pageController.addListener(() {
      if (_pageController.page != null) {
        int next = _pageController.page!.round();
        if (_currentPage != next) {
          setState(() {
            _currentPage = next;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onThumbnailTap(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  List<Widget> _buildIngredientList(Map<String, String> ingredients, CustomColors? colors) {
    if (ingredients.isEmpty) {
      return [const Center(child: Text('No ingredients specified'))];
    }
    return ingredients.entries.map((entry) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(entry.key, style: TextStyle(color: colors?.darkTextColor, fontSize: 16)),
            Text(entry.value, style: TextStyle(color: Theme.of(context).disabledColor, fontSize: 16)),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final colors = Theme.of(context).extension<CustomColors>() ??
        CustomColors(
          accentColor: isDarkMode ? Colors.orange : Colors.orange,
          darkTextColor: isDarkMode ? Colors.white : Colors.black87,
        );

    final bgColor = isDarkMode ? Colors.black87 : Colors.white;
    final cardColor = isDarkMode ? Colors.grey[900] : Colors.white;

    final currentIngredients = foodIngredients[widget.food.id] ?? {};

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          // --- Top gradient always orange
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 300,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orangeAccent, Colors.orange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),

          ListView(
            padding: EdgeInsets.zero,
            children: [
              // --- Image slider + thumbnails ---
              SizedBox(
                height: 350,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      padding: const EdgeInsets.only(top: 80, left: 10),
                      child: Column(
                        children: List.generate(foodVariants.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: InkWell(
                              onTap: () => _onThumbnailTap(index),
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: index == _currentPage
                                        ? Colors.orange
                                        : Theme.of(context).dividerColor,
                                    width: index == _currentPage ? 3 : 1,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    foodVariants[index].image,
                                    fit: BoxFit.cover,
                                    errorBuilder: (c, e, s) => const Icon(Icons.fastfood, size: 40),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top: 50),
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: foodVariants.length,
                          itemBuilder: (context, index) {
                            return Center(
                              child: Image.network(
                                foodVariants[index].image,
                                width: 250,
                                height: 250,
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => const Icon(Icons.fastfood, size: 200),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // --- Details Card ---
              Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, -2))],
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name + Favorite
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.food.name,
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.orange : Colors.black87),
                          ),
                        ),
                        Obx(() {
                          bool isFav = favoriteController.favoriteItems.any((f) => f.id == widget.food.id);
                          return IconButton(
                            icon: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: isDarkMode ? Colors.redAccent : Colors.redAccent,
                            ),
                            onPressed: () => favoriteController.toggleFavorite(widget.food),
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: isDarkMode ? Colors.orange : Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(widget.food.category, style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color, fontSize: 14)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TabBar(
                      controller: _tabController,
                      labelColor: isDarkMode ? Colors.orange : Colors.black87,
                      unselectedLabelColor: Theme.of(context).disabledColor,
                      indicatorColor: isDarkMode ? Colors.orange : Colors.orange,
                      tabs: const [Tab(text: "Details"), Tab(text: "Ingredients"), Tab(text: "Reviews")],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 250,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // Details
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 600),
                            opacity: _detailsOpacity,
                            child: AnimatedSlide(
                              offset: Offset(0, _detailsOffset / 100),
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeOut,
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(widget.food.name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black87)),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Icon(Icons.category, size: 16, color: isDarkMode ? Colors.orange : Colors.grey),
                                        const SizedBox(width: 6),
                                        Text(widget.food.category, style: TextStyle(fontSize: 14, color: Theme.of(context).textTheme.bodySmall?.color)),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    // Price pulse
                                    AnimatedDefaultTextStyle(
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange,
                                      ),
                                      duration: const Duration(milliseconds: 500),
                                      child: Text("Price: \៛${widget.food.price.toStringAsFixed(2)}"),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(widget.food.description, style: TextStyle(fontSize: 14, color: Theme.of(context).textTheme.bodyMedium?.color, height: 1.4)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Ingredients
                          SingleChildScrollView(
                            padding: const EdgeInsets.all(8),
                            child: Column(children: _buildIngredientList(currentIngredients, colors)),
                          ),
                          // Reviews
                          Center(child: Text("⭐ Reviews will be here", style: TextStyle(color: Theme.of(context).disabledColor))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // --- Top bar ---
          Positioned(
            top: 0, left: 0, right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: isDarkMode ? Colors.black87 : Colors.black87),
                      onPressed: () => Get.back(),
                    ),
                    Stack(
                      children: [
                        IconButton(
                          icon: Icon(Icons.shopping_cart, color: isDarkMode ? Colors.black87 : Colors.black87),
                          onPressed: () => Get.to(() => const CartScreen()),
                        ),
                        Positioned(
                          right: 4, top: 4,
                          child: Obx(() {
                            int totalCount = cartController.quantities.fold(0, (a, b) => a + b);
                            if (totalCount == 0) return const SizedBox.shrink();
                            return Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 1.5),
                              ),
                              constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                              child: Center(
                                child: Text(
                                  '$totalCount',
                                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // --- Bottom Navigation Bar ---
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: cardColor,
          boxShadow: const [BoxShadow(color: Color.fromARGB(37, 0, 0, 0), blurRadius: 5, offset: Offset(0, -2))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Quantity buttons
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove_circle, color: isDarkMode ? Colors.orange : colors.accentColor),
                  onPressed: () => setState(() { if (_quantity > 1) _quantity--; }),
                ),
                Text('$_quantity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : colors.darkTextColor)),
                IconButton(
                  icon: Icon(Icons.add_circle, color: isDarkMode ? Colors.orange : colors.accentColor),
                  onPressed: () => setState(() => _quantity++),
                ),
              ],
            ),
            // Add to Cart
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? Colors.orange : colors.accentColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              onPressed: () async {
                await cartController.addToCart(widget.food, _quantity);
                Get.snackbar(
                  "🛒 Cart Updated",
                  "$_quantity x ${widget.food.name} added to cart",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green.shade600,
                  colorText: Colors.white,
                  margin: const EdgeInsets.all(10),
                  duration: const Duration(seconds: 2),
                );
                setState(() { _quantity = 1; });
              },
              child: Text(
                "Add to Cart - \$${(widget.food.price * _quantity).toStringAsFixed(2)}",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
