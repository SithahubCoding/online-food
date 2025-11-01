// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controllers/payment_controller.dart';
// import '../../models/payment_method.dart';
// import 'card_payment_screen.dart';
// import 'cod_payment_screen.dart';
// import 'qr_payment_screen.dart';

// class PaymentScreen extends StatelessWidget {
//   const PaymentScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final paymentController = Get.find<PaymentController>();
//     const modernColor = Color(0xFFFFC107);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Payment", style: TextStyle(fontWeight: FontWeight.bold)),
//         backgroundColor: modernColor,
//         elevation: 2,
//       ),
//       body: Obx(() {
//         if (paymentController.deliveryLocation.value == null) {
//           return const Center(child: Text("No delivery location selected"));
//         }

//         final subtotal = paymentController.subtotal.value;
//         final deliveryFee = paymentController.deliveryFee.value;
//         final total = subtotal + deliveryFee;

//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Card(
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 elevation: 2,
//                 child: Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Row(
//                     children: [
//                       const Icon(Icons.location_on, color: Colors.red),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: Text(
//                           "Delivery Location:\nLat: ${paymentController.deliveryLocation.value!.latitude.toStringAsFixed(4)}, "
//                           "Lng: ${paymentController.deliveryLocation.value!.longitude.toStringAsFixed(4)}",
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Price Summary
//               Card(
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 elevation: 2,
//                 child: Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Column(
//                     children: [
//                       _priceRow("Subtotal", subtotal),
//                       _priceRow("Delivery Fee", deliveryFee),
//                       const Divider(thickness: 1, height: 20),
//                       _priceRow("Total", total, isBold: true),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),

//               const Text("Choose Payment Method:", style: TextStyle(fontWeight: FontWeight.bold)),
//               const SizedBox(height: 12),

//               // Payment Buttons
//               Row(
//                 children: PaymentMethod.values.map((method) {
//                   final label = method.name.toUpperCase();

//                   return Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 8),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           paymentController.selectPaymentMethod(method);

//                           // Navigate to respective payment screen
//                           switch (method) {
//                             case PaymentMethod.card:
//                               Get.to(() => const CardPaymentScreen());
//                               break;
//                             case PaymentMethod.cod:
//                               Get.to(() => const CODPaymentScreen());
//                               break;
//                             case PaymentMethod.qr:
//                               Get.to(() => const QRPaymentScreen());
//                               break;
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: modernColor,
//                           foregroundColor: Colors.black,
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                         ),
//                         child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }

//   Widget _priceRow(String label, double value, {bool isBold = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.w500, fontSize: 16)),
//           Text("\$${value.toStringAsFixed(2)}", style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.w500, fontSize: 16)),
//         ],
//       ),
//     );
//   }
// }
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
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // === Colors ===
    final primaryColor = Colors.orange;
    final accentColor = isDarkMode
        ? Colors.orangeAccent
        : Colors.amber.shade600;
    final cardColor = isDarkMode ? Colors.grey[850] : Colors.white;
    final backgroundColor = isDarkMode
        ? Colors.black87
        : const Color(0xFFF5F5F5);
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Payment",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        if (paymentController.deliveryLocation.value == null) {
          return Center(
            child: Text(
              "No delivery location selected",
              style: TextStyle(color: textColor),
            ),
          );
        }

        final subtotal = paymentController.subtotal.value;
        final deliveryFee = paymentController.deliveryFee.value;
        final total = subtotal + deliveryFee;

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Delivery Location Card
            Card(
              color: cardColor,
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadowColor: isDarkMode ? Colors.black54 : Colors.grey.shade400,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.redAccent),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Delivery Location:\nLat: ${paymentController.deliveryLocation.value!.latitude.toStringAsFixed(4)}, "
                        "Lng: ${paymentController.deliveryLocation.value!.longitude.toStringAsFixed(4)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Price Summary Card
            Card(
              color: cardColor,
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadowColor: isDarkMode ? Colors.black54 : Colors.grey.shade400,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _priceRow("Subtotal", subtotal, color: textColor),
                    _priceRow("Delivery Fee", deliveryFee, color: textColor),
                    const Divider(height: 20, color: Colors.grey),
                    _priceRow(
                      "Total",
                      total,
                      isBold: true,
                      color: primaryColor,
                      fontSize: 18,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            Text(
              "Choose Payment Method:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: PaymentMethod.values.map((method) {
                final label = method.name.toUpperCase();
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ElevatedButton(
                      onPressed: () {
                        paymentController.selectPaymentMethod(method);
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
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 6,
                        shadowColor: Colors.black54,
                      ),
                      child: Text(
                        label,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        if (paymentController.subtotal.value == 0)
          return const SizedBox.shrink();

        final subtotal = paymentController.subtotal.value;
        final deliveryFee = paymentController.deliveryFee.value;
        final total = subtotal + deliveryFee;

        return Container(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          decoration: BoxDecoration(
            color: cardColor,
            boxShadow: [
              BoxShadow(
                color: isDarkMode
                    ? Colors.black.withOpacity(0.25)
                    : Colors.grey.shade400,
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _priceRow("Subtotal", subtotal, color: textColor),
              _priceRow("Delivery Fee", deliveryFee, color: textColor),
              const Divider(height: 20, color: Colors.grey),
              _priceRow(
                "Total",
                total,
                isBold: true,
                color: primaryColor,
                fontSize: 18,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ), // <-- Customize padding here
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Proceed to Pay",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ), // internal padding inside button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 6,
                    shadowColor: Colors.black54,
                  ),
                  onPressed: () {
                    final method = paymentController.selectedMethod.value;
                    if (method != null) {
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
                    } else {
                      Get.snackbar(
                        "No Payment Method",
                        "Please select a payment method!",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _priceRow(
    String label,
    double value, {
    bool isBold = false,
    Color color = Colors.black87,
    double fontSize = 16,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              fontSize: fontSize,
              color: color,
            ),
          ),
          Text(
            "\៛${value.toStringAsFixed(2)}",
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
