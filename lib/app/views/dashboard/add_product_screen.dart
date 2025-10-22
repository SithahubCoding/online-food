// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';
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
//   final TextEditingController categoryController = TextEditingController();

//   File? selectedImage;
//   bool isUploading = false;
//   bool _isPicking = false;

//   final ImagePicker picker = ImagePicker();

//   /// 🖼️ Pick & Crop Image
//   Future<void> pickAndCropImage() async {
//     if (_isPicking) return;
//     _isPicking = true;

//     try {
//       final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//       if (pickedFile == null) return;

//       final croppedFile = await ImageCropper().cropImage(
//         sourcePath: pickedFile.path,
//         aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
//         compressQuality: 80,
//         uiSettings: [
//           AndroidUiSettings(
//             toolbarTitle: 'Crop Image',
//             toolbarColor: Colors.blue,
//             toolbarWidgetColor: Colors.white,
//             initAspectRatio: CropAspectRatioPreset.square,
//             lockAspectRatio: true,
//           ),
//           IOSUiSettings(title: 'Crop Image'),
//         ],
//       );

//       if (croppedFile != null) {
//         setState(() => selectedImage = File(croppedFile.path));
//       }
//     } catch (e) {
//       debugPrint("❌ Error picking image: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Image picker error: $e")),
//       );
//     } finally {
//       _isPicking = false;
//     }
//   }

//   /// ☁️ Upload to Firebase Storage
//   Future<String?> uploadImage(File image) async {
//     try {
//       final fileName = DateTime.now().millisecondsSinceEpoch.toString();
//       final ref = FirebaseStorage.instance.ref().child('products/$fileName.jpg');

//       // Upload file
//       final uploadTask = ref.putFile(image);
//       final snapshot = await uploadTask;

//       if (snapshot.state == TaskState.success) {
//         return await snapshot.ref.getDownloadURL();
//       } else {
//         throw Exception("Upload failed: ${snapshot.state}");
//       }
//     } on FirebaseException catch (e) {
//       throw Exception("Firebase Storage Error: ${e.code}");
//     } catch (e) {
//       throw Exception("Unexpected error: $e");
//     }
//   }

//   /// 🧾 Add Product to Firestore
//   Future<void> addProduct() async {
//     if (selectedImage == null) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text("Please select an image")));
//       return;
//     }

//     setState(() => isUploading = true);

//     try {
//       final imageUrl = await uploadImage(selectedImage!);

//       await FirebaseFirestore.instance.collection('product_db').add({
//         'name': nameController.text.trim(),
//         'price': double.tryParse(priceController.text) ?? 0,
//         'description': descriptionController.text.trim(),
//         'category': categoryController.text.trim(),
//         'image': imageUrl,
//         'createdAt': FieldValue.serverTimestamp(),
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("✅ Product added successfully")),
//       );

//       nameController.clear();
//       priceController.clear();
//       descriptionController.clear();
//       categoryController.clear();
//       setState(() => selectedImage = null);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("❌ Error: $e")),
//       );
//     } finally {
//       setState(() => isUploading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Add Product")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(
//                 controller: nameController,
//                 decoration: const InputDecoration(
//                     labelText: "Product Name", border: OutlineInputBorder()),
//               ),
//               const SizedBox(height: 12),
//               TextField(
//                 controller: priceController,
//                 decoration: const InputDecoration(
//                     labelText: "Price", border: OutlineInputBorder()),
//                 keyboardType: TextInputType.number,
//               ),
//               const SizedBox(height: 12),
//               TextField(
//                 controller: descriptionController,
//                 decoration: const InputDecoration(
//                     labelText: "Description", border: OutlineInputBorder()),
//                 maxLines: 3,
//               ),
//               const SizedBox(height: 12),
//               TextField(
//                 controller: categoryController,
//                 decoration: const InputDecoration(
//                     labelText: "Category", border: OutlineInputBorder()),
//               ),
//               const SizedBox(height: 12),
//               GestureDetector(
//                 onTap: pickAndCropImage,
//                 child: Container(
//                   width: double.infinity,
//                   height: 180,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: selectedImage == null
//                       ? const Center(child: Text("📸 Tap to select image"))
//                       : Image.file(selectedImage!, fit: BoxFit.cover),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: isUploading ? null : addProduct,
//                   child: isUploading
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

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  bool isLoading = false;

  Future<void> addProduct() async {
    final name = nameController.text.trim();
    final priceText = priceController.text.trim();
    final description = descriptionController.text.trim();
    final image = imageController.text.trim();
    final category = categoryController.text.trim();

    if (name.isEmpty || priceText.isEmpty || image.isEmpty) {
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
      await FirebaseFirestore.instance.collection('product_db').add({
        'name': name,
        'price': price,
        'description': description,
        'image': image,
        'category': category,
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ បញ្ចូលទិន្នន័យជោគជ័យ')),
      );

      nameController.clear();
      priceController.clear();
      descriptionController.clear();
      imageController.clear();
      categoryController.clear();
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
    return Scaffold(
      appBar: AppBar(title: const Text("Add Product")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Product Name',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Price',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: imageController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Image URL',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Category',
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : addProduct,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Add Product"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
