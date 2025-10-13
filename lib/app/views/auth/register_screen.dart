
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../controllers/authController.dart';
import './login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool acceptTerms = false;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final AuthController authController = Get.put(AuthController());

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  bool isValidEmail(String email) {
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email);
  }

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
                const SizedBox(height: 20),
                const Text(
                  'Create Account',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),

                // Email
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),

                // Password
                TextField(
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),

                // Confirm Password
                TextField(
                  obscureText: true,
                  controller: confirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),

                // Accept Terms Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: acceptTerms,
                      onChanged: (value) {
                        setState(() {
                          acceptTerms = value!;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text(
                        "I accept the Terms & Conditions",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Register Button
                InkWell(
                  onTap: () {
                    if (!acceptTerms) {
                      Get.snackbar(
                        "Error",
                        "You must accept the Terms & Conditions",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }

                    if (!isValidEmail(email.text.trim())) {
                      Get.snackbar(
                        "Error",
                        "Invalid email address",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }

                    if (password.text != confirmPassword.text) {
                      Get.snackbar(
                        "Error",
                        "Passwords do not match",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }

                    authController.signUp(email.text.trim(), password.text.trim());
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        colors: [Colors.orange, Colors.deepOrangeAccent],
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Register',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Or register with social
                Row(
                  children: const [
                    Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("Or Register With", style: TextStyle(color: Colors.grey)),
                    ),
                    Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 20),

                // Social Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialButton(icon: FontAwesomeIcons.google, color: Colors.red, onTap: () {}),
                    const SizedBox(width: 20),
                    SocialButton(icon: FontAwesomeIcons.facebook, color: Colors.blue, onTap: () {}),
                    const SizedBox(width: 20),
                    SocialButton(icon: FontAwesomeIcons.instagram, color: Colors.purple, onTap: () {}),
                  ],
                ),
                const SizedBox(height: 20),

                // Redirect to login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () => Get.to(() => LoginScreen()),
                      child: const Text(
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

// Social button widget
class SocialButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const SocialButton({required this.icon, required this.color, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: FaIcon(icon, color: color, size: 28),
      ),
    );
  }
}
