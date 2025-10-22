import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_product_screen.dart';
class ProductScreenList extends StatefulWidget {
  const ProductScreenList({super.key});

  @override
  State<ProductScreenList> createState() => _ProductScreenListState();
}

class _ProductScreenListState extends State<ProductScreenList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product List")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('product_db').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No products found."));
          }

          final products = snapshot.data!.docs;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final data = products[index].data() as Map<String, dynamic>;
              final docId = products[index].id;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: ListTile(
                  leading: data['image'] != null && data['image'] != ''
                      ? Image.network(
                          data['image'],
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.image_not_supported, size: 60),
                  title: Text(data['name'] ?? 'No Name'),
                  subtitle: Text("Price: \$${data['price'] ?? 'N/A'}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 🔹 EDIT button
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductEditScreen(
                                docId: docId,
                                productData: data,
                              ),
                            ),
                          );
                        },
                      ),
                      // 🔹 DELETE button
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('product_db')
                              .doc(docId)
                              .delete();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
