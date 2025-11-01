
import 'package:cloud_firestore/cloud_firestore.dart';

class SubCategoryModel {
  final String id;
  final String name;
  final String icon;

  SubCategoryModel({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory SubCategoryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return SubCategoryModel(
      id: doc.id,
      name: data['name'] ?? 'Unknown',
      icon: data['icon'] ?? '',
    );
  }
}