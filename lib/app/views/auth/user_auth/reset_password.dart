// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'login_screen.dart';

// class ResetPasswordScreen extends StatelessWidget {
//   const ResetPasswordScreen({super.key});
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
//                 Icon(Icons.lock_reset, size: 100, color: Colors.blueAccent),
//                 SizedBox(height: 20),
//                 Text(
//                   'Reset Password',
//                   style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   'Enter your new password below to reset your account password.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//                 ),
//                 SizedBox(height: 30),

//                 // New Password
//                 TextField(
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     labelText: 'New Password',
//                     prefixIcon: Icon(Icons.lock),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     filled: true,
//                     fillColor: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 20),

//                 // Confirm Password
//                 TextField(
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     labelText: 'Confirm Password',
//                     prefixIcon: Icon(Icons.lock),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     filled: true,
//                     fillColor: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 30),

//                 // Reset Password Button: UPDATED NAVIGATION
//                 InkWell(
//                   onTap: () {
//                     // 1. TODO: Implement actual password reset API logic here.

//                     // 2. On successful reset, navigate to the LoginScreen.
//                     // Using Get.offAll() clears the previous screens (SendOTP, VerifyOTP, ResetPassword)
//                     // from the navigation stack, preventing the user from going back to them.
//                     Get.offAll(() => LoginScreen());

//                     // Optional: Show a success message (a Snackbar or Dialog)
//                     Get.snackbar(
//                       "Success", 
//                       "Your password has been reset successfully. Please log in with your new password.",
//                       snackPosition: SnackPosition.BOTTOM,
//                       backgroundColor: Colors.green,
//                       colorText: Colors.white,
//                     );
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
//                         'Reset Password',
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

//                 // Back to Login (This is still useful if the user decides to cancel the reset process)
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("Remember your password?"),
//                     TextButton(
//                       onPressed: () {
//                         Get.to(() => LoginScreen());
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
import 'login_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

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
                child: Icon(Icons.lock_reset, size: 70, color: primaryColor),
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                'Reset Password',
                style: TextStyle(
                    fontSize: 26, fontWeight: FontWeight.bold, color: primaryColor),
              ),
              const SizedBox(height: 10),
              Text(
                'Enter your new password below to reset your account password.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.grey[600]),
              ),
              const SizedBox(height: 30),

              // New Password
              _buildTextField('New Password', Icons.lock_outline, obscureText: true),
              const SizedBox(height: 20),

              // Confirm Password
              _buildTextField('Confirm Password', Icons.lock_outline, obscureText: true),
              const SizedBox(height: 30),

              // Reset Password Button
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement actual password reset API logic

                  // Navigate to login
                  Get.offAll(() => const LoginScreen());

                  // Success snackbar
                  Get.snackbar(
                    "Success",
                    "Your password has been reset successfully. Please log in with your new password.",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
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
                    'Reset Password',
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
                    onPressed: () => Get.to(() => const LoginScreen()),
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
  Widget _buildTextField(String label, IconData icon, {bool obscureText = false}) {
    return TextField(
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
          borderSide: const BorderSide(color: Color(0xFF142338), width: 1.3),
        ),
      ),
    );
  }
}
