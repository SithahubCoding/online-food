// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../controllers/user_auth_controller.dart';
// import 'login_screen.dart';

// class ForgetPasswordScreen extends StatelessWidget {
//   ForgetPasswordScreen({super.key});
//   final AuthController authController = Get.find<AuthController>();
//   final TextEditingController emailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Icon(Icons.lock_outline, size: 100, color: Colors.blueAccent),
//                 SizedBox(height: 20),
//                 Text(
//                   'Forgot Password',
//                   style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Enter your email to receive a verification code (OTP).',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//                 ),
//                 SizedBox(height: 30),

//                 // Email Input
//                 TextField(
//                   controller: emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     prefixIcon: Icon(Icons.email),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     filled: true,
//                     fillColor: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 30),

//                 // Send OTP Button
//                 // ចុច Send Reset Link
//                 InkWell(
//                   onTap: () {
//                     authController.resetPassword(emailController.text.trim());
//                   },
//                   child: Container(
//                     width: double.infinity,
//                     padding: EdgeInsets.symmetric(vertical: 16),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       gradient: LinearGradient(
//                         colors: [Colors.orange, Colors.deepOrangeAccent],
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         'Send Reset Link',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: 20),

//                 // Back to Login
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("Remember your password?"),
//                     TextButton(
//                       onPressed: () {
//                         Get.off(() => LoginScreen());
//                       },
//                       child: Text(
//                         "Login",
//                         style: TextStyle(color: Colors.deepOrangeAccent),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/user_auth_controller.dart';
import 'login_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF142338);
    final accentColor = const Color(0xFFFFC107);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: accentColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4)),
                  ],
                ),
                child: Icon(Icons.lock_outline, size: 70, color: primaryColor),
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                'Forgot Password',
                style: TextStyle(
                    fontSize: 26, fontWeight: FontWeight.bold, color: primaryColor),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your email to receive a verification code (OTP).',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.grey[600]),
              ),
              const SizedBox(height: 30),

              // Email Input
              _buildTextField(emailController, 'Email Address', Icons.email_outlined),

              const SizedBox(height: 30),

              // Send Reset Link Button
              ElevatedButton(
                onPressed: () {
                  authController.resetPassword(emailController.text.trim());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Center(
                  child: Text(
                    'Send Reset Link',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Back to Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Remember your password? "),
                  TextButton(
                    onPressed: () => Get.off(() => const LoginScreen()),
                    child: Text(
                      "Login",
                      style:
                          TextStyle(color: accentColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // TextField builder
  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey[700]),
        labelText: label,
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
    );
  }
}
