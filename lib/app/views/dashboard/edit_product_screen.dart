
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ProductEditScreen extends StatefulWidget {
//   final String docId;
//   final Map<String, dynamic> productData;

//   const ProductEditScreen({
//     super.key,
//     required this.docId,
//     required this.productData,
//   });

//   @override
//   State<ProductEditScreen> createState() => _ProductEditScreenState();
// }

// class _ProductEditScreenState extends State<ProductEditScreen> {
//   late TextEditingController nameController;
//   late TextEditingController priceController;
//   late TextEditingController descriptionController;
//   late TextEditingController imageController;
//   late TextEditingController categoryController;

//   bool isLoading = false;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     nameController = TextEditingController(text: widget.productData['name']);
//     priceController = TextEditingController(
//         text: widget.productData['price']?.toString() ?? '');
//     descriptionController =
//         TextEditingController(text: widget.productData['description']);
//     imageController = TextEditingController(text: widget.productData['image']);
//     categoryController =
//         TextEditingController(text: widget.productData['category']);
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     priceController.dispose();
//     descriptionController.dispose();
//     imageController.dispose();
//     categoryController.dispose();
//     super.dispose();
//   }

//   Future<void> updateProduct() async {
//     if (!_formKey.currentState!.validate()) return;
    
//     setState(() => isLoading = true);

//     try {
//       await FirebaseFirestore.instance
//           .collection('product_db')
//           .doc(widget.docId)
//           .update({
//         'name': nameController.text.trim(),
//         'price': double.tryParse(priceController.text) ?? 0,
//         'description': descriptionController.text.trim(),
//         'image': imageController.text.trim(),
//         'category': categoryController.text.trim(),
//         'updatedAt': FieldValue.serverTimestamp(),
//       });

//       // Show success snackbar
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('✅ Product updated successfully')),
//         );
//         // Navigate back
//         Navigator.pop(context);
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('❌ Error updating: $e')),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() => isLoading = false);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Edit Product")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 TextFormField(
//                   controller: nameController,
//                   decoration: const InputDecoration(labelText: "Product Name"),
//                   validator: (value) => value!.trim().isEmpty ? 'Enter a name' : null,
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: priceController,
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(labelText: "Price"),
//                   validator: (value) {
//                     if (value!.trim().isEmpty) return 'Enter a price';
//                     if (double.tryParse(value) == null) return 'Enter a valid number';
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: descriptionController,
//                   decoration: const InputDecoration(labelText: "Description"),
//                   maxLines: 3,
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: imageController,
//                   decoration: const InputDecoration(labelText: "Image URL"),
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: categoryController,
//                   decoration: const InputDecoration(labelText: "Category"),
//                   validator: (value) => value!.trim().isEmpty ? 'Enter a category' : null,
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: isLoading ? null : updateProduct,
//                   child: isLoading
//                       ? const CircularProgressIndicator(color: Colors.white)
//                       : const Text("Update Product"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductEditScreen extends StatefulWidget {
  final String docId;
  final Map<String, dynamic> productData;

  const ProductEditScreen({
    super.key,
    required this.docId,
    required this.productData,
  });

  @override
  State<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;
  late TextEditingController imageController;
  late TextEditingController categoryController;

  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.productData['name']);
    priceController = TextEditingController(
        text: widget.productData['price']?.toString() ?? '');
    descriptionController =
        TextEditingController(text: widget.productData['description']);
    imageController = TextEditingController(text: widget.productData['image']);
    categoryController =
        TextEditingController(text: widget.productData['category']);
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    imageController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  Future<void> updateProduct() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      await FirebaseFirestore.instance
          .collection('product_db')
          .doc(widget.docId)
          .update({
        'name': nameController.text.trim(),
        'price': double.tryParse(priceController.text) ?? 0,
        'description': descriptionController.text.trim(),
        'image': imageController.text.trim(),
        'category': categoryController.text.trim(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      Get.snackbar(
        '✅ Success',
        'Product updated successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
      );

      Navigator.pop(context);
    } catch (e) {
      Get.snackbar(
        '❌ Error',
        'Failed to update: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final primaryColor = isDarkMode ? Colors.orange : Colors.orange;
    final cardColor = isDarkMode ? Colors.grey[850] : Colors.white;
    final backgroundColor =
        isDarkMode ? Colors.black87 : const Color(0xFFF5F5F5);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          "✏️ Edit Product",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Card(
            color: cardColor,
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      label: "Product Name",
                      controller: nameController,
                      icon: Icons.shopping_bag_outlined,
                      validator: (value) =>
                          value!.trim().isEmpty ? 'Enter a name' : null,
                    ),
                    _buildTextField(
                      label: "Price",
                      controller: priceController,
                      icon: Icons.attach_money,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.trim().isEmpty) return 'Enter a price';
                        if (double.tryParse(value) == null) {
                          return 'Enter a valid number';
                        }
                        return null;
                      },
                    ),
                    _buildTextField(
                      label: "Description",
                      controller: descriptionController,
                      icon: Icons.description_outlined,
                      maxLines: 3,
                    ),
                    _buildTextField(
                      label: "Image URL",
                      controller: imageController,
                      icon: Icons.image_outlined,
                    ),
                    _buildTextField(
                      label: "Category",
                      controller: categoryController,
                      icon: Icons.category_outlined,
                      validator: (value) =>
                          value!.trim().isEmpty ? 'Enter a category' : null,
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.save, color: Colors.white),
                        label: Text(
                          isLoading ? "Updating..." : "Update Product",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF142338),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          elevation: 6,
                          shadowColor: Colors.black54,
                        ),
                        onPressed: isLoading ? null : updateProduct,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.orange),
          labelText: label,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.orange, width: 1.5),
          ),
        ),
      ),
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
// import 'package:get/get.dart';

// class ProductEditScreen extends StatefulWidget {
//   final String docId;
//   final Map<String, dynamic> productData;

//   const ProductEditScreen({
//     super.key,
//     required this.docId,
//     required this.productData,
//   });

//   @override
//   State<ProductEditScreen> createState() => _ProductEditScreenState();
// }

// class _ProductEditScreenState extends State<ProductEditScreen> {
//   late TextEditingController nameController;
//   late TextEditingController priceController;
//   late TextEditingController descriptionController;

//   String? selectedCategory;
//   String? selectedSubCategory;
//   File? imageFile;
//   File? documentFile;
//   bool isLoading = false;

//   final List<String> categories = [
//     'Food', 'Drink', 'Clothes', 'Accessories', 'Electronics', 'Agricultural',
//   ];

//   final Map<String, List<String>> subCategories = {
//     'Food': ['Snacks', 'Fruits', 'Vegetables', 'Others'],
//     'Drink': ['Juice', 'Water', 'Soda', 'Coffee'],
//     'Clothes': ['Men', 'Women', 'Kids'],
//     'Accessories': ['Bags', 'Watches', 'Jewelry'],
//     'Electronics': ['Phone', 'Laptop', 'Headphones'],
//     'Agricultural': ['Seeds', 'Tools', 'Fertilizers'],
//   };

//   @override
//   void initState() {
//     super.initState();
//     nameController = TextEditingController(text: widget.productData['name']);
//     priceController = TextEditingController(
//         text: widget.productData['price']?.toString() ?? '');
//     descriptionController =
//         TextEditingController(text: widget.productData['description']);
//     selectedCategory = widget.productData['category'];
//     selectedSubCategory = widget.productData['subCategory'];
//   }

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

//   Future<void> updateProduct() async {
//     if (nameController.text.trim().isEmpty ||
//         priceController.text.trim().isEmpty ||
//         selectedCategory == null) {
//       Get.snackbar(
//         '❌ Error',
//         'សូមបញ្ចូលព័ត៌មានឲ្យពេញ',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return;
//     }

//     final price = double.tryParse(priceController.text.trim()) ?? 0;
//     setState(() => isLoading = true);

//     try {
//       String imageUrl = widget.productData['image'] ?? '';
//       String? documentUrl = widget.productData['document'];

//       if (imageFile != null) {
//         imageUrl = await uploadFileToFirebase(imageFile!, 'product_images');
//       }
//       if (documentFile != null) {
//         documentUrl =
//             await uploadFileToFirebase(documentFile!, 'product_docs');
//       }

//       final formattedPrice =
//           NumberFormat("#,##0.00", "en_US").format(price);

//       await FirebaseFirestore.instance
//           .collection('product_db')
//           .doc(widget.docId)
//           .update({
//         'name': nameController.text.trim(),
//         'price': price,
//         'formattedPrice': formattedPrice,
//         'description': descriptionController.text.trim(),
//         'image': imageUrl,
//         'document': documentUrl ?? '',
//         'category': selectedCategory,
//         'subCategory': selectedSubCategory ?? '',
//         'updatedAt': FieldValue.serverTimestamp(),
//       });

//       Get.snackbar(
//         '✅ Success',
//         'Product updated successfully!',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//       );

//       Navigator.pop(context);
//     } catch (e) {
//       Get.snackbar(
//         '❌ Error',
//         'Failed to update: $e',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     const primaryColor = Color(0xFF142338);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("✏️ Edit Product"),
//         backgroundColor: primaryColor,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
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
//                             Navigator.pop(context);
//                           },
//                         ),
//                         ListTile(
//                           leading: const Icon(Icons.camera_alt),
//                           title: const Text("Camera"),
//                           onTap: () {
//                             pickImage(ImageSource.camera);
//                             Navigator.pop(context);
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//               child: Container(
//                 height: 180,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: imageFile != null
//                     ? ClipRRect(
//                         borderRadius: BorderRadius.circular(16),
//                         child: Image.file(imageFile!, fit: BoxFit.cover),
//                       )
//                     : (widget.productData['image'] != null &&
//                             widget.productData['image'] != ''
//                         ? ClipRRect(
//                             borderRadius: BorderRadius.circular(16),
//                             child: Image.network(widget.productData['image'],
//                                 fit: BoxFit.cover),
//                           )
//                         : const Icon(Icons.cloud_upload_rounded,
//                             size: 50, color: Colors.orange)),
//               ),
//             ),
//             const SizedBox(height: 16),
//             // Document Picker
//             ElevatedButton.icon(
//               onPressed: pickDocument,
//               icon: const Icon(Icons.attach_file),
//               label: Text(documentFile != null
//                   ? 'Document: ${documentFile!.path.split('/').last}'
//                   : (widget.productData['document'] != null &&
//                           widget.productData['document'] != ''
//                       ? 'Current: ${widget.productData['document'].split('/').last}'
//                       : 'Upload PDF/Doc')),
//             ),
//             const SizedBox(height: 16),
//             _buildTextField(nameController, "Product Name"),
//             const SizedBox(height: 16),
//             _buildTextField(priceController, "Price", isNumber: true),
//             const SizedBox(height: 16),
//             _buildTextField(descriptionController, "Description", maxLines: 3),
//             const SizedBox(height: 16),
//             _buildDropdown("Category", selectedCategory, categories, (value) {
//               setState(() {
//                 selectedCategory = value;
//                 selectedSubCategory = null;
//               });
//             }),
//             const SizedBox(height: 16),
//             if (selectedCategory != null)
//               _buildDropdown(
//                   "Subcategory",
//                   selectedSubCategory,
//                   subCategories[selectedCategory] ?? [], (value) {
//                 setState(() => selectedSubCategory = value);
//               }),
//             const SizedBox(height: 30),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: isLoading ? null : updateProduct,
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: primaryColor,
//                     padding: const EdgeInsets.symmetric(vertical: 16)),
//                 child: isLoading
//                     ? const CircularProgressIndicator(color: Colors.white)
//                     : const Text("Update Product",
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.w600)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(TextEditingController controller, String label,
//       {bool isNumber = false, int maxLines = 1}) {
//     return TextField(
//       controller: controller,
//       keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//       maxLines: maxLines,
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(Icons.edit, color: Colors.orange),
//         filled: true,
//         fillColor: Colors.white,
//         border:
//             OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
//         focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14),
//             borderSide: const BorderSide(color: Colors.orange, width: 1.3)),
//       ),
//     );
//   }

//   Widget _buildDropdown(String label, String? value, List<String> items,
//       Function(String?) onChanged) {
//     return DropdownButtonFormField<String>(
//       value: items.contains(value) ? value : null,
//       decoration: InputDecoration(
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
