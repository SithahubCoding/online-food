import 'package:flutter/material.dart';
import '../models/food_model.dart';
import 'package:get/get.dart';
import './home_screen.dart';
import '../theme/custom_colors.dart'; 
import 'cart_screen.dart';
import './favorite_screen.dart';
class FoodDetailScreen extends StatefulWidget {
  final FoodModel food;
  const FoodDetailScreen({super.key, required this.food});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int _quantity = 1;

  late List<FoodModel> foodVariants;
  final int maxSliderCount = 3;

  final Map<int, Map<String, String>> foodIngredients = {
    1: {'Bun': '2 pcs', 'Patty': '1 pc', 'Cheese': '1 slice', 'Lettuce': '20 gm'},
    2: {'Dough': '200 gm', 'Cheese': '100 gm', 'Tomato': '50 gm', 'Pepperoni': '50 gm'},
    3: {'Chicken': '12 pcs', 'Flour': '50 gm', 'Spices': '10 gm'},
    4: {'Rice': '100 gm', 'Salmon': '50 gm', 'Seaweed': '20 gm', 'Avocado': '30 gm'},
  };

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    foodVariants = foods
        .where((f) => f.category == widget.food.category)
        .take(maxSliderCount)
        .toList();

    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
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

  @override
  Widget build(BuildContext context) {
    final currentIngredients = foodIngredients[widget.food.id] ?? {};
    final colors = Theme.of(context).extension<CustomColors>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 300,
            child: Container(color: colors?.accentColor ?? Colors.amber[100]),
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
                              activeColor: colors?.accentColor ?? Colors.amber,
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
                              backgroundColor: colors?.accentColor ?? Colors.amber[100]!,
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
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: const Offset(0, -2),
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
                        Text(
                          widget.food.name,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: colors?.darkTextColor ?? Colors.black,
                          ),
                        ),
                        // InkWell(
                        //   onTap: (){

                        //   },
                        //   Icon(Icons.favorite,
                        //     color: colors?.accentColor ?? Colors.amber),
                        // )
                        
                        Icon(Icons.favorite,
                            color: colors?.accentColor ?? Colors.amber),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.amber, size: 16),
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
                      labelColor: colors?.darkTextColor ?? Colors.black,
                      unselectedLabelColor: Theme.of(context).disabledColor,
                      indicatorColor: colors?.accentColor ?? Colors.amber,
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
                          Text(
                            widget.food.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                          ),

                          // Ingredients Tab
                          ListView(
                            children: _buildIngredientList(
                                currentIngredients, colors),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    BackButtonWidget(),
                    CartButtonWidget(),
                  ],
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
            BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, -2))
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Quantity Selector
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove_circle,
                      color: colors?.accentColor ?? Colors.amber),
                  onPressed: () {
                    setState(() {
                      if (_quantity > 1) _quantity--;
                    });
                  },
                ),
                Text("$_quantity",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colors?.darkTextColor ?? Colors.black)),
                IconButton(
                  icon: Icon(Icons.add_circle,
                      color: colors?.accentColor ?? Colors.amber),
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
                backgroundColor: colors?.accentColor ?? Colors.deepOrange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              onPressed: () {
                Get.snackbar("Cart", "${widget.food.name} added ($_quantity)");
                Get.to(() => CartSCreen());
              },
              child: Text(
                "Add to Cart - \$${(widget.food.price * _quantity).toStringAsFixed(2)}",
                style: const TextStyle(
                    color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildIngredientList(
      Map<String, String> ingredients, CustomColors? colors) {
    return ingredients.entries.map((entry) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.red[400],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 100,
              child: Text(entry.key,
                  style: TextStyle(
                      color: colors?.darkTextColor ?? Colors.black,
                      fontWeight: FontWeight.w500)),
            ),
            Text(':', style: TextStyle(color: Theme.of(context).dividerColor)),
            const SizedBox(width: 8),
            Text(entry.value,
                style:
                    TextStyle(color: Theme.of(context).textTheme.bodySmall?.color)),
          ],
        ),
      );
    }).toList();
  }
}

// ---------------- Components ----------------

class ThumbnailItem extends StatelessWidget {
  final String image;
  final bool isActive;
  final VoidCallback onTap;
  final Color? activeColor;
  final Color? borderColor;

  const ThumbnailItem({
    Key? key,
    required this.image,
    this.isActive = false,
    required this.onTap,
    this.activeColor,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          border: Border.all(
            color: isActive ? activeColor ?? Colors.orange : borderColor ?? Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(image, height: 60, width: 60, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class FoodImagePlaceholder extends StatelessWidget {
  final FoodModel item;
  final Color backgroundColor;

  const FoodImagePlaceholder({
    Key? key,
    required this.item,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: backgroundColor,
      alignment: Alignment.center,
      child: Image.asset(
        item.image,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) =>
            const Icon(Icons.image, size: 50, color: Colors.grey),
      ),
    );
  }
}

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      color: Theme.of(context).iconTheme.color,
      onPressed: () => Navigator.pop(context),
    );
  }
}

class CartButtonWidget extends StatelessWidget {
  const CartButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.shopping_cart),
      color: Theme.of(context).iconTheme.color,
      onPressed: () {
        Get.to(()=>CartSCreen());
      },
    );
  }
}
