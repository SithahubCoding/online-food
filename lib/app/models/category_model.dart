// class CategoryModel {
//   final String name;
//   final String icon;
//   final List<SubCategory> subCategories;
//   CategoryModel({required this.name, required this.icon, required this.subCategories});
// }
// class SubCategory {
//   final String name;
//   final String icon;

//   SubCategory({required this.name, required this.icon});
// }

// final List<CategoryModel> categories = [
//   CategoryModel(
//     name: "Burger",
//     icon: "assets/images/burger.png",
//     subCategories: [
//       SubCategory(name: "Cheese Burger", icon: "assets/images/cheese_burger.png"),
//       SubCategory(name: "Veggie Burger", icon: "assets/images/veggie_burger.png"),
//       SubCategory(name: "Chicken Burger", icon: "assets/images/buger_checken.jpg"),
//     ],
//   ),
//   CategoryModel(
//     name: "Pizza",
//     icon: "assets/images/pizza.png",
//     subCategories: [
//       SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni_pizza.png"),
//       SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
//     ],
//   ),
//   CategoryModel(
//     name: "Sandwich",
//     icon: "assets/images/sandwich.png",
//     subCategories: [
//       SubCategory(name: "Club Sandwich", icon: "assets/images/club_sandwich.png"),
//       SubCategory(name: "Egg Sandwich", icon: "assets/images/egg_sandwich.png"),
//     ],
//   ),
//   CategoryModel(
//     name: "Donut",
//     icon: "assets/images/donut.png",
//     subCategories: [
//       SubCategory(name: "Chocolate Donut", icon: "assets/images/choco_donut.png"),
//       SubCategory(name: "Strawberry Donut", icon: "assets/images/strawberry_donut.png"),
//     ],
//   ),
//   CategoryModel(
//     name: "Chips",
//     icon: "assets/images/chips.png",
//     subCategories: [
//       SubCategory(name: "Potato Chips", icon: "assets/images/potato_chips.png"),
//       SubCategory(name: "Tortilla Chips", icon: "assets/images/tortilla_chips.png"),
//     ],
//   ),
//   CategoryModel(name: "Burger", icon: "assets/images/burger.png", subCategories: [
//       SubCategory(name: "Cheese Burger", icon: "assets/images/cheese_burger.png"),
//       SubCategory(name: "Veggie Burger", icon: "assets/images/veggie_burger.png"),
//       SubCategory(name: "Chicken Burger", icon: "assets/images/chicken_burger.png"),
//     ],
//   ),
//   CategoryModel(name: "Pizza", icon: "assets/images/pizza.png", subCategories: [
//       SubCategory(name: "Cheese Burger", icon: "assets/images/cheese_burger.png"),
//       SubCategory(name: "Veggie Burger", icon: "assets/images/veggie_burger.png"),
//       SubCategory(name: "Chicken Burger", icon: "assets/images/chicken_burger.png"),
//   ],),
//   CategoryModel(name: "Sandwich", icon: "assets/images/sandwich.png",  subCategories: [
//       SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
//       SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
//     ],),
//   CategoryModel(name: "Sandwich", icon: "assets/images/donut.png",  subCategories: [
//       SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
//       SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
//     ],),
//   CategoryModel(name: "Sandwich", icon: "assets/images/chips.png",  subCategories: [
//       SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
//       SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
//     ],),
//   CategoryModel(name: "Sandwich", icon: "assets/images/noodel.png",  subCategories: [
//       SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
//       SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
//     ],),
//   CategoryModel(name: "Sandwich", icon: "assets/images/nuggets.png",  subCategories: [
//       SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
//       SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
//     ],),
//   CategoryModel(name: "Drinks", icon: "assets/images/drink.png",  subCategories: [
//       SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
//       SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
//     ],),
//   CategoryModel(name: "Desserts", icon: "assets/images/dessert.png",  subCategories: [
//       SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
//       SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
//     ],),
//   CategoryModel(name: "Burger", icon: "assets/images/burger.png",  subCategories: [
//       SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
//       SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
//     ],),
//   CategoryModel(name: "Pizza", icon: "assets/images/pizza.png",  subCategories: [
//       SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
//       SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
//     ],),
//   CategoryModel(name: "Sandwich", icon: "assets/images/sandwich.png",  subCategories: [
//       SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
//       SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
//     ],),
//   CategoryModel(name: "Sandwich", icon: "assets/images/donut.png",  subCategories: [
//       SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
//       SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
//     ],),
//   CategoryModel(name: "Sandwich", icon: "assets/images/chips.png",  subCategories: [
//       SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
//       SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
//     ],),
//   CategoryModel(name: "Sandwich", icon: "assets/images/noodel.png",  subCategories: [
//       SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
//       SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
//     ],),
//   CategoryModel(name: "Sandwich", icon: "assets/images/nuggets.png",  subCategories: [
//       SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
//       SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
//     ],),
//   CategoryModel(name: "Drinks", icon: "assets/images/drink.png",  subCategories: [
//       SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
//       SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
//     ],),
//   CategoryModel(name: "Desserts", icon: "assets/images/dessert.png",  subCategories: [
//       SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
//       SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
//     ],),
// ];

// ឯកសារ: category_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

// ឯកសារ: category_model.dart

class CategoryModel {
  final String id;
  final String name;
  final String icon; 

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory CategoryModel.fromFirestore(String docId, Map<String, dynamic> data) {
    return CategoryModel(
      id: docId,
      name: data['name'] ?? 'Unknown',
      icon: data['icon'] ?? '',
    );
  }
}