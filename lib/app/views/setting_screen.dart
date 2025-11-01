import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/database_helper.dart';
import 'package:intl/intl.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late Future<List<Map<String, dynamic>>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = DatabaseHelper.instance.getOrders();
  }

  String formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy, hh:mm a').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  Future<void> _refreshOrders() async {
    setState(() {
      _ordersFuture = DatabaseHelper.instance.getOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings & Orders"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _ordersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.receipt_long, size: 80, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      "No orders found",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            final orders = snapshot.data!;

            return RefreshIndicator(
              onRefresh: _refreshOrders,
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        child: const Icon(Icons.receipt_long, color: Colors.white),
                      ),
                      title: Text(
                        "Order #${order['id']}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Total: \$${order['total'] ?? 0}"),
                          const SizedBox(height: 4),
                          Text("Payment: ${order['paymentMethod'] ?? '-'}"),
                          const SizedBox(height: 4),
                          Text("Date: ${formatDate(order['createdAt'] ?? '-')}")
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        // Navigate to Order Detail Screen (if implemented)
                        Get.snackbar("Order Selected", "Order #${order['id']}", snackPosition: SnackPosition.BOTTOM);
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
