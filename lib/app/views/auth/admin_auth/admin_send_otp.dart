// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../controllers/admin_auth_controller.dart';

// class AdminSendOtpScreen extends StatefulWidget {
//   final String email;
//   // AdminSendOtpScreen ត្រូវតែទទួល email ជា argument
//   const AdminSendOtpScreen({super.key, required this.email});

//   @override
//   State<AdminSendOtpScreen> createState() => _AdminSendOtpScreenState();
// }

// class _AdminSendOtpScreenState extends State<AdminSendOtpScreen> {
//   final _otpController = TextEditingController();
//   final AdminAuthController controller = Get.find<AdminAuthController>();

//   @override
//   void initState() {
//     super.initState();
//     // ផ្ញើ OTP ភ្លាមៗនៅពេលចូលដល់ទំព័រនេះ
//     if (widget.email.isNotEmpty) {
//       controller.sendAdminOtp(widget.email);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF1B1B1B),
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: const Text("OTP Verification"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 30),
//             const Icon(Icons.verified_user, color: Colors.redAccent, size: 80),
//             const SizedBox(height: 20),
//             const Text(
//               "Two-Factor Verification",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               // Show better message if email is present
//               widget.email.isNotEmpty
//                   ? "Enter the 6-digit code sent to ${GetUtils.isEmail(widget.email) ? 'your email' : 'your phone number'} (${widget.email})."
//                   : "Enter the 6-digit code sent to your registered account.",
//               style: const TextStyle(color: Colors.white70),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 40),
//             _buildOtpBox(),
//             const SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () {
//                 controller.verifyAdminOtp(widget.email, _otpController.text.trim());
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.redAccent,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 minimumSize: const Size.fromHeight(50),
//               ),
//               child: const Text(
//                 "Verify Code",
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextButton(
//               onPressed: () => controller.sendAdminOtp(widget.email),
//               child: const Text(
//                 "Resend Code",
//                 style: TextStyle(color: Colors.white70),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildOtpBox() {
//     return TextField(
//       controller: _otpController,
//       keyboardType: TextInputType.number,
//       maxLength: 6,
//       textAlign: TextAlign.center,
//       style: const TextStyle(color: Colors.white, letterSpacing: 4, fontSize: 20),
//       decoration: InputDecoration(
//         counterText: "",
//         hintText: "______",
//         hintStyle: const TextStyle(color: Colors.white30, letterSpacing: 8),
//         filled: true,
//         fillColor: Colors.grey[850],
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Colors.redAccent),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Colors.white24),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Colors.redAccent, width: 2),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/admin_auth_controller.dart';

class AdminSendOtpScreen extends StatefulWidget {
  final String email;
  const AdminSendOtpScreen({super.key, required this.email});

  @override
  State<AdminSendOtpScreen> createState() => _AdminSendOtpScreenState();
}

class _AdminSendOtpScreenState extends State<AdminSendOtpScreen> {
  final _otpController = TextEditingController();
  final AdminAuthController controller = Get.find<AdminAuthController>();

  @override
  void initState() {
    super.initState();
    if (widget.email.isNotEmpty) {
      controller.sendAdminOtp(widget.email);
    }
  }

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
        title: const Text("OTP Verification", style: TextStyle(color: Colors.black)),
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
                        child: Icon(Icons.verified_user, size: 70, color: primaryColor),
                      ),
                      const SizedBox(height: 24),

                      const Text(
                        "Two-Factor Verification",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF142338)),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.email.isNotEmpty
                            ? "Enter the 6-digit code sent to your email (${widget.email})."
                            : "Enter the 6-digit code sent to your registered account.",
                        style: TextStyle(color: Colors.grey[600], fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),

                      _buildOtpField(primaryColor),
                      const SizedBox(height: 30),

                      // Verify Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => controller.verifyAdminOtp(widget.email, _otpController.text.trim()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 3,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          child: const Text(
                            "Verify Code",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Resend OTP
                      TextButton(
                        onPressed: () => controller.sendAdminOtp(widget.email),
                        child: Text(
                          "Resend Code",
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

  Widget _buildOtpField(Color primaryColor) {
    return TextField(
      controller: _otpController,
      keyboardType: TextInputType.number,
      maxLength: 6,
      textAlign: TextAlign.center,
      style: TextStyle(color: primaryColor, letterSpacing: 4, fontSize: 20),
      decoration: InputDecoration(
        counterText: "",
        hintText: "______",
        hintStyle: TextStyle(color: Colors.grey[400], letterSpacing: 8),
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
      ),
    );
  }
}
