
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AddDataScreen extends StatefulWidget {
//   const AddDataScreen({super.key});

//   @override
//   State<AddDataScreen> createState() => _AddDataScreenState();
// }

// class _AddDataScreenState extends State<AddDataScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController imageController = TextEditingController();
//   final TextEditingController categoryController = TextEditingController();
//   final TextEditingController subCategoryController = TextEditingController();

//   bool isLoading = false;

//   Future<void> addProduct() async {
//     final name = nameController.text.trim();
//     final priceText = priceController.text.trim();
//     final description = descriptionController.text.trim();
//     final image = imageController.text.trim();
//     final category = categoryController.text.trim();
//     final subCategory = subCategoryController.text.trim();
    
//     if (name.isEmpty || priceText.isEmpty || image.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('❗ សូមបញ្ចូលព័ត៌មានឲ្យពេញ')),
//       );
//       return;
//     }

//     final price = double.tryParse(priceText);
//     if (price == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('💲 តម្លៃត្រូវតែជាចំនួន')),
//       );
//       return;
//     }

//     setState(() => isLoading = true);

//     try {
//       await FirebaseFirestore.instance.collection('product_db').add({
//         'name': name,
//         'price': price,
//         'description': description,
//         'image': image,
//         'category': category,
//         'subCategory': subCategory,
//         'createdAt': FieldValue.serverTimestamp(),
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('✅ បញ្ចូលទិន្នន័យជោគជ័យ')),
//       );

//       nameController.clear();
//       priceController.clear();
//       descriptionController.clear();
//       imageController.clear();
//       categoryController.clear();
//       subCategoryController.clear();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('❌ បញ្ចូលទិន្នន័យបរាជ័យ: $e')),
//       );
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Add Product")),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(
//                 controller: nameController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Product Name',
//                 ),
//               ),
//               const SizedBox(height: 12),
//               TextField(
//                 controller: priceController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Price',
//                 ),
//                 keyboardType: TextInputType.number,
//               ),
//               const SizedBox(height: 12),
//               TextField(
//                 controller: descriptionController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Description',
//                 ),
//                 maxLines: 2,
//               ),
//               const SizedBox(height: 12),
//               TextField(
//                 controller: imageController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Image URL',
//                 ),
//               ),
//               const SizedBox(height: 12),
//               TextField(
//                 controller: categoryController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Category',
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: subCategoryController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'SubCategory',
//                 ),
//               ),
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: isLoading ? null : addProduct,
//                   child: isLoading
//                       ? const CircularProgressIndicator(color: Colors.white)
//                       : const Text("Add Product"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AddDataScreen extends StatefulWidget {
//   const AddDataScreen({super.key});

//   @override
//   State<AddDataScreen> createState() => _AddDataScreenState();
// }

// class _AddDataScreenState extends State<AddDataScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();

//   String? selectedCategory;
//   String? selectedSubCategory;
//   File? imageFile;
//   bool isLoading = false;

//   final List<String> categories = [
//     'Food',
//     'Drink',
//     'Clothes',
//     'Accessories',
//     'Electronics'
//   ];

//   final Map<String, List<String>> subCategories = {
//     'Food': ['Snacks', 'Fruits', 'Vegetables', 'Others'],
//     'Drink': ['Juice', 'Water', 'Soda', 'Coffee'],
//     'Clothes': ['Men', 'Women', 'Kids'],
//     'Accessories': ['Bags', 'Watches', 'Jewelry'],
//     'Electronics': ['Phone', 'Laptop', 'Headphones'],
//   };

//   Future<void> pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 80,
//     );

//     if (pickedFile != null) {
//       setState(() => imageFile = File(pickedFile.path));
//     }
//   }

//   Future<String> uploadImageToFirebase(File imageFile) async {
//     final fileName = DateTime.now().millisecondsSinceEpoch.toString();
//     final ref =
//         FirebaseStorage.instance.ref().child('product_images/$fileName.jpg');
//     await ref.putFile(imageFile);
//     return await ref.getDownloadURL();
//   }

//   Future<void> addProduct() async {
//     final name = nameController.text.trim();
//     final priceText = priceController.text.trim();
//     final description = descriptionController.text.trim();

//     if (name.isEmpty ||
//         priceText.isEmpty ||
//         imageFile == null ||
//         selectedCategory == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('❗ សូមបញ្ចូលព័ត៌មានឲ្យពេញ')),
//       );
//       return;
//     }

//     final price = double.tryParse(priceText);
//     if (price == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('💲 តម្លៃត្រូវតែជាចំនួន')),
//       );
//       return;
//     }

//     setState(() => isLoading = true);

//     try {
//       final imageUrl = await uploadImageToFirebase(imageFile!);

//       await FirebaseFirestore.instance.collection('product_db').add({
//         'name': name,
//         'price': price,
//         'description': description,
//         'image': imageUrl,
//         'category': selectedCategory,
//         'subCategory': selectedSubCategory ?? '',
//         'createdAt': FieldValue.serverTimestamp(),
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('✅ បញ្ចូលទិន្នន័យជោគជ័យ')),
//       );

//       nameController.clear();
//       priceController.clear();
//       descriptionController.clear();
//       setState(() {
//         selectedCategory = null;
//         selectedSubCategory = null;
//         imageFile = null;
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('❌ បញ្ចូលទិន្នន័យបរាជ័យ: $e')),
//       );
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     const primaryColor = Color(0xFF142338);
//     const accentColor = Color(0xFFFFA000);

//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: const Text(
//           "🛒 Add Product",
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         centerTitle: true,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFFFFA000), Color(0xFFFF6F00)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//         elevation: 3,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // 🖼️ Image Picker Card
//             GestureDetector(
//               onTap: pickImage,
//               child: Container(
//                 width: double.infinity,
//                 height: 180,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.05),
//                       blurRadius: 8,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: imageFile != null
//                     ? ClipRRect(
//                         borderRadius: BorderRadius.circular(16),
//                         child: Image.file(imageFile!, fit: BoxFit.cover),
//                       )
//                     : Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: const [
//                           Icon(Icons.cloud_upload_rounded,
//                               size: 50, color:Color(0xFF142338)),
//                           SizedBox(height: 10),
//                           Text("Tap to upload product image",
//                               style: TextStyle(
//                                   color: Colors.grey, fontSize: 15)),
//                         ],
//                       ),
//               ),
//             ),
//             const SizedBox(height: 24),

//             // 🧾 Fields
//             _buildTextField(
//                 controller: nameController,
//                 label: "Product Name",
//                 icon: Icons.shopping_bag_rounded),
//             const SizedBox(height: 16),

//             _buildTextField(
//               controller: priceController,
//               label: "Price",
//               icon: Icons.attach_money_rounded,
//               isNumber: true,
//             ),
//             const SizedBox(height: 16),

//             _buildTextField(
//               controller: descriptionController,
//               label: "Description",
//               icon: Icons.description_rounded,
//               maxLines: 3,
//             ),
//             const SizedBox(height: 16),

//             // 🧩 Category Dropdown
//             _buildDropdown(
//               label: "Category",
//               icon: Icons.category_rounded,
//               value: selectedCategory,
//               items: categories,
//               onChanged: (value) {
//                 setState(() {
//                   selectedCategory = value;
//                   selectedSubCategory = null;
//                 });
//               },
//             ),
//             const SizedBox(height: 16),

//             if (selectedCategory != null)
//               _buildDropdown(
//                 label: "Subcategory",
//                 icon: Icons.subdirectory_arrow_right_rounded,
//                 value: selectedSubCategory,
//                 items: subCategories[selectedCategory] ?? [],
//                 onChanged: (value) =>
//                     setState(() => selectedSubCategory = value),
//               ),
//             const SizedBox(height: 30),

//             // 🧡 Add Button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: isLoading ? null : addProduct,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFF142338),
//                   elevation: 3,
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14)),
//                 ),
//                 child: isLoading
//                     ? const CircularProgressIndicator(color: Colors.white)
//                     : const Text(
//                         "Add Product",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600),
//                       ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     bool isNumber = false,
//     int maxLines = 1,
//   }) {
//     return TextField(
//       controller: controller,
//       keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//       maxLines: maxLines,
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: const Color(0xFFFFA000)),
//         labelText: label,
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding:
//             const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: BorderSide.none,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: const BorderSide(color: Color(0xFFFFA000), width: 1.3),
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdown({
//     required String label,
//     required IconData icon,
//     required String? value,
//     required List<String> items,
//     required Function(String?) onChanged,
//   }) {
//     return DropdownButtonFormField<String>(
//       value: value,
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: const Color(0xFFFFA000)),
//         labelText: label,
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: BorderSide.none,
//         ),
//       ),
//       items: items
//           .map((item) => DropdownMenuItem(value: item, child: Text(item)))
//           .toList(),
//       onChanged: onChanged,
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? selectedCategory;
  String? selectedSubCategory;
  File? imageFile;
  bool isLoading = false;

  final List<String> categories = [
    'Food',
    'Drink',
    'Clothes',
    'Accessories',
    'Electronics',
    'Agricultural',
  ];

  final Map<String, List<String>> subCategories = {
    'Food': ['Snacks', 'Fruits', 'Vegetables', 'Others'],
    'Drink': ['Juice', 'Water', 'Soda', 'Coffee'],
    'Clothes': ['Men', 'Women', 'Kids'],
    'Accessories': ['Bags', 'Watches', 'Jewelry'],
    'Electronics': ['Phone', 'Laptop', 'Headphones'],
    'Agricultural': ['Seeds', 'Tools', 'Fertilizers'],
  };

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 80);
    if (pickedFile != null) {
      setState(() => imageFile = File(pickedFile.path));
    }
  }

  Future<String> uploadImageToFirebase(File imageFile) async {
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final ref =
        FirebaseStorage.instance.ref().child('product_images/$fileName.jpg');
    await ref.putFile(imageFile);
    return await ref.getDownloadURL();
  }

  Future<void> addProduct() async {
    final name = nameController.text.trim();
    final priceText = priceController.text.trim();
    final description = descriptionController.text.trim();

    if (name.isEmpty ||
        priceText.isEmpty ||
        imageFile == null ||
        selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❗ សូមបញ្ចូលព័ត៌មានឲ្យពេញ')),
      );
      return;
    }

    final price = double.tryParse(priceText);
    if (price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('💲 តម្លៃត្រូវតែជាចំនួន')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final imageUrl = await uploadImageToFirebase(imageFile!);

      // Generate a unique productId
      final productId = FirebaseFirestore.instance.collection('product_db').doc().id;

      // Format price
      final formattedPrice = NumberFormat("#,##0.00", "en_US").format(price);

      await FirebaseFirestore.instance.collection('product_db').doc(productId).set({
        'productId': productId,
        'name': name,
        'price': price,
        'formattedPrice': formattedPrice,
        'description': description,
        'image': imageUrl,
        'category': selectedCategory,
        'subCategory': selectedSubCategory ?? '',
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ បញ្ចូលទិន្នន័យជោគជ័យ')),
      );

      nameController.clear();
      priceController.clear();
      descriptionController.clear();
      setState(() {
        selectedCategory = null;
        selectedSubCategory = null;
        imageFile = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ បញ្ចូលទិន្នន័យបរាជ័យ: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF142338);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("🛒 Add Product"),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // Show dialog to choose Camera or Gallery
                showModalBottomSheet(
                  context: context,
                  builder: (_) => SafeArea(
                    child: Wrap(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.photo_library),
                          title: const Text("Gallery"),
                          onTap: () {
                            pickImage(ImageSource.gallery);
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.camera_alt),
                          title: const Text("Camera"),
                          onTap: () {
                            pickImage(ImageSource.camera);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: imageFile != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(imageFile!, fit: BoxFit.cover),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.cloud_upload_rounded, size: 50, color:Color(0xFF142338)),
                          SizedBox(height: 10),
                          Text("Tap to upload product image",
                              style: TextStyle(color: Colors.grey, fontSize: 15)),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 24),
            _buildTextField(controller: nameController, label: "Product Name", icon: Icons.shopping_bag_rounded),
            const SizedBox(height: 16),
            _buildTextField(controller: priceController, label: "Price", icon: Icons.attach_money_rounded, isNumber: true),
            const SizedBox(height: 16),
            _buildTextField(controller: descriptionController, label: "Description", icon: Icons.description_rounded, maxLines: 3),
            const SizedBox(height: 16),
            _buildDropdown(
              label: "Category",
              icon: Icons.category_rounded,
              value: selectedCategory,
              items: categories,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                  selectedSubCategory = null;
                });
              },
            ),
            const SizedBox(height: 16),
            if (selectedCategory != null)
              _buildDropdown(
                label: "Subcategory",
                icon: Icons.subdirectory_arrow_right_rounded,
                value: selectedSubCategory,
                items: subCategories[selectedCategory] ?? [],
                onChanged: (value) => setState(() => selectedSubCategory = value),
              ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : addProduct,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  elevation: 3,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Add Product", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isNumber = false,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFFFFA000)),
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFFFA000), width: 1.3)),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required IconData icon,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: items.contains(value) ? value : null,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFFFFA000)),
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
      ),
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
      onChanged: onChanged,
    );
  }
}

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
// import 'package:file_picker/file_picker.dart';

// class AddDataScreen extends StatefulWidget {
//   const AddDataScreen({super.key});

//   @override
//   State<AddDataScreen> createState() => _AddDataScreenState();
// }

// class _AddDataScreenState extends State<AddDataScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();

//   String? selectedCategory;
//   String? selectedSubCategory;
//   File? imageFile;
//   File? documentFile;
//   bool isLoading = false;

//   final List<String> categories = [
//     'Food',
//     'Drink',
//     'Clothes',
//     'Accessories',
//     'Electronics',
//     'Agricultural',
//   ];

//   final Map<String, List<String>> subCategories = {
//     'Food': ['Snacks', 'Fruits', 'Vegetables', 'Others'],
//     'Drink': ['Juice', 'Water', 'Soda', 'Coffee'],
//     'Clothes': ['Men', 'Women', 'Kids'],
//     'Accessories': ['Bags', 'Watches', 'Jewelry'],
//     'Electronics': ['Phone', 'Laptop', 'Headphones'],
//     'Agricultural': ['Seeds', 'Tools', 'Fertilizers'],
//   };

//   Future<void> pickImage(ImageSource source) async {
//     final picker = ImagePicker();
//     final pickedFile =
//         await picker.pickImage(source: source, imageQuality: 80);
//     if (pickedFile != null) {
//       setState(() => imageFile = File(pickedFile.path));
//     }
//   }

//   Future<void> pickDocument() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf', 'doc', 'docx'],
//     );
//     if (result != null && result.files.single.path != null) {
//       setState(() => documentFile = File(result.files.single.path!));
//     }
//   }

//   Future<String> uploadFileToFirebase(File file, String folder) async {
//     final fileName = DateTime.now().millisecondsSinceEpoch.toString();
//     final ref = FirebaseStorage.instance.ref().child('$folder/$fileName');
//     await ref.putFile(file);
//     return await ref.getDownloadURL();
//   }

//   Future<void> addProduct() async {
//     final name = nameController.text.trim();
//     final priceText = priceController.text.trim();
//     final description = descriptionController.text.trim();

//     if (name.isEmpty ||
//         priceText.isEmpty ||
//         imageFile == null ||
//         selectedCategory == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('❗ សូមបញ្ចូលព័ត៌មានឲ្យពេញ')),
//       );
//       return;
//     }

//     final price = double.tryParse(priceText);
//     if (price == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('💲 តម្លៃត្រូវតែជាចំនួន')),
//       );
//       return;
//     }

//     setState(() => isLoading = true);

//     try {
//       final imageUrl = await uploadFileToFirebase(imageFile!, 'product_images');
//       String? documentUrl;
//       if (documentFile != null) {
//         documentUrl =
//             await uploadFileToFirebase(documentFile!, 'product_docs');
//       }

//       final productId =
//           FirebaseFirestore.instance.collection('product_db').doc().id;

//       final formattedPrice = NumberFormat("#,##0.00", "en_US").format(price);

//       await FirebaseFirestore.instance.collection('product_db').doc(productId).set({
//         'productId': productId,
//         'name': name,
//         'price': price,
//         'formattedPrice': formattedPrice,
//         'description': description,
//         'image': imageUrl,
//         'document': documentUrl ?? '',
//         'category': selectedCategory,
//         'subCategory': selectedSubCategory ?? '',
//         'createdAt': FieldValue.serverTimestamp(),
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('✅ បញ្ចូលទិន្នន័យជោគជ័យ')),
//       );

//       nameController.clear();
//       priceController.clear();
//       descriptionController.clear();
//       setState(() {
//         selectedCategory = null;
//         selectedSubCategory = null;
//         imageFile = null;
//         documentFile = null;
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('❌ បញ្ចូលទិន្នន័យបរាជ័យ: $e')),
//       );
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     const primaryColor = Color(0xFF142338);

//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: const Text("🛒 Add Product"),
//         backgroundColor: primaryColor,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Image Picker
//             GestureDetector(
//               onTap: () {
//                 showModalBottomSheet(
//                   context: context,
//                   builder: (_) => SafeArea(
//                     child: Wrap(
//                       children: [
//                         ListTile(
//                           leading: const Icon(Icons.photo_library),
//                           title: const Text("Gallery"),
//                           onTap: () {
//                             pickImage(ImageSource.gallery);
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                         ListTile(
//                           leading: const Icon(Icons.camera_alt),
//                           title: const Text("Camera"),
//                           onTap: () {
//                             pickImage(ImageSource.camera);
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//               child: Container(
//                 width: double.infinity,
//                 height: 180,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.black.withOpacity(0.05),
//                         blurRadius: 8,
//                         offset: const Offset(0, 3)),
//                   ],
//                 ),
//                 child: imageFile != null
//                     ? ClipRRect(
//                         borderRadius: BorderRadius.circular(16),
//                         child: Image.file(imageFile!, fit: BoxFit.cover),
//                       )
//                     : Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: const [
//                           Icon(Icons.cloud_upload_rounded,
//                               size: 50, color: Color(0xFF142338)),
//                           SizedBox(height: 10),
//                           Text("Tap to upload product image",
//                               style:
//                                   TextStyle(color: Colors.grey, fontSize: 15)),
//                         ],
//                       ),
//               ),
//             ),

//             const SizedBox(height: 16),
//             // Document Picker
//             ElevatedButton.icon(
//               onPressed: pickDocument,
//               icon: const Icon(Icons.attach_file),
//               label: Text(documentFile != null
//                   ? 'Document: ${documentFile!.path.split('/').last}'
//                   : 'Upload PDF/Doc'),
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.orange,
//                   padding: const EdgeInsets.symmetric(vertical: 14)),
//             ),

//             const SizedBox(height: 24),
//             _buildTextField(
//                 controller: nameController,
//                 label: "Product Name",
//                 icon: Icons.shopping_bag_rounded),
//             const SizedBox(height: 16),
//             _buildTextField(
//                 controller: priceController,
//                 label: "Price",
//                 icon: Icons.attach_money_rounded,
//                 isNumber: true),
//             const SizedBox(height: 16),
//             _buildTextField(
//                 controller: descriptionController,
//                 label: "Description",
//                 icon: Icons.description_rounded,
//                 maxLines: 3),
//             const SizedBox(height: 16),
//             _buildDropdown(
//               label: "Category",
//               icon: Icons.category_rounded,
//               value: selectedCategory,
//               items: categories,
//               onChanged: (value) {
//                 setState(() {
//                   selectedCategory = value;
//                   selectedSubCategory = null;
//                 });
//               },
//             ),
//             const SizedBox(height: 16),
//             if (selectedCategory != null)
//               _buildDropdown(
//                 label: "Subcategory",
//                 icon: Icons.subdirectory_arrow_right_rounded,
//                 value: selectedSubCategory,
//                 items: subCategories[selectedCategory] ?? [],
//                 onChanged: (value) => setState(() => selectedSubCategory = value),
//               ),
//             const SizedBox(height: 30),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: isLoading ? null : addProduct,
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: primaryColor,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(14))),
//                 child: isLoading
//                     ? const CircularProgressIndicator(color: Colors.white)
//                     : const Text("Add Product",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(
//       {required TextEditingController controller,
//       required String label,
//       required IconData icon,
//       bool isNumber = false,
//       int maxLines = 1}) {
//     return TextField(
//       controller: controller,
//       keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//       maxLines: maxLines,
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: Colors.orange),
//         labelText: label,
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding:
//             const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//         border:
//             OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
//         focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14),
//             borderSide: const BorderSide(color: Colors.orange, width: 1.3)),
//       ),
//     );
//   }

//   Widget _buildDropdown(
//       {required String label,
//       required IconData icon,
//       required String? value,
//       required List<String> items,
//       required Function(String?) onChanged}) {
//     return DropdownButtonFormField<String>(
//       value: items.contains(value) ? value : null,
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: Colors.orange),
//         labelText: label,
//         filled: true,
//         fillColor: Colors.white,
//         border:
//             OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
//       ),
//       items:
//           items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
//       onChanged: onChanged,
//     );
//   }
// }
