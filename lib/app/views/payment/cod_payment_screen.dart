import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controllrt.dart';
import '../../controllers/payment_controller.dart';
import '../receipt_screen.dart';

class CODPaymentScreen extends StatelessWidget {
  const CODPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final paymentController = Get.find<PaymentController>();
    const modernColor = Color(0xFFFFC107);

    final total = paymentController.subtotal.value + paymentController.deliveryFee.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cash on Delivery"),
        backgroundColor: modernColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "You will pay upon delivery",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Text(
                      "Delivery Location:\nLat: ${paymentController.deliveryLocation.value!.latitude.toStringAsFixed(4)}, "
                      "Lng: ${paymentController.deliveryLocation.value!.longitude.toStringAsFixed(4)}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Text("Total: \$${total.toStringAsFixed(2)}", style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                await cartController.saveOrder(
                  "COD",
                  "COD${DateTime.now().millisecondsSinceEpoch}",
                );

                Get.snackbar("Order Saved", "Your COD order has been saved",
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM);

                // Navigate to ReceiptScreen
                Get.to(() => const ReceiptScreen(paymentMethod: "COD"));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: modernColor,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Confirm COD Payment", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
