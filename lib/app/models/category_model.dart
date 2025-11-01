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
      name: data['name']?.toString() ?? 'Unknown',
      icon: data['icon']?.toString() ?? '',
    );
  }
}
