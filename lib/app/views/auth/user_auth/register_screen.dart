
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import '../../../controllers/user_auth_controller.dart';
// import 'login_screen.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   bool acceptTerms = false;
//   final TextEditingController email = TextEditingController();
//   final TextEditingController password = TextEditingController();
//   final TextEditingController confirmPassword = TextEditingController();
//   final AuthController authController = Get.put(AuthController());

//   @override
//   void dispose() {
//     email.dispose();
//     password.dispose();
//     confirmPassword.dispose();
//     super.dispose();
//   }

//   bool isValidEmail(String email) {
//     return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFFFC107),
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Icon(Icons.lock_outline, size: 100, color: Colors.blueAccent),
//                 const SizedBox(height: 20),
//                 const Text(
//                   'Create Account',
//                   style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 30),

//                 // Email
//                 TextField(
//                   keyboardType: TextInputType.emailAddress,
//                   controller: email,
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     prefixIcon: const Icon(Icons.email),
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
//                     filled: true,
//                     fillColor: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // Password
//                 TextField(
//                   obscureText: true,
//                   controller: password,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     prefixIcon: const Icon(Icons.lock),
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
//                     filled: true,
//                     fillColor: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // Confirm Password
//                 TextField(
//                   obscureText: true,
//                   controller: confirmPassword,
//                   decoration: InputDecoration(
//                     labelText: 'Confirm Password',
//                     prefixIcon: const Icon(Icons.lock),
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
//                     filled: true,
//                     fillColor: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // Accept Terms Checkbox
//                 Row(
//                   children: [
//                     Checkbox(
//                       value: acceptTerms,
//                       onChanged: (value) {
//                         setState(() {
//                           acceptTerms = value!;
//                         });
//                       },
//                     ),
//                     const Expanded(
//                       child: Text(
//                         "I accept the Terms & Conditions",
//                         style: TextStyle(fontSize: 14),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),

//                 // Register Button
//                 InkWell(
//                   onTap: () {
//                     if (!acceptTerms) {
//                       Get.snackbar(
//                         "Error",
//                         "You must accept the Terms & Conditions",
//                         snackPosition: SnackPosition.BOTTOM,
//                       );
//                       return;
//                     }

//                     if (!isValidEmail(email.text.trim())) {
//                       Get.snackbar(
//                         "Error",
//                         "Invalid email address",
//                         snackPosition: SnackPosition.BOTTOM,
//                       );
//                       return;
//                     }

//                     if (password.text != confirmPassword.text) {
//                       Get.snackbar(
//                         "Error",
//                         "Passwords do not match",
//                         snackPosition: SnackPosition.BOTTOM,
//                       );
//                       return;
//                     }

//                     authController.signUp(email.text.trim(), password.text.trim());
//                   },
//                   child: Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       gradient: const LinearGradient(
//                         colors: [Colors.orange, Colors.deepOrangeAccent],
//                       ),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         'Register',
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // Or register with social
//                 Row(
//                   children: const [
//                     Expanded(child: Divider(thickness: 1, color: Colors.grey)),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 8.0),
//                       child: Text("Or Register With", style: TextStyle(color: Colors.grey)),
//                     ),
//                     Expanded(child: Divider(thickness: 1, color: Colors.grey)),
//                   ],
//                 ),
//                 const SizedBox(height: 20),

//                 // Social Buttons
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SocialButton(icon: FontAwesomeIcons.google, color: Colors.red, onTap: () {}),
//                     const SizedBox(width: 20),
//                     SocialButton(icon: FontAwesomeIcons.facebook, color: Colors.blue, onTap: () {}),
//                     const SizedBox(width: 20),
//                     SocialButton(icon: FontAwesomeIcons.instagram, color: Colors.purple, onTap: () {}),
//                   ],
//                 ),
//                 const SizedBox(height: 20),

//                 // Redirect to login
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text("Already have an account?"),
//                     TextButton(
//                       onPressed: () => Get.to(() => LoginScreen()),
//                       child: const Text(
//                         "Login",
//                         style: TextStyle(color: Colors.deepOrangeAccent),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Social button widget
// class SocialButton extends StatelessWidget {
//   final IconData icon;
//   final Color color;
//   final VoidCallback onTap;

//   const SocialButton({required this.icon, required this.color, required this.onTap, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.white,
//           boxShadow: [BoxShadow(color: const Color.fromARGB(37, 0, 0, 0), blurRadius: 5, offset: const Offset(0, 2))],
//         ),
//         child: FaIcon(icon, color: color, size: 28),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../controllers/user_auth_controller.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
    final primaryColor = const Color(0xFF142338);
    final accentColor = const Color(0xFFFFC107);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo / Icon
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
                child: Icon(Icons.lock_outline, size: 70, color: primaryColor),
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sign up to get started',
                style: TextStyle(color: Colors.grey[600], fontSize: 15),
              ),
              const SizedBox(height: 30),

              // Email
              _buildTextField(
                controller: email,
                label: 'Email Address',
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 20),

              // Password
              _buildTextField(
                controller: password,
                label: 'Password',
                icon: Icons.lock_outline,
                obscureText: true,
              ),
              const SizedBox(height: 20),

              // Confirm Password
              _buildTextField(
                controller: confirmPassword,
                label: 'Confirm Password',
                icon: Icons.lock_outline,
                obscureText: true,
              ),
              const SizedBox(height: 15),

              // Accept Terms Checkbox
              Row(
                children: [
                  Checkbox(
                    value: acceptTerms,
                    onChanged: (value) {
                      setState(() => acceptTerms = value!);
                    },
                    activeColor: primaryColor,
                  ),
                  const Expanded(
                    child: Text(
                      "I accept the Terms & Conditions",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // Register Button
              ElevatedButton(
                onPressed: () {
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

                  authController.signUp(
                      email.text.trim(), password.text.trim());
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
                    "Register",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Or register with social
              Row(
                children: [
                  Expanded(
                      child: Divider(thickness: 1, color: Colors.grey[300])),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Or Register With",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Expanded(
                      child: Divider(thickness: 1, color: Colors.grey[300])),
                ],
              ),
              const SizedBox(height: 25),

              // Social Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialButton(
                      icon: FontAwesomeIcons.google,
                      color: Colors.red,
                      onTap: () {}),
                  const SizedBox(width: 20),
                  SocialButton(
                      icon: FontAwesomeIcons.facebook,
                      color: Colors.blue,
                      onTap: () {}),
                  const SizedBox(width: 20),
                  SocialButton(
                      icon: FontAwesomeIcons.instagram,
                      color: Colors.purple,
                      onTap: () {}),
                ],
              ),
              const SizedBox(height: 30),

              // Redirect to login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  TextButton(
                    onPressed: () => Get.to(() => const LoginScreen()),
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold),
                    ),
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

// Social button widget
class SocialButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const SocialButton(
      {required this.icon, required this.color, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(child: FaIcon(icon, color: color, size: 22)),
      ),
    );
  }
}
