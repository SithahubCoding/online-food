
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

  static double _parseNum(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }

  factory FoodModel.fromFirestore(String docId, Map<String, dynamic> data) {
    return FoodModel(
      id: docId,
      name: data['name']?.toString() ?? 'Unknown',
      price: _parseNum(data['price']),
      category: data['category']?.toString() ?? 'Unknown',
      subCategory: data['subCategory']?.toString() ?? 'Others',
      image: data['image']?.toString() ?? '',
      description: data['description']?.toString() ?? '',
      rating: _parseNum(data['rating']),
    );
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      id: map['id']?.toString() ?? '0',
      name: map['name']?.toString() ?? 'Unknown',
      price: _parseNum(map['price']),
      category: map['category']?.toString() ?? '',
      subCategory: map['subCategory']?.toString() ?? '',
      image: map['image']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      rating: _parseNum(map['rating']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'price': price,
      'category': category,
      'subCategory': subCategory,
      'image': image,
      'description': description,
      'rating': rating,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'subCategory': subCategory,
      'image': image,
      'description': description,
      'rating': rating,
    };
  }
}
