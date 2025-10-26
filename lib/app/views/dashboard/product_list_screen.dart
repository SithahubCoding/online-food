

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'edit_product_screen.dart';

// class ProductScreenList extends StatefulWidget {
//   const ProductScreenList({super.key});

//   @override
//   State<ProductScreenList> createState() => _ProductScreenListState();
// }

// class _ProductScreenListState extends State<ProductScreenList> {
//   String searchQuery = '';
//   String selectedCategory = 'All';
//   String selectedPriceOrder = 'Default';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("All Products"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: () {
//               // TODO: Navigate to Add Product Screen
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           _buildSearchBar(),
//           _buildFilterRow(),
//           Expanded(child: _buildProductList()),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextField(
//         decoration: InputDecoration(
//           prefixIcon: const Icon(Icons.search),
//           hintText: 'Search by name...',
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//         ),
//         onChanged: (value) {
//           setState(() => searchQuery = value.toLowerCase());
//         },
//       ),
//     );
//   }

//   Widget _buildFilterRow() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: Row(
//         children: [
//           DropdownButton<String>(
//             value: selectedCategory,
//             items: const [
//               DropdownMenuItem(value: 'All', child: Text('All')),
//               DropdownMenuItem(value: 'Fast Food', child: Text('Fast Food')),
//               DropdownMenuItem(value: 'Drinks', child: Text('Drinks')),
//             ],
//             onChanged: (value) {
//               setState(() => selectedCategory = value!);
//             },
//           ),
//           const SizedBox(width: 10),
//           DropdownButton<String>(
//             value: selectedPriceOrder,
//             items: const [
//               DropdownMenuItem(value: 'Default', child: Text('Default')),
//               DropdownMenuItem(value: 'LowToHigh', child: Text('Price ↑')),
//               DropdownMenuItem(value: 'HighToLow', child: Text('Price ↓')),
//             ],
//             onChanged: (value) {
//               setState(() => selectedPriceOrder = value!);
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProductList() {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('product_db').snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return const Center(child: Text("No products found."));
//         }

//         List<QueryDocumentSnapshot> products = snapshot.data!.docs;

//         // 🧩 Filter by category
//         if (selectedCategory != 'All') {
//           products = products
//               .where((p) => (p['category'] ?? '') == selectedCategory)
//               .toList();
//         }

//         // 🧩 Filter by search
//         if (searchQuery.isNotEmpty) {
//           products = products
//               .where((p) =>
//                   (p['name'] ?? '').toString().toLowerCase().contains(searchQuery))
//               .toList();
//         }

//         // 🧩 Sort by price
//         if (selectedPriceOrder == 'LowToHigh') {
//           products.sort((a, b) =>
//               (a['price'] ?? 0).compareTo(b['price'] ?? 0));
//         } else if (selectedPriceOrder == 'HighToLow') {
//           products.sort((a, b) =>
//               (b['price'] ?? 0).compareTo(a['price'] ?? 0));
//         }

//         return GridView.builder(
//           padding: const EdgeInsets.all(10),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 12,
//             mainAxisSpacing: 12,
//             childAspectRatio: 0.75,
//           ),
//           itemCount: products.length,
//           itemBuilder: (context, index) {
//             final data = products[index].data() as Map<String, dynamic>;
//             final docId = products[index].id;

//             return Card(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15)),
//               elevation: 4,
//               child: InkWell(
//                 onTap: () {
//                   // TODO: Navigate to Product Detail
//                 },
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     ClipRRect(
//                       borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
//                       child: Image.network(
//                         data['image'] ?? '',
//                         height: 120,
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                         errorBuilder: (_, __, ___) =>
//                             const Icon(Icons.image_not_supported, size: 60),
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       data['name'] ?? 'No Name',
//                       style: const TextStyle(
//                           fontWeight: FontWeight.bold, fontSize: 16),
//                       textAlign: TextAlign.center,
//                     ),
//                     Text("\$${data['price'] ?? 'N/A'}",
//                         style:
//                             const TextStyle(color: Colors.green, fontSize: 14)),
//                     const Spacer(),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit, color: Colors.blue),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => ProductEditScreen(
//                                   docId: docId,
//                                   productData: data,
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete, color: Colors.red),
//                           onPressed: () async {
//                             await FirebaseFirestore.instance
//                                 .collection('product_db')
//                                 .doc(docId)
//                                 .delete();
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'edit_product_screen.dart'; // ត្រូវធានាថាឯកសារនេះមាន
// import 'add_data_screen.dart'; // ត្រូវធានាថាឯកសារនេះមាន

class ProductScreenList extends StatefulWidget {
  const ProductScreenList({super.key});

  @override
  State<ProductScreenList> createState() => _ProductScreenListState();
}

class _ProductScreenListState extends State<ProductScreenList> {
  String searchQuery = '';
  String selectedCategory = 'All';
  String selectedPriceOrder = 'Default';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Navigate to Add Product Screen
              // ឧទាហរណ៍: Navigator.push(context, MaterialPageRoute(builder: (context) => const AddDataScreen()));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilterRow(),
          Expanded(child: _buildProductList()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: 'Search by name...',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
        onChanged: (value) {
          setState(() => searchQuery = value.toLowerCase());
        },
      ),
    );
  }

  // ⚠️ ចំណាំ៖ DropdownMenu items គួរតែទាញពី Firestore category_db
  Widget _buildFilterRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          DropdownButton<String>(
            value: selectedCategory,
            items: const [
              DropdownMenuItem(value: 'All', child: Text('All')),
              DropdownMenuItem(value: 'Fast Food', child: Text('Fast Food')),
              DropdownMenuItem(value: 'Drinks', child: Text('Drinks')),
              // បន្ថែម Categories ផ្សេងទៀតតាម Firestore
            ],
            onChanged: (value) {
              setState(() => selectedCategory = value!);
            },
          ),
          const SizedBox(width: 10),
          DropdownButton<String>(
            value: selectedPriceOrder,
            items: const [
              DropdownMenuItem(value: 'Default', child: Text('Default')),
              DropdownMenuItem(value: 'LowToHigh', child: Text('Price ↑')),
              DropdownMenuItem(value: 'HighToLow', child: Text('Price ↓')),
            ],
            onChanged: (value) {
              setState(() => selectedPriceOrder = value!);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('product_db').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No products found."));
        }

        List<QueryDocumentSnapshot> products = snapshot.data!.docs;

        // 🧩 Filter by category
        if (selectedCategory != 'All') {
          products = products
              .where((p) => (p['category'] ?? '') == selectedCategory)
              .toList();
        }

        // 🧩 Filter by search
        if (searchQuery.isNotEmpty) {
          products = products
              .where((p) =>
                  (p['name'] ?? '').toString().toLowerCase().contains(searchQuery))
              .toList();
        }

        // 🧩 Sort by price
        if (selectedPriceOrder == 'LowToHigh') {
          products.sort((a, b) =>
              (a['price'] ?? 0).compareTo(b['price'] ?? 0));
        } else if (selectedPriceOrder == 'HighToLow') {
          products.sort((a, b) =>
              (b['price'] ?? 0).compareTo(a['price'] ?? 0));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final data = products[index].data() as Map<String, dynamic>;
            final docId = products[index].id;

            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              child: InkWell(
                onTap: () {
                  // TODO: Navigate to Product Detail
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                      child: Image.network(
                        data['image'] ?? '',
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.image_not_supported, size: 60),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      data['name'] ?? 'No Name',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    Text("\$${data['price'] ?? 'N/A'}",
                        style:
                            const TextStyle(color: Colors.green, fontSize: 14)),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductEditScreen(
                                  docId: docId,
                                  // ✅ កែតម្រូវ: បញ្ជូន Map data ផ្ទាល់
                                  productData: data, 
                                ),
                              ),
                            );
                          },
                        ),
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
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}