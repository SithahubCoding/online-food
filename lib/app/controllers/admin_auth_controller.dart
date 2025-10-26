import 'dart:math';
import 'package:flutter/material.dart'; // Import for Get.snackbar colors and context
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../views/dashboard/dashboard_screen.dart';
import '../views/auth/admin_auth/admin_send_otp.dart';

class AdminAuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  var isLoading = false.obs;
  // RxString សម្រាប់រក្សាទុក OTP ដែលបានបង្កើត (Simulated)
  final RxString _otpCode = ''.obs; 

  // ✅ SIGN UP ADMIN (Admin Creation Flow)
  Future<void> createAdmin(String name, String email, String password) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please fill in all fields.");
      return;
    }
    
    try {
      isLoading.value = true;
      // 1. Firebase Auth: Create the user
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      
      // 2. Firestore: Save user data with 'admin' role
      await _db.collection('users').doc(cred.user!.uid).set({
        'name': name,
        'email': email,
        'role': 'admin', // 👈 Key for authorization
        'createdAt': DateTime.now(),
      });

      Get.snackbar("Success", "Admin account created successfully!",
          backgroundColor: Colors.green, colorText: Colors.white);
      
      // Navigate to login screen after successful creation
      Get.offAllNamed('/admin_login'); 

    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else {
        message = e.message ?? 'An unknown error occurred during sign up.';
      }
      Get.snackbar("Sign Up Failed", message, backgroundColor: Colors.red, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Could not create admin: $e", backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // ✅ LOGIN ADMIN (Authentication + Authorization + 2FA Trigger Flow)
  Future<void> loginAdmin(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please enter email and password.");
      return;
    }

    try {
      isLoading.value = true;
      // 1. Authentication (Firebase Auth)
      final userCred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      
      // 2. Authorization (Firestore Role Check)
      final doc = await _db.collection('users').doc(userCred.user!.uid).get();

      if (doc.exists && doc['role'] == 'admin') {
        // 3. 2FA Trigger: Admin is authenticated and authorized, now start 2FA
        sendAdminOtp(email);
        
        // Navigate to the OTP verification screen
        Get.off(() => AdminSendOtpScreen(email: email)); 
        
      } else {
        // If the user exists in Auth but not in Firestore or role is wrong
        await _auth.signOut(); 
        Get.snackbar("Access Denied", "Your account does not have administrator privileges.", backgroundColor: Colors.amber, colorText: Colors.black);
      }
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        message = 'Invalid email or password.';
      } else {
        message = e.message ?? 'Login failed.';
      }
      Get.snackbar("Login Failed", message, backgroundColor: Colors.red, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "An unexpected error occurred: $e", backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // ✅ SEND OTP (Simulated 2FA Code Generation)
  // void sendAdminOtp(String email) {
  //   // Generate a 6-digit random number (100000 to 999999)
  //   final otp = (Random().nextInt(900000) + 100000).toString();
  //   _otpCode.value = otp;
    
  //   // In a real application, you would send this OTP via Email Service (e.g., SendGrid/Firebase Extensions) or SMS.
  //   // For development, we print it to the console.
  //   print("====================================");
  //   print("DEBUG OTP (for $email): $otp");
  //   print("====================================");

  //   Get.snackbar("OTP Sent", "Verification code sent to $email. Check your console/email.",
  //       backgroundColor: Colors.blueGrey, colorText: Colors.white);
  // }
  void sendAdminOtp(String email) {
  final otp = (Random().nextInt(900000) + 100000).toString();
  _otpCode.value = otp;

  // ✅ Show OTP as Snackbar for debugging instead of print
  Get.snackbar(
    "DEBUG OTP",
    "OTP for $email: $otp",
    backgroundColor: Colors.pinkAccent,
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    duration: const Duration(seconds: 15),
  );

  // Optional: Show user-friendly OTP sent message
  Get.snackbar(
    "OTP Sent",
    "Verification code sent to $email. Please enter the code.",
    backgroundColor: Colors.blueGrey,
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    duration: const Duration(seconds: 5),
  );
}


  // ✅ VERIFY OTP (Final Check for 2FA)
  void verifyAdminOtp(String email, String enteredOtp) {
    if (enteredOtp == _otpCode.value) {
      // Login is complete: Auth successful + Role check successful + 2FA successful
      Get.snackbar("Success", "OTP Verified. Access Granted.", backgroundColor: Colors.green, colorText: Colors.white);
      Get.offAll(() => const DashboardScreen());
    } else {
      Get.snackbar("Invalid OTP", "The entered code is incorrect. Please try again.", backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
  
  // វីធីផ្សេងទៀត (Forgot Password និង Reset Password)
  Future<void> sendResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar("Success", "Password reset email sent to $email!", backgroundColor: Colors.green, colorText: Colors.white);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "Could not send reset email.", backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> resetPassword(String newPassword) async {
    try {
      await _auth.currentUser?.updatePassword(newPassword);
      Get.snackbar("Success", "Password reset successfully! Please log in again.", backgroundColor: Colors.green, colorText: Colors.white);
      await _auth.signOut();
      Get.offAllNamed('/admin_login');
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "Could not reset password.", backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
