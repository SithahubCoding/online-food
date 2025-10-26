// class FoodModel {
//   final int id;
//   final String name;
//   final String image;
//   final String description;
//   final String category;
//   final double price;
//   final double rating;

//   // Main constructor (manual creation)
//   FoodModel({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.category,
//     required this.image,
//     required this.rating,
//   });
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'image': image,
//       'description': description,
//       'category': category,
//       'price': price,
//       'rating': rating,
//     };
//   }

//   factory FoodModel.fromMap(Map<String, dynamic> map) {
//     return FoodModel(
//       id: map['id'],
//       name: map['name'],
//       image: map['image'],
//       description: map['description'],
//       category: map['category'],
//       price: map['price'],
//       rating: map['rating'],
//     );
//   }
//   // Factory constructor (dummy data, auto fills some fields)
// }

// class FoodModel {
//   final String id; // 🔹 change from int → String
//   final String name;
//   final String image;
//   final String description;
//   final String category;
//   final double price;
//   final double rating;

//   // 🔹 Constructor
//   FoodModel({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.category,
//     required this.image,
//     required this.rating,
//   });

//   // 🔹 Convert model to Map (for SQLite)
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'image': image,
//       'description': description,
//       'category': category,
//       'price': price,
//       'rating': rating,
//     };
//   }

//   // 🔹 Create model from SQLite Map
//   factory FoodModel.fromMap(Map<String, dynamic> map) {
//     return FoodModel(
//       id: map['id'].toString(),
//       name: map['name'] ?? '',
//       image: map['image'] ?? '',
//       description: map['description'] ?? '',
//       category: map['category'] ?? '',
//       price: (map['price'] is num) ? map['price'].toDouble() : 0.0,
//       rating: (map['rating'] is num) ? map['rating'].toDouble() : 0.0,
//     );
//   }

//   // 🔹 Convert to Firestore Map (for uploading)
//   Map<String, dynamic> toFirestore() {
//     return {
//       'name': name,
//       'image': image,
//       'description': description,
//       'category': category,
//       'price': price,
//       'rating': rating,
//     };
//   }

//   // 🔹 Create model from Firestore (DocumentSnapshot)
//   factory FoodModel.fromFirestore(String docId, Map<String, dynamic> data) {
//     return FoodModel(
//       id: docId,
//       name: data['name'] ?? '',
//       image: data['image'] ?? '',
//       description: data['description'] ?? '',
//       category: data['category'] ?? '',
//       price: (data['price'] is num) ? data['price'].toDouble() : 0.0,
//       rating: (data['rating'] is num) ? data['rating'].toDouble() : 0.0,
//     );
//   }
// }

// // Example food list
// List<FoodModel> foods = [
//   FoodModel(
//     id: '1',
//     name: "Burger",
//     description: "Juicy burger with cheese",
//     price: 3.5,
//     category: "Fast Food",
//     image: "assets/images/burger.png",
//     rating: 4.5,
//   ),
//   FoodModel(
//     id: '2',
//     name: "Pizza",
//     description: "Cheesy pizza with toppings",
//     price: 5.0,
//     category: "Italian",
//     image: "assets/images/pizza.png",
//     rating: 4.7,
//   ),
//   FoodModel(
//     id: '3',
//     name: "Fried Chicken",
//     description: "Crispy fried chicken",
//     price: 4.0,
//     category: "Fast Food",
//     image: "assets/images/burger.png",
//     rating: 4.3,
//   ),
//   FoodModel(
//     id: '4',
//     name: "Sushi",
//     description: "Fresh sushi rolls",
//     price: 6.0,
//     category: "Japanese",
//     image: "assets/images/burger.png",
//     rating: 4.8,
//   ),
//   FoodModel(
//     id: '5',
//     name: "Sushi",
//     description: "Fresh sushi rolls",
//     price: 6.0,
//     category: "Japanese",
//     image: "assets/images/burger.png",
//     rating: 4.8,
//   ),
//   FoodModel(
//     id: '6',
//     name: "Sushi",
//     description: "Fresh sushi rolls",
//     price: 6.0,
//     category: "Japanese",
//     image: "assets/images/burger.png",
//     rating: 4.8,
//   ),
//   FoodModel(
//     id: '7',
//     name: "Sushi",
//     description: "Fresh sushi rolls",
//     price: 6.0,
//     category: "Japanese",
//     image: "assets/images/burger.png",
//     rating: 4.8,
//   ),
//   FoodModel(
//     id: '8',
//     name: "Sushi",
//     description: "Fresh sushi rolls",
//     price: 6.0,
//     category: "Japanese",
//     image: "assets/images/burger.png",
//     rating: 4.8,
//   ),
// ];

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

// class FoodModel {
//   final String id;
//   final String name;
//   final double price;
//   final String category;
//   final String subCategory;
//   final String image;
//   final String description;
//   final double rating; // optional, keep if you track ratings

//   FoodModel({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.category,
//     required this.subCategory,
//     required this.image,
//     required this.description,
//     this.rating = 0.0,
//   });

//   // 🔹 Convert model to Map for SQLite
//   Map<String, dynamic> toMap() {
//     return {
//       'id': int.tryParse(id) ?? 0, // Convert String ID to int for SQLite PK
//       'name': name,
//       'image': image,
//       'description': description,
//       'category': category,
//       'subCategory': subCategory,
//       'price': price,
//       'rating': rating,
//     };
//   }

//   // 🔹 Create model from SQLite Map
//   factory FoodModel.fromMap(Map<String, dynamic> map) {
//     return FoodModel(
//       id: map['id'].toString(), // Convert back to String
//       name: map['name'] ?? '',
//       image: map['image'] ?? '',
//       description: map['description'] ?? '',
//       category: map['category'] ?? '',
//       subCategory: map['subCategory'] ?? '',
//       price: (map['price'] is num) ? map['price'].toDouble() : 0.0,
//       rating: (map['rating'] is num) ? map['rating'].toDouble() : 0.0,
//     );
//   }

//   // 🔹 Create model from Firestore data
//   factory FoodModel.fromFirestore(String docId, Map<String, dynamic> data) {
//     return FoodModel(
//       id: docId,
//       name: data['name'] ?? '',
//       image: data['image'] ?? '',
//       description: data['description'] ?? '',
//       category: data['category'] ?? '',
//       subCategory: data['subCategory'] ?? '',
//       price: (data['price'] as num?)?.toDouble() ?? 0.0,
//       rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
//     );
//   }

//   // 🔹 Convert model to Map for Firestore
//   Map<String, dynamic> toFirestore() {
//     return {
//       'name': name,
//       'image': image,
//       'description': description,
//       'category': category,
//       'subCategory': subCategory,
//       'price': price,
//       'rating': rating,
//     };
//   }
// }

// class FoodModel {
//   final String id;
//   final String name;
//   final double price;
//   final String category;
//   final String subCategory;
//   final String image;
//   final String description;
//   final double rating;

//   FoodModel({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.category,
//     required this.subCategory,
//     required this.image,
//     required this.description,
//     this.rating = 0.0,
//   });

//   // Convert model to Map for SQLite (ID kept as TEXT)
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id, // ✅ Keep as TEXT
//       'name': name,
//       'image': image,
//       'description': description,
//       'category': category,
//       'subCategory': subCategory,
//       'price': price,
//       'rating': rating,
//     };
//   }

//   // Create model from SQLite Map
//   factory FoodModel.fromMap(Map<String, dynamic> map) {
//     return FoodModel(
//       id: map['id'].toString(),
//       name: map['name'] ?? '',
//       image: map['image'] ?? '',
//       description: map['description'] ?? '',
//       category: map['category'] ?? '',
//       subCategory: map['subCategory'] ?? '',
//       price: (map['price'] is num) ? map['price'].toDouble() : 0.0,
//       rating: (map['rating'] is num) ? map['rating'].toDouble() : 0.0,
//     );
//   }

//   // Create model from Firestore data
//   factory FoodModel.fromFirestore(String docId, Map<String, dynamic> data) {
//     return FoodModel(
//       id: docId,
//       name: data['name'] ?? '',
//       image: data['image'] ?? '',
//       description: data['description'] ?? '',
//       category: data['category'] ?? '',
//       subCategory: data['subCategory'] ?? '',
//       price: (data['price'] as num?)?.toDouble() ?? 0.0,
//       rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
//     );
//   }

//   // Convert model to Map for Firestore
//   Map<String, dynamic> toFirestore() {
//     return {
//       'name': name,
//       'image': image,
//       'description': description,
//       'category': category,
//       'subCategory': subCategory,
//       'price': price,
//       'rating': rating,
//     };
//   }
// }


// ឯកសារ: product_model.dart
// class FoodModel {
//   final String id;
//   final String name;
//   final double price;
//   final String category;
//   final String subCategory;
//   final String image;
//   final String description;
//   final double rating; // optional, keep if you track ratings

//   FoodModel({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.category,
//     required this.subCategory,
//     required this.image,
//     required this.description,
//     this.rating = 0.0,
//   });

//   // 🔹 Convert model to Map for SQLite
//   Map<String, dynamic> toMap() {
//     return {
//       // ✅ កែតម្រូវ: ប្រើ id ផ្ទាល់ដែលជា String (Firestore ID)
//       'id': id, 
//       'name': name,
//       'image': image,
//       'description': description,
//       'category': category,
//       // 'subCategory': subCategory, // ❌ លុបវាចោលព្រោះ DB មិនមាន Column នេះទេ
//       'price': price,
//       'rating': rating,
//     };
//   }

//   // 🔹 Create model from SQLite Map
//   factory FoodModel.fromMap(Map<String, dynamic> map) {
//     return FoodModel(
//       id: map['id'].toString(), // ត្រឹមត្រូវ
//       name: map['name'] ?? '',
//       image: map['image'] ?? '',
//       description: map['description'] ?? '',
//       category: map['category'] ?? '',
//       // ⚠️ អាចមានបញ្ហាព្រោះ DB មិនមាន subCategory, តែ FoodModel តម្រូវ
//       // ដូច្នេះយើងប្រើតម្លៃលំនាំដើមដើម្បីការពារកំហុស
//       subCategory: map['subCategory'] ?? '', 
//       price: (map['price'] is num) ? map['price'].toDouble() : 0.0,
//       rating: (map['rating'] is num) ? map['rating'].toDouble() : 0.0,
//     );
//   }

//   // 🔹 Create model from Firestore data
//   factory FoodModel.fromFirestore(String docId, Map<String, dynamic> data) {
//     return FoodModel(
//       id: docId,
//       name: data['name'] ?? '',
//       image: data['image'] ?? '',
//       description: data['description'] ?? '',
//       category: data['category'] ?? '',
//       subCategory: data['subCategory'] ?? '',
//       price: (data['price'] as num?)?.toDouble() ?? 0.0,
//       rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
//     );
//   }

//   // 🔹 Convert model to Map for Firestore
//   Map<String, dynamic> toFirestore() {
//     return {
//       'name': name,
//       'image': image,
//       'description': description,
//       'category': category,
//       'subCategory': subCategory,
//       'price': price,
//       'rating': rating,
//     };
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';

// class FoodModel {
//   final String id;
//   final String name;
//   final double price;
//   final String category;
//   final String subCategory;
//   final String image;
//   final String description;
//   final double rating;

//   FoodModel({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.category,
//     required this.subCategory,
//     required this.image,
//     required this.description,
//     this.rating = 0.0,
//   });

//   // 🔹 Create model from Firestore data (សម្រាប់អានពី product_db)
//   factory FoodModel.fromFirestore(String docId, Map<String, dynamic> data) {
//     // Helper function ដើម្បីបម្លែងតម្លៃទៅជា double ដោយសុវត្ថិភាព
//     double parseNum(dynamic value) {
//       if (value == null) return 0.0;
//       if (value is num) return value.toDouble();
//       return double.tryParse(value.toString()) ?? 0.0;
//     }

//     return FoodModel(
//       id: docId,
//       name: data['name'] ?? '',
//       image: data['image'] ?? '',
//       description: data['description'] ?? '',
//       category: data['category'] ?? '',
//       subCategory: data['subCategory'] ?? '',
//       price: parseNum(data['price']), // ✅ កែតម្រូវ Type Casting
//       rating: parseNum(data['rating']),
//     );
//   }

//   // 🔹 Convert model to Map for Firestore (សម្រាប់ Update/Create)
//   Map<String, dynamic> toFirestore() {
//     return {
//       'name': name,
//       'image': image,
//       'description': description,
//       'category': category,
//       'subCategory': subCategory,
//       'price': price,
//       'rating': rating,
//     };
//   }

//   // 🔹 Convert model to Map for SQLite (Favorite)
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id, // ប្រើ Firestore ID ទុកជា String
//       'name': name,
//       'image': image,
//       'description': description,
//       'category': category,
//       'price': price,
//       'rating': rating,
//     };
//   }
  
//   // សម្រាប់ SQLite (Favorite)
//   factory FoodModel.fromMap(Map<String, dynamic> map) {
//     return FoodModel(
//       id: map['id'].toString(), 
//       name: map['name'] ?? '',
//       image: map['image'] ?? '',
//       description: map['description'] ?? '',
//       category: map['category'] ?? '',
//       subCategory: map['subCategory'] ?? '', 
//       price: (map['price'] is num) ? map['price'].toDouble() : 0.0,
//       rating: (map['rating'] is num) ? map['rating'].toDouble() : 0.0,
//     );
//   }
// }

//1
// lib/models/product_model.dart

// import 'package:cloud_firestore/cloud_firestore.dart';

// class FoodModel {
//   final String id;
//   final String name;
//   final double price;
//   final String category;
//   final String subCategory;
//   final String image;
//   final String description;
//   final double rating;

//   FoodModel({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.category,
//     required this.subCategory,
//     required this.image,
//     required this.description,
//     this.rating = 0.0,
//   });

//   // Helper function ដើម្បីបម្លែងតម្លៃទៅជា double ដោយសុវត្ថិភាព
//   static double _parseNum(dynamic value) {
//     if (value == null) return 0.0;
//     if (value is num) return value.toDouble();
//     return double.tryParse(value.toString()) ?? 0.0;
//   }

//   // 🔹 មុខងារ toMap() សម្រាប់ SQLite INSERT (Products Table)
//   Map<String, dynamic> toMap() {
//     return {
//       // ✅ កែតម្រូវ: បំប្លែង String ID ទៅជា int សម្រាប់ SQLite Primary Key (productId)
//       'id': int.tryParse(id), 
//       'name': name,
//       'image': image,
//       'description': description,
//       'category': category,
//       'subCategory': subCategory, 
//       'price': price,
//       'rating': rating,
//     };
//   }
  
//   // 🔹 មុខងារ fromMap() សម្រាប់ SQLite READ (Products/Cart JOIN)
//   factory FoodModel.fromMap(Map<String, dynamic> map) {
//     return FoodModel(
//       // ✅ កែតម្រូវ: បំប្លែង int ID របស់ SQLite មកជា String វិញ
//       id: map['id']?.toString() ?? '0', 
//       name: map['name'] ?? 'Unknown',
//       image: map['image'] ?? '',
//       description: map['description'] ?? '',
//       category: map['category'] ?? '',
//       subCategory: map['subCategory'] ?? '', 
//       price: _parseNum(map['price']),
//       rating: _parseNum(map['rating']),
//     );
//   }

//   // 🔹 មុខងារ fromFirestore (ដោះស្រាយ Error `fromFirestore` ក្នុង home_main_screen & subcategory_screen)
//   factory FoodModel.fromFirestore(String docId, Map<String, dynamic> data) {
//     return FoodModel(
//       id: docId, // ប្រើ docId ជា FoodModel ID (String)
//       name: data['name'] ?? '',
//       image: data['image'] ?? '',
//       description: data['description'] ?? '',
//       category: data['category'] ?? '',
//       subCategory: data['subCategory'] ?? '',
//       price: _parseNum(data['price']), 
//       rating: _parseNum(data['rating']),
//     );
//   }

//   // 🔹 Convert model to Map for Firestore
//   Map<String, dynamic> toFirestore() {
//     return {
//       'name': name,
//       'image': image,
//       'description': description,
//       'category': category,
//       'subCategory': subCategory,
//       'price': price,
//       'rating': rating,
//     };
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';

class FoodModel {
  final String id;
  final String name;
  final double price;
  final String category;
  final String subCategory;
  final String image;
  final String description;
  final double rating;

  FoodModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.subCategory,
    required this.image,
    required this.description,
    this.rating = 0.0,
  });

  // Helper function ដើម្បីបម្លែងតម្លៃទៅជា double ដោយសុវត្ថិភាព
  static double _parseNum(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }

  // 🔹 មុខងារ toMap() សម្រាប់ SQLite INSERT (Products Table)
  Map<String, dynamic> toMap() {
    return {
      // ✅ កែតម្រូវ: បំប្លែង String ID ទៅជា int សម្រាប់ SQLite Primary Key (productId)
      'id': id, 
      'name': name,
      'image': image,
      'description': description,
      'category': category,
      'subCategory': subCategory, 
      'price': price,
      'rating': rating,
    };
  }
  
  // 🔹 មុខងារ fromMap() សម្រាប់ SQLite READ (Products/Cart JOIN)
  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      // ✅ កែតម្រូវ: បំប្លែង int ID របស់ SQLite មកជា String វិញ
      id: map['id']?.toString() ?? '0', 
      name: map['name'] ?? 'Unknown',
      image: map['image'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      subCategory: map['subCategory'] ?? '', 
      price: _parseNum(map['price']),
      rating: _parseNum(map['rating']),
    );
  }

  // 🔹 មុខងារ fromFirestore (ដោះស្រាយ Error `fromFirestore` ក្នុង home_main_screen & subcategory_screen)
  factory FoodModel.fromFirestore(String docId, Map<String, dynamic> data) {
    return FoodModel(
      id: docId, // ប្រើ docId ជា FoodModel ID (String)
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      subCategory: data['subCategory'] ?? '',
      price: _parseNum(data['price']), 
      rating: _parseNum(data['rating']),
    );
  }

  // 🔹 Convert model to Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'image': image,
      'description': description,
      'category': category,
      'subCategory': subCategory,
      'price': price,
      'rating': rating,
    };
  }
}