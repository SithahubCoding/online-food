import 'package:flutter/material.dart';
import '../data/database_helper.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order History")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper.instance.getOrders(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final orders = snapshot.data!;
          if (orders.isEmpty) return const Center(child: Text("No orders yet"));

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text("Order #${order['id']} - \$${order['total']}"),
                  subtitle: Text("Payment: ${order['paymentMethod']}\n"
                      "Location: (${order['deliveryLat']}, ${order['deliveryLng']})\n"
                      "Items: ${order['items']}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
