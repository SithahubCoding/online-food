
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controllers/cart_controller.dart';
// import '../../controllers/payment_controller.dart';
// import '../receipt_screen.dart';

// class CardPaymentScreen extends StatelessWidget {
//   const CardPaymentScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final cartController = Get.find<CartController>();
//     final paymentController = Get.find<PaymentController>();
//     const modernColor = Color(0xFFFFC107);

//     final cardImages = [
//       "assets/images/viza_card.jpg",
//       "assets/images/master_card.png",
//       "assets/images/viza_card.jpg",
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Card Payment", style: TextStyle(fontWeight: FontWeight.bold)),
//         backgroundColor: modernColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             const Text("Select Your Card", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 16),

//             // Animated horizontal card list
//             SizedBox(
//               height: 130,
//               child: ListView.separated(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: cardImages.length,
//                 separatorBuilder: (_, __) => const SizedBox(width: 16),
//                 itemBuilder: (context, index) {
//                   return TweenAnimationBuilder<double>(
//                     tween: Tween(begin: 0.8, end: 1.0),
//                     duration: const Duration(milliseconds: 300),
//                     curve: Curves.easeOutBack,
//                     builder: (context, scale, child) {
//                       return Transform.scale(
//                         scale: scale,
//                         child: Card(
//                           elevation: 6,
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(16),
//                             child: Image.asset(cardImages[index], width: 200, fit: BoxFit.cover),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 32),

//             // Payment Summary
//             Obx(() {
//               final subtotal = paymentController.subtotal.value;
//               final delivery = paymentController.deliveryFee.value;
//               final total = subtotal + delivery;
//               return Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       _priceRow("Subtotal", subtotal),
//                       _priceRow("Delivery Fee", delivery),
//                       const Divider(),
//                       _priceRow("Total", total, isBold: true),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//             const SizedBox(height: 32),

//             // Pay Button
//             ElevatedButton(
//               onPressed: () async {
//                 await cartController.saveOrder("Card", "TX${DateTime.now().millisecondsSinceEpoch}");
//                 Get.snackbar("Success", "Payment Successful!", backgroundColor: Colors.green, colorText: Colors.white);
//                 Get.to(() => const ReceiptScreen(paymentMethod: "Card"));
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: modernColor,
//                 padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 50),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//               ),
//               child: const Text("Pay with Card", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _priceRow(String label, double value, {bool isBold = false}) => Padding(
//         padding: const EdgeInsets.symmetric(vertical: 4),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
//             Text("\$${value.toStringAsFixed(2)}", style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
//           ],
//         ),
//       );
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/payment_controller.dart';
import '../receipt_screen.dart';

class CardPaymentScreen extends StatelessWidget {
  const CardPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final paymentController = Get.find<PaymentController>();
    const primaryColor = Colors.orange;

    final cardImages = [
      "assets/images/viza_card.jpg",
      "assets/images/master_card.png",
      "assets/images/viza_card.jpg",
    ];

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black87 : const Color(0xFFF5F5F5);
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final cardColor = isDarkMode ? Colors.grey[850] : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Card Payment", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Select Your Card",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Animated horizontal card list
            SizedBox(
              height: 130,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: cardImages.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  return TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.8, end: 1.0),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutBack,
                    builder: (context, scale, child) {
                      return Opacity(
                        opacity: scale.clamp(0.0, 1.0),
                        child: Transform.scale(
                          scale: scale,
                          child: Card(
                            elevation: 6,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(cardImages[index], width: 200, fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 32),

            // Payment Summary
            Obx(() {
              final subtotal = paymentController.subtotal.value;
              final delivery = paymentController.deliveryFee.value;
              final total = subtotal + delivery;
              return Card(
                color: cardColor,
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _priceRow("Subtotal", subtotal, textColor),
                      _priceRow("Delivery Fee", delivery, textColor),
                      const Divider(),
                      _priceRow("Total", total, textColor, isBold: true, fontSize: 18),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 32),

            // Pay Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.credit_card, color: Colors.white),
                  label: const Text(
                    "Pay with Card",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 6,
                    shadowColor: Colors.black54,
                  ),
                  onPressed: () async {
                    await cartController.saveOrder(
                      "Card",
                      "TX${DateTime.now().millisecondsSinceEpoch}",
                    );
                    Get.snackbar(
                      "Success",
                      "Payment Successful!",
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    Get.to(() => const ReceiptScreen(paymentMethod: "Card"));
                  },
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _priceRow(String label, double value, Color color,
      {bool isBold = false, double fontSize = 16}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  fontSize: fontSize,
                  color: color)),
          Text("\$${value.toStringAsFixed(2)}",
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  fontSize: fontSize,
                  color: color)),
        ],
      ),
    );
  }
}
