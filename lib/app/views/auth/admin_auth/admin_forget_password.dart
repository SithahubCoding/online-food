import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/admin_auth_controller.dart';

class AdminForgetPasswordScreen extends StatelessWidget {
  AdminForgetPasswordScreen({super.key});
  final AdminAuthController controller = Get.put(AdminAuthController());
  final emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forgot Password")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: "Admin Email")),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => controller.sendResetEmail(emailCtrl.text),
              child: const Text("Send Reset Link"),
            ),
          ],
        ),
      ),
    );
  }
}
