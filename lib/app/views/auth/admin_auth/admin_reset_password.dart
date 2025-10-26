import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/admin_auth_controller.dart';

class AdminResetPasswordScreen extends StatelessWidget {
  AdminResetPasswordScreen({super.key});
  final AdminAuthController controller = Get.put(AdminAuthController());
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: passCtrl, decoration: const InputDecoration(labelText: "New Password"), obscureText: true),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => controller.resetPassword(passCtrl.text),
              child: const Text("Confirm"),
            ),
          ],
        ),
      ),
    );
  }
}
