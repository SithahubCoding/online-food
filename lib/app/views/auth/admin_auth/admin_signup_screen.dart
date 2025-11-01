// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../controllers/admin_auth_controller.dart';

// class AdminSignUpScreen extends StatelessWidget {
//   AdminSignUpScreen({super.key});

//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final AdminAuthController authController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Create Admin")),
//       body: Obx(
//         () => authController.isLoading.value
//             ? const Center(child: CircularProgressIndicator())
//             : Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     TextField(
//                       controller: nameController,
//                       decoration: const InputDecoration(labelText: "Name"),
//                     ),
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
//                         authController.createAdmin(
//                           nameController.text.trim(),
//                           emailController.text.trim(),
//                           passwordController.text.trim(),
//                         );
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
import '../admin_auth/admin_login_screen.dart'; // import LoginScreen

class AdminSignUpScreen extends StatefulWidget {
  const AdminSignUpScreen({super.key});

  @override
  State<AdminSignUpScreen> createState() => _AdminSignUpScreenState();
}

class _AdminSignUpScreenState extends State<AdminSignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AdminAuthController authController = Get.find();
  bool showPassword = false;

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
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
          child: Obx(
            () => authController.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Column(
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

                      const Text(
                        'Create Admin',
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF142338)),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sign up to manage your app',
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 15),
                      ),
                      const SizedBox(height: 40),

                      // Name Field
                      _buildTextField(
                          controller: nameController,
                          label: 'Full Name',
                          icon: Icons.person_outline),

                      const SizedBox(height: 20),

                      // Email Field
                      _buildTextField(
                          controller: emailController,
                          label: 'Email Address',
                          icon: Icons.email_outlined),

                      const SizedBox(height: 20),

                      // Password Field
                      _buildTextField(
                        controller: passwordController,
                        label: 'Password',
                        icon: Icons.lock_outline,
                        obscureText: !showPassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                              showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey[700]),
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Create Admin Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            authController.createAdmin(
                              nameController.text.trim(),
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 3,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                          ),
                          child: const Text(
                            'Create Admin',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // 🔹 Already have an account? Login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? "),
                          TextButton(
                            onPressed: () => Get.to(() => const AdminLoginScreen()),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
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
        suffixIcon: suffixIcon,
      ),
    );
  }
}
