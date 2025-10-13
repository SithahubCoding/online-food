import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './login_screen.dart';
// import './send_opt.dart'; // Removed as it's not used
import './send_opt.dart'; // Assuming this is the next step

class ForgetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Icon(Icons.lock_outline, size: 100, color: Colors.blueAccent),
                SizedBox(height: 20),
                Text(
                  'Forgot Password',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Enter your email to receive a verification code (OTP).', // Added descriptive text
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                SizedBox(height: 30),

                // Email Input
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 30),

                // Send OTP Button (Text updated for clarity in the OTP flow)
                InkWell(
                  onTap: () {
                    // 1. TODO: Implement API call to request OTP.
                    
                    // 2. Navigate to the OTP verification screen.
                    Get.to(() => VerifyOtpScreen());
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [Colors.orange, Colors.deepOrangeAccent],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        // Changed text to better reflect the action and flow
                        'Send OTP', 
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Back to Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Remember your password?"),
                    TextButton(
                      onPressed: () {
                        // Use Get.off() or Get.offAll() if this is the start of a flow
                        Get.off(() => LoginScreen());
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.deepOrangeAccent),
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