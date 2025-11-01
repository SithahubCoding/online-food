
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/database_helper.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Future<List<Map<String, dynamic>>>? _ordersFuture;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  void _loadOrders() {
    _ordersFuture = DatabaseHelper.instance.getOrders();
  }

  void _deleteOrder(int id) async {
    await DatabaseHelper.instance.deleteOrder(id);
    Get.snackbar(
      "Deleted",
      "Order #$id has been deleted",
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
    setState(() {
      _loadOrders(); // Reload orders
    });
  }

  String formatDateTime(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "-";
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy, hh:mm a').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black87 : Colors.white;
    final cardColor = isDarkMode ? Colors.grey[850] : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final modernColor = Colors.orange;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Order History"),
        backgroundColor: modernColor,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No orders yet",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            );
          }

          final orders = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final formattedDate = formatDateTime(order['createdAt']);

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                elevation: 3,
                color: cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  title: Text(
                    "Order #${order['id']} - \$${order['total']}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Payment: ${order['paymentMethod']}",
                            style: TextStyle(color: textColor)),
                        Text(
                            "Location: (${order['deliveryLat']}, ${order['deliveryLng']})",
                            style: TextStyle(color: textColor)),
                        Text("Items: ${order['items']}", style: TextStyle(color: textColor)),
                        Text("Date: $formattedDate", style: TextStyle(color: textColor)),
                      ],
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () => _deleteOrder(order['id']),
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
