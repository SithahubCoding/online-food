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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Successful"),
        backgroundColor: const Color(0xFFFFC107),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => Get.offAllNamed('/HomeScreen'), // Navigate back to Home
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
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
              Text(
                "Payment Method: $paymentMethod",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                "Transaction ID: $transactionId",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                "Amount Paid: \$${amount.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Get.offAllNamed('/HomeScreen'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFC107),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Back to Home",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
