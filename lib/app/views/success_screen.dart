// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SuccessScreen extends StatelessWidget {
//   final String paymentMethod;
//   final String transactionId;
//   final double amount;

//   const SuccessScreen({
//     super.key,
//     required this.paymentMethod,
//     required this.transactionId,
//     required this.amount,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Payment Successful"),
//         backgroundColor: const Color(0xFFFFC107),
//         leading: IconButton(
//           icon: const Icon(Icons.home),
//           onPressed: () => Get.offAllNamed('/HomeScreen'), // Navigate back to Home
//         ),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(
//                 Icons.check_circle_outline,
//                 color: Colors.green,
//                 size: 120,
//               ),
//               const SizedBox(height: 24),
//               Text(
//                 "Payment Completed!",
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.green.shade700,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 "Payment Method: $paymentMethod",
//                 style: const TextStyle(fontSize: 18),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 "Transaction ID: $transactionId",
//                 style: const TextStyle(fontSize: 18),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 "Amount Paid: \$${amount.toStringAsFixed(2)}",
//                 style: const TextStyle(fontSize: 18),
//               ),
//               const SizedBox(height: 32),
//               ElevatedButton(
//                 onPressed: () => Get.offAllNamed('/HomeScreen'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFFFFC107),
//                   minimumSize: const Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   "Back to Home",
//                   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SuccessScreen extends StatelessWidget {
//   final String paymentMethod;
//   final String transactionId;
//   final double amount;

//   const SuccessScreen({
//     super.key,
//     required this.paymentMethod,
//     required this.transactionId,
//     required this.amount,
//   });

//   @override
//   Widget build(BuildContext context) {
//     const primaryColor = Colors.orange;
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     final backgroundColor = isDarkMode ? Colors.black87 : Colors.white;
//     final textColor = isDarkMode ? Colors.white : Colors.black87;

//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         title: const Text("Payment Successful", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),),
//         backgroundColor: primaryColor,
//         leading: IconButton(
//           icon: const Icon(Icons.home, color: Colors.white,),
//           onPressed: () => Get.offAllNamed('/HomeScreen'), // Navigate back to Home
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.check_circle_outline,
//                 color: Colors.green.shade600,
//                 size: 120,
//               ),
//               const SizedBox(height: 24),
//               Text(
//                 "Payment Completed!",
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.green.shade700,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               _infoRow("Payment Method:", paymentMethod, textColor),
//               const SizedBox(height: 8),
//               _infoRow("Transaction ID:", transactionId, textColor),
//               const SizedBox(height: 8),
//               _infoRow("Amount Paid:", "\$${amount.toStringAsFixed(2)}", textColor),
//               const SizedBox(height: 32),
//               ElevatedButton(
//                 onPressed: () => Get.offAllNamed('/HomeScreen'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: primaryColor,
//                   foregroundColor: Colors.black,
//                   minimumSize: const Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 ),
//                 child: const Text(
//                   "Back to Home",
//                   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _infoRow(String label, String value, Color color) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color)),
//         Text(value, style: TextStyle(fontSize: 16, color: color)),
//       ],
//     );
//   }
// }
// success_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessScreen extends StatelessWidget {
  final String paymentMethod;
  final String transactionId;
  final double amount;

  const SuccessScreen({
    super.key,
    required this.paymentMethod,
    required this.transactionId,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.orange;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black87 : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Payment Successful",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
        ),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.home,
            color: Colors.white,
          ),
          onPressed: () => Get.offAllNamed('/HomeScreen'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Colors.green.shade600,
                size: 120,
              ),
              const SizedBox(height: 24),
              Text(
                "Payment Completed!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
              const SizedBox(height: 16),
              _infoRow("Payment Method:", paymentMethod, textColor),
              const SizedBox(height: 8),
              _infoRow("Transaction ID:", transactionId, textColor),
              const SizedBox(height: 8),
              _infoRow("Amount Paid:", "\$${amount.toStringAsFixed(2)}", textColor),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Get.offAllNamed('/HomeScreen'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  "Back to Home",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color)),
        Text(value, style: TextStyle(fontSize: 16, color: color)),
      ],
    );
  }
}
