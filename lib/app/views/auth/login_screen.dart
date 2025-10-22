import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../home/home_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'register_screen.dart';
import 'forget_password_screen.dart';
import '../../controllers/auth_controller.dart'; 

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = false;

  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock, size: 80, color: Colors.blue),
                const SizedBox(height: 20),
                const Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),

                // ✅ Email TextField
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    prefixIcon: const Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 20),

                // ✅ Password TextField
                TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 20),

                // ✅ Remember Me + Forgot Password
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value!;
                        });
                      },
                    ),
                    const Text('Remember Me'),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Get.to(() => ForgetPasswordScreen());
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.amber),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // ✅ Login Button
                InkWell(
                  onTap: () {
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      Get.snackbar('Error', 'Please enter all fields',
                          snackPosition: SnackPosition.BOTTOM);
                    } else {
                      authController.login(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFffe699),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  children: const [
                    Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Or Login With",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 20),

                // ✅ Social Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialIcon(FontAwesomeIcons.google, Colors.red),
                    const SizedBox(width: 20),
                    _buildSocialIcon(FontAwesomeIcons.facebook, Colors.blue),
                    const SizedBox(width: 20),
                    _buildSocialIcon(FontAwesomeIcons.instagram, Colors.purple),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don’t have an account?"),
                    TextButton(
                      onPressed: () {
                        Get.to(() => RegisterScreen());
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.amber),
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

  Widget _buildSocialIcon(IconData icon, Color color) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 4),
          ],
        ),
        child: FaIcon(icon, size: 20, color: color),
      ),
    );
  }
}
