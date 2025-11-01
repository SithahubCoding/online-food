import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SaleInfoScreen extends StatelessWidget {
  const SaleInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat("#,##0.00", "en_US");

    return Scaffold(
      appBar: AppBar(
        title: const Text("📊 Sale Info"),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('sales').orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final docs = snapshot.data!.docs;
          if (docs.isEmpty) return const Center(child: Text("No sale info yet."));

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final total = data['total'] ?? 0;
              final timestamp = data['createdAt'] as Timestamp?;
              final date = timestamp?.toDate() ?? DateTime.now();

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 3,
                child: ListTile(
                  leading: const Icon(Icons.shopping_cart, color: Colors.orange),
                  title: Text("${data['userName'] ?? 'User'}"),
                  subtitle: Text("${DateFormat.yMMMd().format(date)}"),
                  trailing: Text("\$${currencyFormat.format(total)}", style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
