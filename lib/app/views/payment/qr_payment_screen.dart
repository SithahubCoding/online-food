
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controllers/cart_controller.dart';
// import '../../controllers/payment_controller.dart';
// import '../receipt_screen.dart';
// class QRPaymentScreen extends StatelessWidget {
//   const QRPaymentScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final paymentController = Get.find<PaymentController>();
//     final cartController = Get.find<CartController>();
//     const modernColor = Color(0xFFFFC107);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("QR Payment", style: TextStyle(fontWeight: FontWeight.bold)),
//         backgroundColor: modernColor,
//         elevation: 2,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               "Scan QR Code to Pay",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),

//             // QR Code Card with Fade + Scale animation
//             TweenAnimationBuilder<double>(
//               tween: Tween(begin: 0.8, end: 1.0),
//               duration: const Duration(milliseconds: 400),
//               curve: Curves.easeOutBack,
//               builder: (context, scale, child) {
//                 return Opacity(
//                   opacity: scale,
//                   child: Transform.scale(
//                     scale: scale,
//                     child: Card(
//                       elevation: 6,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Image.asset(
//                           "assets/images/qr_code_sample.png",
//                           height: 300,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//             const SizedBox(height: 32),

//             // Pay Button with Fade + Scale animation
//             TweenAnimationBuilder<double>(
//               tween: Tween(begin: 0.8, end: 1.0),
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeOutBack,
//               builder: (context, scale, child) {
//                 return Opacity(
//                   opacity: scale,
//                   child: Transform.scale(
//                     scale: scale,
//                     child: SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                       child: ElevatedButton(
//                         onPressed: () async {
//                           await cartController.saveOrder(
//                             "QR",
//                             "QR${DateTime.now().millisecondsSinceEpoch}",
//                           );
//                           Get.snackbar(
//                             "Success",
//                             "Payment Successful",
//                             backgroundColor: Colors.green,
//                             colorText: Colors.white,
//                             snackPosition: SnackPosition.BOTTOM,
//                           );
//                           Get.to(()=> const ReceiptScreen(paymentMethod: "QR") );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: modernColor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: const Text(
//                           "I've Paid",
//                           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
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

class QRPaymentScreen extends StatelessWidget {
  const QRPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentController = Get.find<PaymentController>();
    final cartController = Get.find<CartController>();
    const primaryColor = Colors.orange;

    // Detect dark mode
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkMode ? Colors.grey[850] : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final backgroundColor = isDarkMode ? Colors.black87 : const Color(0xFFF5F5F5);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("QR Payment", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: primaryColor,
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title
            Text(
              "Scan QR Code to Pay",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // QR Code Card with Animation
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(
                          "assets/images/qr_code_sample.png",
                          height: MediaQuery.of(context).size.height * 0.4,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),

            // "I've Paid" Button with Animation
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.8, end: 1.0),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              builder: (context, scale, child) {
                return Opacity(
                  opacity: scale.clamp(0.0, 1.0),
                  child: Transform.scale(
                    scale: scale,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.check, color: Colors.white),
                          label: const Text(
                            "I've Paid",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            elevation: 6,
                            shadowColor: Colors.black54,
                          ),
                          onPressed: () async {
                            await cartController.saveOrder(
                              "QR",
                              "QR${DateTime.now().millisecondsSinceEpoch}",
                            );
                            Get.snackbar(
                              "Success",
                              "Payment Successful",
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            Get.to(() => const ReceiptScreen(paymentMethod: "QR"));
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 50), // Extra spacing at bottom
          ],
        ),
      ),
    );
  }
}
