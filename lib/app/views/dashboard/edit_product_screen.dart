
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


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

      // Show success snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Product updated successfully')),
        );
        // Navigate back
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Error updating: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Product")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Product Name"),
                  validator: (value) => value!.trim().isEmpty ? 'Enter a name' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Price"),
                  validator: (value) {
                    if (value!.trim().isEmpty) return 'Enter a price';
                    if (double.tryParse(value) == null) return 'Enter a valid number';
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: "Description"),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: imageController,
                  decoration: const InputDecoration(labelText: "Image URL"),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: categoryController,
                  decoration: const InputDecoration(labelText: "Category"),
                  validator: (value) => value!.trim().isEmpty ? 'Enter a category' : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLoading ? null : updateProduct,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Update Product"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
