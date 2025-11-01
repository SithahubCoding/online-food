// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'reset_password.dart'; 

// class VerifyOtpScreen extends StatelessWidget {
//   const VerifyOtpScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         // Optional: Add a back button
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         iconTheme: IconThemeData(color: Colors.black),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Burger Image/Icon (as seen in your design)
//                 Image.asset(
//                   'assets/images/logo.png',
//                   height: 120,
//                   width: 120,
//                   errorBuilder: (context, error, stackTrace) {
                    
//                     return const Icon(
//                       Icons.fastfood,
//                       size: 120,
//                       color: Colors.orange,
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   'Foodies',
//                   style: TextStyle(fontSize: 16, color: Colors.grey),
//                 ),
//                 const SizedBox(height: 50),

//                 const Text(
//                   'Enter the verification code',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 16, color: Colors.grey),
//                 ),
//                 const SizedBox(height: 20),

//                 // OTP Input (mimicking 4 separate boxes)
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(6, (index) {
//                     return Container(
//                       width: 48,
//                       height: 48,
//                       margin: const EdgeInsets.symmetric(horizontal: 6),
//                       child: TextField(
//                         keyboardType: TextInputType.number,
//                         textAlign: TextAlign.center,
//                         maxLength: 1, // Only allow one digit per box
//                         style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                         decoration: InputDecoration(
//                           counterText: "", // Hides the character counter
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide.none,
//                           ),
//                           filled: true,
//                           fillColor: Colors.white,
//                         ),
//                         onChanged: (value) {
//                           // Auto-focus to the next box
//                           if (value.length == 1 && index < 3) {
//                             FocusScope.of(context).nextFocus();
//                           }
//                           // Handle input logic here...
//                         },
//                       ),
//                     );
//                   }),
//                 ),
//                 const SizedBox(height: 40),

//                 // Verify Now Button
//                 InkWell(
//                   onTap: () {
//                     // On successful verification, navigate to ResetPasswordScreen
//                     Get.to(() => ResetPasswordScreen());
//                   },
//                   child: Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       color: Colors.amber[800], // Using a solid color similar to the image's yellow/gold
//                     ),
//                     child: const Center(
//                       child: Text(
//                         'Verify Now',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
                
//                 // Resend OTP text/button (optional but good practice)
//                 TextButton(
//                   onPressed: () {
//                     // Logic to resend OTP
//                   },
//                   child: const Text(
//                     "Didn't receive code? Resend",
//                     style: TextStyle(color: Colors.deepOrangeAccent),
//                   ),
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
import 'reset_password.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key});

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // 🟡 Logo in Circle
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
                  child: const Icon(Icons.lock_rounded, size: 70, color: Color(0xFF142338)),
                ),
                const SizedBox(height: 24),

                const Text(
                  'Verify OTP',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF142338)),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter the verification code sent to your email',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600], fontSize: 15),
                ),
                const SizedBox(height: 40),

                // 🟢 OTP Input Boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (index) {
                    return Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          counterText: "",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: primaryColor, width: 1.3),
                          ),
                          // soft shadow
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        onChanged: (value) {
                          if (value.length == 1 && index < 5) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 40),

                // 🔵 Verify Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => const ResetPasswordScreen()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 3,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text(
                      'Verify Now',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 🔹 Resend OTP
                TextButton(
                  onPressed: () {
                    // TODO: Implement resend OTP logic
                  },
                  child: Text(
                    "Didn't receive code? Resend",
                    style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
