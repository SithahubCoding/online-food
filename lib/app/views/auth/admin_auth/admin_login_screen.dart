import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/admin_auth_controller.dart';
import 'admin_signup_screen.dart';
import 'admin_forget_password.dart';

class AdminLoginScreen extends StatelessWidget {
  AdminLoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // Get.put ensures the controller is initialized here if it wasn't elsewhere
  final AdminAuthController authController = Get.put(AdminAuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Login")),
      body: Obx(
        () => authController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: "Email"),
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: "Password"),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        authController.loginAdmin(
                            emailController.text.trim(),
                            passwordController.text.trim());
                      },
                      child: const Text("Login"),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => AdminForgetPasswordScreen());
                      },
                      child: const Text("Forgot Password?"),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => AdminSignUpScreen());
                      },
                      child: const Text("Create Admin"),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
