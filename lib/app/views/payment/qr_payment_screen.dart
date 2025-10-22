// lib/screens/payment/qr_payment_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controllrt.dart';
import '../../controllers/payment_controller.dart';

class QRPaymentScreen extends StatelessWidget {
  const QRPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentController = Get.find<PaymentController>();
    final cartController = Get.find<CartController>();
    const modernColor = Color(0xFFFFC107);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: modernColor,
        title: const Text("QR Payment", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text("Scan this QR code to pay", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Image.asset(
                      "assets/images/qr_code_sample.png",
                      height: 400,
                      width: 400,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                if (paymentController.deliveryLocation.value == null) {
                  Get.snackbar("Error", "No delivery location set!", backgroundColor: Colors.red, colorText: Colors.white);
                  return;
                }

                // Save order to local storage / SQLite
                await cartController.saveOrder(
                  "QR",
                  "QR${DateTime.now().millisecondsSinceEpoch}",
                );

                Get.snackbar(
                  "Payment Success",
                  "Order saved successfully!",
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                );

                // Optionally navigate to receipt screen
                // Get.to(() => ReceiptScreen(paymentMethod: "QR", transactionId: "QR123456"));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: modernColor,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("I've Paid", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}
