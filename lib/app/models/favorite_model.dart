class FoodModel {
  String id;
  String name;
  String image;
  String description;
  String category;
  String subCategory;
  double price;
  double rating;

  FoodModel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.category,
    this.subCategory = '',
    required this.price,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
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

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      subCategory: map['subCategory'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      rating: (map['rating'] ?? 0).toDouble(),
    );
  }
  
  // ✅ Add equality check (important for GetX to detect updates)
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
