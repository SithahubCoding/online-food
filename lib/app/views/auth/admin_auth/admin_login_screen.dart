// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../controllers/admin_auth_controller.dart';
// import 'admin_signup_screen.dart';
// import 'admin_forget_password.dart';

// class AdminLoginScreen extends StatelessWidget {
//   AdminLoginScreen({super.key});

//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   // Get.put ensures the controller is initialized here if it wasn't elsewhere
//   final AdminAuthController authController = Get.put(AdminAuthController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Admin Login")),
//       body: Obx(
//         () => authController.isLoading.value
//             ? const Center(child: CircularProgressIndicator())
//             : Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     TextField(
//                       controller: emailController,
//                       decoration: const InputDecoration(labelText: "Email"),
//                     ),
//                     TextField(
//                       controller: passwordController,
//                       obscureText: true,
//                       decoration: const InputDecoration(labelText: "Password"),
//                     ),
//                     const SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: () {
//                         authController.loginAdmin(
//                             emailController.text.trim(),
//                             passwordController.text.trim());
//                       },
//                       child: const Text("Login"),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Get.to(() => AdminForgetPasswordScreen());
//                       },
//                       child: const Text("Forgot Password?"),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Get.to(() => AdminSignUpScreen());
//                       },
//                       child: const Text("Create Admin"),
//                     ),
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/admin_auth_controller.dart';
import 'admin_signup_screen.dart';
import 'admin_forget_password.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  final AdminAuthController authController = Get.put(AdminAuthController());

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF142338);
    final accentColor = const Color(0xFFFFC107);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🟡 Logo / Icon
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
                child: Icon(Icons.admin_panel_settings,
                    size: 70, color: primaryColor),
              ),
              const SizedBox(height: 24),

              // 🟣 Title
              Text(
                'Admin Login',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Login to manage your app',
                style: TextStyle(color: Colors.grey[600], fontSize: 15),
              ),
              const SizedBox(height: 40),

              // 🟢 Email Field
              _buildTextField(
                controller: emailController,
                label: 'Email Address',
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 20),

              // 🔵 Password Field
              _buildTextField(
                controller: passwordController,
                label: 'Password',
                icon: Icons.lock_outline,
                obscureText: true,
              ),
              const SizedBox(height: 15),

              // 🟠 Remember + Forgot
              Row(
                children: [
                  Checkbox(
                    value: rememberMe,
                    onChanged: (value) {
                      setState(() => rememberMe = value!);
                    },
                    activeColor: primaryColor,
                  ),
                  const Text("Remember me"),
                  const Spacer(),
                  TextButton(
                    onPressed: () =>
                        Get.to(() => AdminForgetPasswordScreen()),
                    child: Text("Forgot Password?",
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.w500)),
                  )
                ],
              ),
              const SizedBox(height: 30),

              // 🔵 Login Button
              ElevatedButton(
                onPressed: () {
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    Get.snackbar('Error', 'Please enter all fields',
                        snackPosition: SnackPosition.BOTTOM);
                  } else {
                    authController.loginAdmin(
                        emailController.text.trim(),
                        passwordController.text.trim());
                  }
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
                    "Login",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // 🔹 Admin Sign Up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don’t have an admin account? "),
                  TextButton(
                    onPressed: () => Get.to(() => AdminSignUpScreen()),
                    child: Text("Create Admin",
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
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
