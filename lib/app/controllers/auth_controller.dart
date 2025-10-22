// lib/controllers/auth_controller.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/auth/login_screen.dart';
import '../views/home/home_screen.dart';
import '../views/auth/send_opt.dart';
class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  void signUp(String email, String password) async {
    try {
      // Show loading
      Get.dialog(
        Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      // Firebase sign up
      await auth.createUserWithEmailAndPassword(email: email, password: password);

      // Close loading
      Get.back();

      // Success message
      Get.snackbar(
        "Success",
        "Sign Up Successful",
        snackPosition: SnackPosition.BOTTOM,
      );

      Get.off(() => LoginScreen());
    } catch (e) {
      Get.back();
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  void login(String email, String password) async {
    try {
      Get.dialog(Center(child: CircularProgressIndicator()),
          barrierDismissible: false);
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.back();
      Get.snackbar("Welcome", "Login Successful",
          snackPosition: SnackPosition.BOTTOM);
      Get.offAll(() => HomeScreen());
    } catch (e) {
      Get.back();
      Get.snackbar("Login Failed", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }
  void resetPassword(String email) async {
    if (email.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter your email",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      Get.dialog(
        Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      await auth.sendPasswordResetEmail(email: email);

      Get.back();
      Get.snackbar(
        "Success",
        "Password reset email sent to $email",
        snackPosition: SnackPosition.BOTTOM,
      );

      // Navigate back to login screen
      Get.off(() =>VerifyOtpScreen());
    } catch (e) {
      Get.back();
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signOut() async {
    await auth.signOut();
  }
}