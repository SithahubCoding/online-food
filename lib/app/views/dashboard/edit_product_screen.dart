import 'package:flutter/material.dart';
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

  Future<void> updateProduct() async {
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

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Product updated successfully')),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Error updating: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Product")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Product Name"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Price"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: imageController,
                decoration: const InputDecoration(labelText: "Image URL"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: "Category"),
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
    );
  }
}
