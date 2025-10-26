// lib/models/cart_model.dart

class CartModel {
  int? id;           // Unique ID in SQLite table (Primary Key)
  String foodId;    // ID of the FoodModel (used to link back to the product details)
  String name;
  double price;
  String image;
  int quantity;

  CartModel({
    this.id,
    required this.foodId,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
  });

  // Convert CartModel Object to a Map (for SQLite insertion)
  Map<String, dynamic> toJson() {
    return {
      'foodId': foodId,
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }

  // Create CartModel Object from a Map (retrieved from SQLite)
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] as int?,
      foodId: json['foodId'] as String,
      name: json['name'] as String,
      price: json['price'] as double,
      image: json['image'] as String,
      quantity: json['quantity'] as int,
    );
  }
}