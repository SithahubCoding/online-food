import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/admin_auth_controller.dart';

class AdminSendOtpScreen extends StatefulWidget {
  final String email;
  // AdminSendOtpScreen ត្រូវតែទទួល email ជា argument
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
    // ផ្ញើ OTP ភ្លាមៗនៅពេលចូលដល់ទំព័រនេះ
    if (widget.email.isNotEmpty) {
      controller.sendAdminOtp(widget.email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B1B),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("OTP Verification"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            const Icon(Icons.verified_user, color: Colors.redAccent, size: 80),
            const SizedBox(height: 20),
            const Text(
              "Two-Factor Verification",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              // Show better message if email is present
              widget.email.isNotEmpty
                  ? "Enter the 6-digit code sent to ${GetUtils.isEmail(widget.email) ? 'your email' : 'your phone number'} (${widget.email})."
                  : "Enter the 6-digit code sent to your registered account.",
              style: const TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            _buildOtpBox(),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                controller.verifyAdminOtp(widget.email, _otpController.text.trim());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text(
                "Verify Code",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => controller.sendAdminOtp(widget.email),
              child: const Text(
                "Resend Code",
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpBox() {
    return TextField(
      controller: _otpController,
      keyboardType: TextInputType.number,
      maxLength: 6,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white, letterSpacing: 4, fontSize: 20),
      decoration: InputDecoration(
        counterText: "",
        hintText: "______",
        hintStyle: const TextStyle(color: Colors.white30, letterSpacing: 8),
        filled: true,
        fillColor: Colors.grey[850],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),
      ),
    );
  }
}
