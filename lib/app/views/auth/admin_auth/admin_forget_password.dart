// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../controllers/admin_auth_controller.dart';

// class AdminForgetPasswordScreen extends StatelessWidget {
//   AdminForgetPasswordScreen({super.key});
//   final AdminAuthController controller = Get.put(AdminAuthController());
//   final emailCtrl = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Forgot Password")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: "Admin Email")),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () => controller.sendResetEmail(emailCtrl.text),
//               child: const Text("Send Reset Link"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/admin_auth_controller.dart';
import 'admin_login_screen.dart';
import 'admin_send_otp.dart';

class AdminForgetPasswordScreen extends StatelessWidget {
  AdminForgetPasswordScreen({super.key});
  final AdminAuthController controller = Get.find();
  final TextEditingController emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF142338);
    final accentColor = const Color(0xFFFFC107);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
          child: Obx(
            () => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 🟡 Logo / Icon
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: accentColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(Icons.lock_reset,
                            size: 70, color: primaryColor),
                      ),
                      const SizedBox(height: 24),

                      const Text(
                        'Forgot Password',
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF142338)),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enter your admin email to receive reset instructions',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[600], fontSize: 15),
                      ),
                      const SizedBox(height: 40),

                      // Email Field
                      TextField(
                        controller: emailCtrl,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined, color: Colors.grey[700]),
                          labelText: 'Admin Email',
                          labelStyle: TextStyle(color: Colors.grey[600]),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(color: Color(0xFF142338), width: 1.3),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Send Reset Link Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.sendResetEmail(emailCtrl.text.trim());
                            Get.to(() => AdminSendOtpScreen(email: emailCtrl.text.trim()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 3,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                          ),
                          child: const Text(
                            'Send Reset Link',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // 🔹 Already have an account? Login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? "),
                          TextButton(
                            onPressed: () => Get.to(() => const AdminLoginScreen()),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
