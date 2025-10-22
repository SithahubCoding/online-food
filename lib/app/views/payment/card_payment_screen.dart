// lib/screens/payment/card_payment_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controllrt.dart';
import '../../controllers/payment_controller.dart';
import '../receipt_screen.dart';

class CardPaymentScreen extends StatelessWidget {
  const CardPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final paymentController = Get.find<PaymentController>();
    const modernColor = Color(0xFFFFC107);

    // Card images list
    final cardImages = [
      "assets/images/viza_card.jpg",
      "assets/images/master_card.png",
      "assets/images/paypal_card.png",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Card Payment", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: modernColor,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Select Your Card",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Horizontal card selection
            SizedBox(
              height: 130,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: cardImages.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        cardImages[index],
                        height: 120,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),

            // Payment summary
            Obx(() {
              final subtotal = paymentController.subtotal.value;
              final deliveryFee = paymentController.deliveryFee.value;
              final total = subtotal + deliveryFee;

              return Column(
                children: [
                  _priceRow("Subtotal", subtotal),
                  _priceRow("Delivery Fee", deliveryFee),
                  const Divider(thickness: 1, height: 20),
                  _priceRow("Total", total, isBold: true),
                ],
              );
            }),
            const SizedBox(height: 32),

            // Pay button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (paymentController.deliveryLocation.value == null) {
                    Get.snackbar(
                      "Error",
                      "Please select delivery location first!",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    return;
                  }

                  // Save order to local storage / SQLite
                  await cartController.saveOrder(
                    "Card",
                    "TX${DateTime.now().millisecondsSinceEpoch}",
                  );

                  Get.snackbar(
                    "Payment Success",
                    "Order saved successfully!",
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );

                  // Navigate to Receipt Screen
                  Get.to(() => const ReceiptScreen(paymentMethod: "Card"));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: modernColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text(
                  "Pay with Card",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceRow(String label, double value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              )),
          Text("\$${value.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              )),
        ],
      ),
    );
  }
}
