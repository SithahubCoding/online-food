
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/cart_controllrt.dart';
import '../controllers/payment_controller.dart';
import './location_screen.dart';
import './payment/payment_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cartController = Get.put(CartController());
  final paymentController = Get.put(PaymentController());

  final Color primaryColor = const Color(0xFF1E88E5); // Blue
  final Color accentColor = const Color(0xFFFFC107); // Amber

  @override
  void initState() {
    super.initState();
    cartController.loadCart(); // load cart from SQLite
  }

  void _chooseDeliveryLocation() async {
    final result = await Get.to(() => const DeliveryLocationScreen());
    if (result != null && result is LatLng) {
      cartController.setDeliveryLocation(result);
      Get.snackbar(
        'Location Selected',
        'Delivery location updated!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
      );
    }
  }

  void _checkout() {
    if (cartController.deliveryLocation.value == null) {
      Get.snackbar(
        'No Location',
        'Please select delivery location!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    // Sync to PaymentController
    paymentController.setSubtotal(cartController.totalPrice);
    paymentController.deliveryFee.value = cartController.deliveryFee.value;
    paymentController.setDeliveryLocation(cartController.deliveryLocation.value!);

    Get.to(() => const PaymentScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          "Your Cart 🛒",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() {
        if (cartController.items.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
                SizedBox(height: 10),
                Text(
                  "Your cart is feeling light!",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.only(top: 8, bottom: 120),
          itemCount: cartController.items.length,
          itemBuilder: (context, index) {
            final item = cartController.items[index];
            final quantity = cartController.quantities[index];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // Product Image
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: item.image.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  item.image,
                                  fit: BoxFit.cover,
                                  width: 70,
                                  height: 70,
                                ),
                              )
                            : const Center(child: Icon(Icons.image_not_supported)),
                      ),
                      const SizedBox(width: 12),
                      // Product Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "\$${(item.price * quantity).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 16,
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "\$${item.price.toStringAsFixed(2)} per unit",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Quantity Controls + Delete
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete_outline, size: 24, color: Colors.red),
                            onPressed: () => cartController.removeItem(index),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove, size: 20, color: Colors.red),
                                  onPressed: () {
                                    if (quantity > 1) {
                                      cartController.addToCart(item, -1);
                                    } else {
                                      cartController.removeItem(index);
                                    }
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Text(
                                    "$quantity",
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add, size: 20, color: Colors.green),
                                  onPressed: () => cartController.addToCart(item, 1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
      // Bottom Summary Bar
      bottomNavigationBar: Obx(() {
        if (cartController.items.isEmpty) return const SizedBox.shrink();

        final subtotal = cartController.totalPrice;
        final deliveryFee = cartController.deliveryFee.value;
        final total = subtotal + deliveryFee;

        return Container(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, spreadRadius: 2),
            ],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _priceRow("Subtotal", subtotal),
              _priceRow("Delivery Fee", deliveryFee),
              const Divider(height: 16, color: Colors.grey),
              _priceRow("Total", total, isBold: true, color: primaryColor, fontSize: 18),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: Icon(Icons.location_on_outlined, color: accentColor),
                      label: const Text("Location", style: TextStyle(color: Colors.black87)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        side: BorderSide(color: accentColor, width: 2),
                        backgroundColor: accentColor.withOpacity(0.2),
                      ),
                      onPressed: _chooseDeliveryLocation,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
                      label: const Text("Checkout", style: TextStyle(color: Colors.white, fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 5,
                      ),
                      onPressed: _checkout,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _priceRow(String label, double value,
      {bool isBold = false, Color color = Colors.black87, double fontSize = 16}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              fontSize: fontSize,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            "\$${value.toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              fontSize: fontSize,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
