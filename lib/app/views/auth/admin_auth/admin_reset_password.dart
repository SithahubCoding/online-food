// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../controllers/admin_auth_controller.dart';

// class AdminResetPasswordScreen extends StatelessWidget {
//   AdminResetPasswordScreen({super.key});
//   final AdminAuthController controller = Get.put(AdminAuthController());
//   final passCtrl = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Reset Password")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(controller: passCtrl, decoration: const InputDecoration(labelText: "New Password"), obscureText: true),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () => controller.resetPassword(passCtrl.text),
//               child: const Text("Confirm"),
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

class AdminResetPasswordScreen extends StatefulWidget {
  const AdminResetPasswordScreen({super.key});

  @override
  State<AdminResetPasswordScreen> createState() => _AdminResetPasswordScreenState();
}

class _AdminResetPasswordScreenState extends State<AdminResetPasswordScreen> {
  final AdminAuthController controller = Get.find();
  final TextEditingController passCtrl = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF142338);
    final accentColor = const Color(0xFFFFC107);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
          child: Obx(
            () => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 🟡 Icon
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
                        child: Icon(Icons.lock_reset, size: 70, color: primaryColor),
                      ),
                      const SizedBox(height: 24),

                      const Text(
                        'Reset Password',
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF142338)),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enter your new password',
                        style: TextStyle(color: Colors.grey[600], fontSize: 15),
                      ),
                      const SizedBox(height: 40),

                      // Password Field
                      _buildTextField(
                        controller: passCtrl,
                        label: 'New Password',
                        icon: Icons.lock_outline,
                        obscureText: !showPassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            showPassword ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey[700],
                          ),
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Confirm Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => controller.resetPassword(passCtrl.text.trim()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 3,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                          ),
                          child: const Text(
                            'Confirm',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey[700]),
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[600]),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: const Color(0xFF142338), width: 1.3),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
