
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controllers/cart_controller.dart';
// import '../../controllers/payment_controller.dart';
// import '../receipt_screen.dart';

// class CODPaymentScreen extends StatelessWidget {
//   const CODPaymentScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final cartController = Get.find<CartController>();
//     final paymentController = Get.find<PaymentController>();
//     const modernColor = Color(0xFFFFC107);

//     final total = paymentController.subtotal.value + paymentController.deliveryFee.value;

//     return Scaffold(
//       appBar: AppBar(title: const Text("Cash on Delivery"), backgroundColor: modernColor),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Text("You will pay upon delivery", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 24),

//             // Animated Card showing Total
//             TweenAnimationBuilder<double>(
//               tween: Tween(begin: 0.8, end: 1.0),
//               duration: const Duration(milliseconds: 400),
//               curve: Curves.easeOutBack,
//               builder: (context, scale, child) {
//                 return Transform.scale(
//                   scale: scale,
//                   child: Card(
//                     elevation: 6,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Text("Total: \$${total.toStringAsFixed(2)}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                     ),
//                   ),
//                 );
//               },
//             ),
//             const SizedBox(height: 32),

//             // Animated Confirm Button
//             TweenAnimationBuilder<double>(
//               tween: Tween(begin: 0.8, end: 1.0),
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeOutBack,
//               builder: (context, scale, child) {
//                 return Transform.scale(
//                   scale: scale,
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       await cartController.saveOrder("COD", "COD${DateTime.now().millisecondsSinceEpoch}");
//                       Get.to(() => const ReceiptScreen(paymentMethod: "COD"));
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: modernColor,
//                       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                     ),
//                     child: const Text("Confirm COD Payment", style: TextStyle(fontWeight: FontWeight.bold)),
//                   ),
//                 );
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/payment_controller.dart';
import '../receipt_screen.dart';

class CODPaymentScreen extends StatelessWidget {
  const CODPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final paymentController = Get.find<PaymentController>();
    const primaryColor = Colors.orange;

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black87 : const Color(0xFFF5F5F5);
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final cardColor = isDarkMode ? Colors.grey[850] : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Cash on Delivery", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "You will pay upon delivery",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Animated Card showing Total
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.8, end: 1.0),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutBack,
              builder: (context, scale, child) {
                return Opacity(
                  opacity: scale.clamp(0.0, 1.0),
                  child: Transform.scale(
                    scale: scale,
                    child: Card(
                      color: cardColor,
                      elevation: 6,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Obx(() {
                          final total = paymentController.subtotal.value + paymentController.deliveryFee.value;
                          return Text(
                            "Total: \$${total.toStringAsFixed(2)}",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
                          );
                        }),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),

            // Animated Confirm Button
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.8, end: 1.0),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              builder: (context, scale, child) {
                return Opacity(
                  opacity: scale.clamp(0.0, 1.0),
                  child: Transform.scale(
                    scale: scale,
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.attach_money, color: Colors.white),
                        label: const Text(
                          "Confirm COD Payment",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 6,
                          shadowColor: Colors.black54,
                        ),
                        onPressed: () async {
                          await cartController.saveOrder(
                            "COD",
                            "COD${DateTime.now().millisecondsSinceEpoch}",
                          );
                          Get.snackbar(
                            "Success",
                            "Order placed successfully!",
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                          Get.to(() => const ReceiptScreen(paymentMethod: "COD"));
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
