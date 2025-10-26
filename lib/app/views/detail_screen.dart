
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';
import '../theme/custom_colors.dart';
import '../controllers/cart_controllrt.dart';
import '../controllers/favorite_controller.dart';
import './cart_screen.dart';
import '../controllers/product_controller.dart';

// --- Widget ជំនួយដើមរបស់អ្នកត្រូវបានរក្សាទុក ---

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () => Get.back(),
    );
  }
}

class CartButtonWidget extends StatelessWidget {
  const CartButtonWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.shopping_cart),
      onPressed: () => Get.to(() => const CartScreen()),
    );
  }
}

class FoodImagePlaceholder extends StatelessWidget {
  final FoodModel item;
  final Color backgroundColor;

  const FoodImagePlaceholder({
    super.key,
    required this.item,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network(
        item.image,
        width: 250,
        height: 250,
        fit: BoxFit.cover,
        errorBuilder: (c, e, s) => const Icon(Icons.fastfood, size: 200),
      ),
    );
  }
}

class ThumbnailItem extends StatelessWidget {
  final String image;
  final bool isActive;
  final VoidCallback onTap;
  final Color activeColor;
  final Color borderColor;

  const ThumbnailItem({
    super.key,
    required this.image,
    required this.isActive,
    required this.onTap,
    required this.activeColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isActive ? activeColor : borderColor,
            width: isActive ? 3 : 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            image,
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) => const Icon(Icons.fastfood, size: 40),
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------
// Main Screen Class: FoodDetailScreen
// -----------------------------------------------------------------

class FoodDetailScreen extends StatefulWidget {
  final FoodModel food;
  const FoodDetailScreen({super.key, required this.food});
  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  
  // Find controllers that should have been initialized in HomeMainScreen
  final ProductController productController = Get.find<ProductController>();
  final FavoriteController favoriteController = Get.find<FavoriteController>();
  
  // CartController might need to be put if used only here
  final CartController cartController = Get.put(CartController()); 

  int _currentPage = 0;
  int _quantity = 1;

  late List<FoodModel> foodVariants;
  final int maxSliderCount = 3;

  late TabController _tabController;

  final Map<String, Map<String, String>> foodIngredients = {
    // ⚠️ ត្រូវប្រើ String ID ដូច FoodModel.id
    // ខ្ញុំប្តូរពី int ទៅ String ដើម្បីឱ្យស៊ីគ្នានឹង FoodModel ID
    '1': {
      'Bun': '2 pcs',
      'Patty': '1 pc',
      'Cheese': '1 slice',
      'Lettuce': '20 gm',
    },
    '2': {
      'Dough': '200 gm',
      'Cheese': '100 gm',
      'Tomato': '50 gm',
      'Pepperoni': '50 gm',
    },
    '3': {'Chicken': '12 pcs', 'Flour': '50 gm', 'Spices': '10 gm'},
    '4': {
      'Rice': '100 gm',
      'Salmon': '50 gm',
      'Seaweed': '20 gm',
      'Avocado': '30 gm',
    },
  };

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);

    // Filter by category and take a maximum number for the slider
    foodVariants = productController.productList.toList() 
      .where((f) => f.category == widget.food.category)
      .take(maxSliderCount)
      .toList();
      
    // Handle the case where the current food isn't in the variants list (e.g., if maxSliderCount is too small)
    if (!foodVariants.any((f) => f.id == widget.food.id)) {
        foodVariants.insert(0, widget.food);
    }
    
    // Ensure the current food is the first item to show initially
    int initialPage = foodVariants.indexWhere((f) => f.id == widget.food.id);
    if (initialPage != -1) {
      // Move the current item to the start of the list temporarily for initial view
      if (initialPage != 0) {
        final currentFood = foodVariants.removeAt(initialPage);
        foodVariants.insert(0, currentFood);
        initialPage = 0;
      }
    } else {
        // Fallback or error state
        initialPage = 0;
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
  
  // Helper to build the ingredient list for the tab
  List<Widget> _buildIngredientList(
      Map<String, String> ingredients, CustomColors? colors) {
    if (ingredients.isEmpty) {
      return [const Center(child: Text('No ingredients specified for this item.'))];
    }
    return ingredients.entries.map((entry) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(entry.key,
                style: TextStyle(color: colors?.darkTextColor, fontSize: 16)),
            Text(entry.value,
                style: TextStyle(color: Theme.of(context).disabledColor, fontSize: 16)),
          ],
        ),
      );
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    // ⚠️ ត្រូវប្រាកដថា CustomColors extension របស់អ្នកត្រូវបានកំណត់ឱ្យបានត្រឹមត្រូវ
    final colors = Theme.of(context).extension<CustomColors>() ??
        const CustomColors(accentColor: Colors.amber, darkTextColor: Colors.black);
        
    // ត្រូវប្រើ food.id (String) សម្រាប់ key
    final currentIngredients = foodIngredients[widget.food.id] ?? {};

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 300,
            child: Container(color: colors.accentColor),
          ),
          ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 350,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Thumbnails
                    Container(
                      width: 80,
                      padding: const EdgeInsets.only(top: 80, left: 10),
                      child: Column(
                        children: List.generate(
                          foodVariants.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ThumbnailItem(
                              image: foodVariants[index].image,
                              isActive: index == _currentPage,
                              onTap: () => _onThumbnailTap(index),
                              activeColor: colors.accentColor ?? Colors.amber,
                              borderColor: Theme.of(context).dividerColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Main Image Slider
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top: 50),
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: foodVariants.length,
                          itemBuilder: (context, index) {
                            return FoodImagePlaceholder(
                              item: foodVariants[index],
                              backgroundColor: colors.accentColor ?? Colors.amber,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Details Card
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title + Favorite
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.food.name,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: colors.darkTextColor ?? Colors.black,
                            ),
                          ),
                        ),
                        Obx(() {
                          final isFav = favoriteController.favoriteItems.any(
                            (f) => f.id == widget.food.id,
                          ); 
                          return IconButton(
                            icon: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: Colors.amber,
                            ),
                            onPressed: () {
                              favoriteController.toggleFavorite(
                                widget.food,
                              ); 
                            },
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.food.category,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // TabBar
                    TabBar(
                      controller: _tabController,
                      labelColor: colors.darkTextColor ?? Colors.black,
                      unselectedLabelColor: Theme.of(context).disabledColor,
                      indicatorColor: colors.accentColor ?? Colors.amber,
                      tabs: const [
                        Tab(text: "Details"),
                        Tab(text: "Ingredients"),
                        Tab(text: "Reviews"),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 200,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // Details Tab
                          SingleChildScrollView(
                            child: Text(
                              widget.food.description,
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).textTheme.bodyMedium?.color,
                              ),
                            ),
                          ),
                          // Ingredients Tab
                          ListView(
                            children: _buildIngredientList(
                              currentIngredients,
                              colors,
                            ),
                          ),
                          // Reviews Tab
                          Center(
                            child: Text(
                              "⭐ Reviews will be here",
                              style: TextStyle(
                                color: Theme.of(context).disabledColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Top Buttons
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [BackButtonWidget(), CartButtonWidget()],
                ),
              ),
            ),
          ),
        ],
      ),

      // Bottom Action Bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Quantity Selector
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.remove_circle,
                    color: colors.accentColor ?? Colors.amber,
                  ),
                  onPressed: () {
                    setState(() {
                      if (_quantity > 1) _quantity--;
                    });
                  },
                ),
                Text(
                  "$_quantity",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colors.darkTextColor ?? Colors.black,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add_circle,
                    color: colors.accentColor ?? Colors.amber,
                  ),
                  onPressed: () {
                    setState(() {
                      _quantity++;
                    });
                  },
                ),
              ],
            ),
            // Add to Cart Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.accentColor ?? Colors.deepOrange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
              onPressed: () async {
                // 🚀 កែតម្រូវ: ប្រើ await ដើម្បីរង់ចាំ Cart Logic បញ្ចប់
                await cartController.addToCart(widget.food, _quantity);

                // ✅ កែតម្រូវ: បង្ហាញ Get.snackbar បន្ទាប់ពី save ជោគជ័យ
                Get.snackbar(
                  "🛒 Cart Updated",
                  "${_quantity} x ${widget.food.name} has been added to your cart successfully.",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green.shade600,
                  colorText: Colors.white,
                  margin: const EdgeInsets.all(10),
                  duration: const Duration(seconds: 2),
                );
                
                // ស្រេចចិត្ត៖ កំណត់ចំនួនទៅ 1 វិញ
                setState(() {
                  _quantity = 1;
                });
              },
              child: Text(
                "Add to Cart - \$${(widget.food.price * _quantity).toStringAsFixed(2)}",
                style: const TextStyle(color: Colors.white), // ត្រូវប្តូរ color ទៅ White ប្រសិនបើ Button ពណ៌ដិត
              ),
            ),
          ],
        ),
      ),
    );
  }
}