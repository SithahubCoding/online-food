// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/cart_controller.dart';
// import '../controllers/payment_controller.dart';
// import '../views/success_screen.dart';
// class ReceiptScreen extends StatelessWidget {
//   final String paymentMethod;
//   const ReceiptScreen({super.key, required this.paymentMethod});

//   @override
//   Widget build(BuildContext context) {
//     final cartController = Get.find<CartController>();
//     final paymentController = Get.find<PaymentController>();
//     const modernColor = Color(0xFFFFC107);

//     final subtotal = paymentController.subtotal.value;
//     final deliveryFee = paymentController.deliveryFee.value;
//     final total = subtotal + deliveryFee;

//     final location = paymentController.deliveryLocation.value;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Receipt"),
//         backgroundColor: modernColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header
//               const Center(
//                 child: Text(
//                   "Order Receipt",
//                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Delivery Location
//               if (location != null)
//                 Card(
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                   elevation: 2,
//                   child: Padding(
//                     padding: const EdgeInsets.all(12),
//                     child: Row(
//                       children: [
//                         const Icon(Icons.location_on, color: Colors.red),
//                         const SizedBox(width: 8),
//                         Expanded(
//                           child: Text(
//                             "Delivery Location:\nLat: ${location.latitude.toStringAsFixed(4)}, Lng: ${location.longitude.toStringAsFixed(4)}",
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               const SizedBox(height: 16),

//               // Order Items
//               Card(
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 elevation: 2,
//                 child: Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text("Items", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//                       const Divider(thickness: 1, height: 12),
//                       ...List.generate(cartController.items.length, (index) {
//                         final item = cartController.items[index];
//                         final quantity = cartController.quantities[index];
//                         final price = item.price * quantity;
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 4),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(child: Text("${item.name} x $quantity")),
//                               Text("\$${price.toStringAsFixed(2)}"),
//                             ],
//                           ),
//                         );
//                       }),
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
//                       const SizedBox(height: 8),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text("Payment Method", style: TextStyle(fontWeight: FontWeight.bold)),
//                           Text(paymentMethod.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),

//               // Done Button
//               Center(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: modernColor,
//                     foregroundColor: Colors.black,
//                     padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                   ),
//                   onPressed: () {
//                     Get.to(()=>const SuccessScreen(
//                       paymentMethod:"",
//                       transactionId:"",
//                       amount:0,
//                     )); 
//                   },
//                   child: const Text("Done", style: TextStyle(fontWeight: FontWeight.bold)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
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
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/cart_controller.dart';
// import '../controllers/payment_controller.dart';
// import '../views/success_screen.dart';

// class ReceiptScreen extends StatelessWidget {
//   final String paymentMethod;
//   const ReceiptScreen({super.key, required this.paymentMethod});

//   @override
//   Widget build(BuildContext context) {
//     final cartController = Get.find<CartController>();
//     final paymentController = Get.find<PaymentController>();
//     const primaryColor = Colors.orange;

//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     final backgroundColor = isDarkMode ? Colors.black87 : Colors.white;
//     final cardColor = isDarkMode ? Colors.grey[850] : Colors.white;
//     final textColor = isDarkMode ? Colors.white : Colors.black87;

//     final subtotal = paymentController.subtotal.value;
//     final deliveryFee = paymentController.deliveryFee.value;
//     final total = subtotal + deliveryFee;
//     final location = paymentController.deliveryLocation.value;

//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         title: const Text("Receipt", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),),
//         backgroundColor: primaryColor,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Center(
//               child: Text("Order Receipt", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//             ),
//             const SizedBox(height: 16),

//             // Delivery Location
//             if (location != null)
//               Card(
//                 color: cardColor,
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
//                           "Delivery Location:\nLat: ${location.latitude.toStringAsFixed(4)}, "
//                           "Lng: ${location.longitude.toStringAsFixed(4)}",
//                           style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             const SizedBox(height: 16),

//             // Items
//             Card(
//               color: cardColor,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               elevation: 2,
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Items", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textColor)),
//                     const Divider(thickness: 1, height: 12),
//                     ...List.generate(cartController.items.length, (index) {
//                       final item = cartController.items[index];
//                       final quantity = cartController.quantities[index];
//                       final price = item.price * quantity;
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 4),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(child: Text("${item.name} x $quantity", style: TextStyle(color: textColor))),
//                             Text("\$${price.toStringAsFixed(2)}", style: TextStyle(color: textColor)),
//                           ],
//                         ),
//                       );
//                     }),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),

//             // Price Summary
//             Card(
//               color: cardColor,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               elevation: 2,
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Column(
//                   children: [
//                     _priceRow("Subtotal", subtotal, color: textColor),
//                     _priceRow("Delivery Fee", deliveryFee, color: textColor),
//                     const Divider(thickness: 1, height: 20),
//                     _priceRow("Total", total, isBold: true, color: textColor),
//                     const SizedBox(height: 8),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Payment Method", style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
//                         Text(paymentMethod.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),

//             // Done Button
//             Center(
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: primaryColor,
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                 ),
//                 onPressed: () {
//                   Get.to(() => const SuccessScreen(paymentMethod: "", transactionId: "", amount: 0));
//                 },
//                 child: const Text("Done", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _priceRow(String label, double value, {bool isBold = false, Color color = Colors.black87}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.w500, fontSize: 16, color: color)),
//           Text("\$${value.toStringAsFixed(2)}", style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.w500, fontSize: 16, color: color)),
//         ],
//       ),
//     );
//   }
// }

// receipt_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../controllers/payment_controller.dart';
import 'success_screen.dart';

class ReceiptScreen extends StatelessWidget {
  final String paymentMethod;
  const ReceiptScreen({super.key, required this.paymentMethod});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final paymentController = Get.find<PaymentController>();
    const primaryColor = Colors.orange;

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black87 : Colors.white;
    final cardColor = isDarkMode ? Colors.grey[850] : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    final subtotal = paymentController.subtotal.value;
    final deliveryFee = paymentController.deliveryFee.value;
    final total = subtotal + deliveryFee;
    final location = paymentController.deliveryLocation.value;

    // Generate transactionId (could come from server)
    final transactionId = "TX${DateTime.now().millisecondsSinceEpoch}";

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Receipt",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text("Order Receipt",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),

            // Delivery Location
            if (location != null)
              Card(
                color: cardColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Delivery Location:\nLat: ${location.latitude.toStringAsFixed(4)}, "
                          "Lng: ${location.longitude.toStringAsFixed(4)}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: textColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 16),

            // Items
            Card(
              color: cardColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Items",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: textColor)),
                    const Divider(thickness: 1, height: 12),
                    ...List.generate(cartController.items.length, (index) {
                      final item = cartController.items[index];
                      final quantity = cartController.quantities[index];
                      final price = item.price * quantity;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text("${item.name} x $quantity",
                                    style: TextStyle(color: textColor))),
                            Text("\$${price.toStringAsFixed(2)}",
                                style: TextStyle(color: textColor)),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Price Summary
            Card(
              color: cardColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    _priceRow("Subtotal", subtotal, color: textColor),
                    _priceRow("Delivery Fee", deliveryFee, color: textColor),
                    const Divider(thickness: 1, height: 20),
                    _priceRow("Total", total, isBold: true, color: textColor),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Payment Method",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: textColor)),
                        Text(paymentMethod.toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: textColor)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Done Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {
                  // Navigate to SuccessScreen with actual data
                  Get.to(() => SuccessScreen(
                        paymentMethod: paymentMethod,
                        transactionId: transactionId,
                        amount: total,
                      ));
                },
                child: const Text("Done",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceRow(String label, double value,
      {bool isBold = false, Color color = Colors.black87}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
                  fontSize: 16,
                  color: color)),
          Text("\$${value.toStringAsFixed(2)}",
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
                  fontSize: 16,
                  color: color)),
        ],
      ),
    );
  }
}

