import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/payment_controller.dart';
import '../../models/payment_method.dart';
import 'card_payment_screen.dart';
import 'cod_payment_screen.dart';
import 'qr_payment_screen.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentController = Get.find<PaymentController>();
    const modernColor = Color(0xFFFFC107);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: modernColor,
        elevation: 2,
      ),
      body: Obx(() {
        if (paymentController.deliveryLocation.value == null) {
          return const Center(child: Text("No delivery location selected"));
        }

        final subtotal = paymentController.subtotal.value;
        final deliveryFee = paymentController.deliveryFee.value;
        final total = subtotal + deliveryFee;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Delivery Location Card
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Delivery Location:\nLat: ${paymentController.deliveryLocation.value!.latitude.toStringAsFixed(4)}, "
                          "Lng: ${paymentController.deliveryLocation.value!.longitude.toStringAsFixed(4)}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Price Summary
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      _priceRow("Subtotal", subtotal),
                      _priceRow("Delivery Fee", deliveryFee),
                      const Divider(thickness: 1, height: 20),
                      _priceRow("Total", total, isBold: true),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              const Text("Choose Payment Method:", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              // Payment Buttons
              Row(
                children: PaymentMethod.values.map((method) {
                  final label = method.name.toUpperCase();

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ElevatedButton(
                        onPressed: () {
                          paymentController.selectPaymentMethod(method);

                          // Navigate to respective payment screen
                          switch (method) {
                            case PaymentMethod.card:
                              Get.to(() => const CardPaymentScreen());
                              break;
                            case PaymentMethod.cod:
                              Get.to(() => const CODPaymentScreen());
                              break;
                            case PaymentMethod.qr:
                              Get.to(() => const QRPaymentScreen());
                              break;
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: modernColor,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _priceRow(String label, double value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.w500, fontSize: 16)),
          Text("\$${value.toStringAsFixed(2)}", style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.w500, fontSize: 16)),
        ],
      ),
    );
  }
}
