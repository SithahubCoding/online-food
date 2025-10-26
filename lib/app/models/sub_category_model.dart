// import 'package:cloud_firestore/cloud_firestore.dart';

// // ជំនួស Class SubCategory ចាស់
// class SubCategoryModel { 
//   final String id; // ID របស់ Sub Document (សម្រាប់ប្រើក្នុង Query ផលិតផល)
//   final String name;
//   final String icon;

//   SubCategoryModel({required this.id, required this.name, required this.icon});

//   // Factory សម្រាប់អាន DocumentSnapshot ពី Subcollection
//   factory SubCategoryModel.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>?;
    
//     if (data == null) {
//         throw Exception("SubCategory document data is null for ID: ${doc.id}");
//     }

//     return SubCategoryModel(
//       id: doc.id,
//       // អាន Fields name និង icon ដោយផ្ទាល់ពី Document នេះ
//       name: data['name'] ?? 'No Name', 
//       icon: data['icon'] ?? 'No Icon', 
//     );
//   }
// }

// ឯកសារ: sub_category_model.dart

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