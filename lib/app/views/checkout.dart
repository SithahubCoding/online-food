import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'payment/qr_payment_screen.dart';
import 'payment/card_payment_screen.dart';
import 'payment/cod_payment_screen.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const modernColor = Color(0xFFFFC107);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: modernColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const ListTile(
              leading: Icon(Icons.location_on),
              title: Text("Delivery Address"),
              subtitle: Text("Phnom Penh, Cambodia"),
            ),
            const Divider(thickness: 1),
            const ListTile(
              title: Text("Total Amount"),
              trailing: Text(
                "\$40.00",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Choose Payment Method",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),

            // ✅ Payment Options
            PaymentOption(
              title: "Pay by QR Code (Score / ABA / Wing)",
              icon: Icons.qr_code_2,
              onTap: () => Get.to(() => const QRPaymentScreen()),
            ),
            PaymentOption(
              title: "Pay by Visa / MasterCard",
              icon: Icons.credit_card,
              onTap: () => Get.to(() => const CardPaymentScreen()),
            ),
            PaymentOption(
              title: "Cash on Delivery (COD)",
              icon: Icons.money,
              onTap: () => Get.to(() => const CODPaymentScreen()),
            ),
          ],
        ),
      ),
    );
  }
}

// 🧩 Reusable Payment Option Widget
class PaymentOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const PaymentOption({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
