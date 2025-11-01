
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'register_screen.dart';
// import 'forget_password_screen.dart';
// import '../admin_auth/admin_login_screen.dart'; 
// import '../../../controllers/user_auth_controller.dart'; 

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   bool rememberMe = false;

//   final AuthController authController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFFFC107),
//       body:Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.lock, size: 80, color: Colors.blue),
//                 const SizedBox(height: 20),
//                 const Text(
//                   'Welcome Back!',
//                   style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 40),

//                 // ✅ Email TextField
//                 TextField(
//                   controller: emailController,
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     prefixIcon: const Icon(Icons.email),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // ✅ Password TextField
//                 TextField(
//                   obscureText: true,
//                   controller: passwordController,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     prefixIcon: const Icon(Icons.lock),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // ✅ Remember Me + Forgot Password
//                 Row(
//                   children: [
//                     Checkbox(
//                       value: rememberMe,
//                       onChanged: (value) {
//                         setState(() {
//                           rememberMe = value!;
//                         });
//                       },
//                     ),
//                     const Text('Remember Me'),
//                     const Spacer(),
//                     TextButton(
//                       onPressed: () {
//                         Get.to(() => ForgetPasswordScreen());
//                       },
//                       child: const Text(
//                         'Forgot Password?',
//                         style: TextStyle(color: Colors.amber),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),

//                 // ✅ Login Button
//                 InkWell(
//                   onTap: () {
//                     if (emailController.text.isEmpty ||
//                         passwordController.text.isEmpty) {
//                       Get.snackbar('Error', 'Please enter all fields',
//                           snackPosition: SnackPosition.BOTTOM);
//                     } else {
//                       authController.login(
//                         emailController.text.trim(),
//                         passwordController.text.trim(),
//                       );
//                     }
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF0e1726),
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     width: double.infinity,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     child: const Center(
//                       child: Text(
//                         'Login',
//                         style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 Row(
//                   children: const [
//                     Expanded(child: Divider(thickness: 1, color: Colors.grey)),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 8.0),
//                       child: Text(
//                         "Or Login With",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     ),
//                     Expanded(child: Divider(thickness: 1, color: Colors.grey)),
//                   ],
//                 ),
//                 const SizedBox(height: 20),

//                 // ✅ Social Buttons
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     _buildSocialIcon(FontAwesomeIcons.google, Colors.red),
//                     const SizedBox(width: 20),
//                     _buildSocialIcon(FontAwesomeIcons.facebook, Colors.blue),
//                     const SizedBox(width: 20),
//                     _buildSocialIcon(FontAwesomeIcons.instagram, Colors.purple),
//                   ],
//                 ),

//                 const SizedBox(height: 20),

//                 // ✅ Register Button
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text("Don’t have an account?"),
//                     TextButton(
//                       onPressed: () {
//                         Get.to(() => SignUpScreen());
//                       },
//                       child: const Text(
//                         "Register",
//                         style: TextStyle(color: Color(0xFFee6b25),),
//                       ),
//                     ),
//                   ],
//                 ),

//                 // ✅ Added “Login as Admin” Button
//                 const SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text("Login as "),
//                     TextButton(
//                       onPressed: () {
//                         Get.to(() => AdminLoginScreen());
//                       },
//                       child: const Text(
//                         "Admin",
//                         style: TextStyle(
//                           color: Colors.red,
//                           fontWeight: FontWeight.bold,
//                         ),
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

//   Widget _buildSocialIcon(IconData icon, Color color) {
//     return InkWell(
//       onTap: () {},
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(color: const Color.fromARGB(37, 0, 0, 0), blurRadius: 4),
//           ],
//         ),
//         child: FaIcon(icon, size: 20, color: color),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'register_screen.dart';
// import 'forget_password_screen.dart';
// import '../admin_auth/admin_login_screen.dart'; 
// import '../../../controllers/user_auth_controller.dart'; 

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   bool rememberMe = false;

//   final AuthController authController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFFFC107),
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // ✅ រូបតំណាង​ថ្មី
//                 Icon(Icons.lock_rounded, size: 80, color: Color(0xFF142338)), 
//                 const SizedBox(height: 20),
//                 const Text(
//                   'Welcome Back!',
//                   style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF142338)), // ✅ ប្រើ​ពណ៌​ថ្មី
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   'Sign in to your account',
//                   style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                 ),
//                 const SizedBox(height: 40),

//                 // ✅ Email TextField ថ្មី
//                 TextField(
//                   controller: emailController,
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12), // ✅ គែម​កោង​សមរម្យ
//                       borderSide: BorderSide.none, // ✅ លុប​បន្ទាត់​ព្រំដែន
//                     ),
//                     filled: true,
//                     fillColor: Colors.grey[200], // ✅ ផ្ទៃ​ពណ៌​ប្រផេះ
//                     prefixIcon: const Icon(Icons.email_outlined),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // ✅ Password TextField ថ្មី
//                 TextField(
//                   obscureText: true,
//                   controller: passwordController,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12), // ✅ គែម​កោង​សមរម្យ
//                       borderSide: BorderSide.none, // ✅ លុប​បន្ទាត់​ព្រំដែន
//                     ),
//                     filled: true,
//                     fillColor: Colors.grey[200], // ✅ ផ្ទៃ​ពណ៌​ប្រផេះ
//                     prefixIcon: const Icon(Icons.lock_outline),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // ✅ Remember Me + Forgot Password
//                 Row(
//                   children: [
//                     Checkbox(
//                       value: rememberMe,
//                       onChanged: (value) {
//                         setState(() {
//                           rememberMe = value!;
//                         });
//                       },
//                       activeColor: Color(0xFF142338), // ✅ ពណ៌​ថ្មី
//                     ),
//                     const Text('Remember Me'),
//                     const Spacer(),
//                     TextButton(
//                       onPressed: () {
//                         Get.to(() => ForgetPasswordScreen());
//                       },
//                       child: const Text(
//                         'Forgot Password?',
//                         style: TextStyle(color: Color(0xFF142338)), // ✅ ពណ៌​ថ្មី
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),

//                 // ✅ Login Button ថ្មី
//                 ElevatedButton(
//                   onPressed: () {
//                     if (emailController.text.isEmpty ||
//                         passwordController.text.isEmpty) {
//                       Get.snackbar('Error', 'Please enter all fields',
//                           snackPosition: SnackPosition.BOTTOM);
//                     } else {
//                       authController.login(
//                         emailController.text.trim(),
//                         passwordController.text.trim(),
//                       );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFF142338), // ✅ ពណ៌​ចម្បង​ថ្មី
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12), // ✅ គែម​កោង
//                     ),
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                   ),
//                   child: const Center(
//                     child: Text(
//                       'Login',
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // ✅ ឬ Login ជាមួយ
//                 Row(
//                   children: [
//                     Expanded(child: Divider(thickness: 1, color: Colors.grey)),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 8.0),
//                       child: Text(
//                         "Or Login With",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     ),
//                     Expanded(child: Divider(thickness: 1, color: Colors.grey)),
//                   ],
//                 ),
//                 const SizedBox(height: 20),

//                 // ✅ Social Buttons
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     _buildSocialIcon(FontAwesomeIcons.google, Colors.red),
//                     const SizedBox(width: 20),
//                     _buildSocialIcon(FontAwesomeIcons.facebook, Colors.blue),
//                     const SizedBox(width: 20),
//                     _buildSocialIcon(FontAwesomeIcons.instagram, Colors.purple),
//                   ],
//                 ),

//                 const SizedBox(height: 20),

//                 // ✅ Register Button
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text("Don’t have an account?"),
//                     TextButton(
//                       onPressed: () {
//                         Get.to(() => SignUpScreen());
//                       },
//                       child: const Text(
//                         "Register",
//                         style: TextStyle(color: Color(0xFF142338)), // ✅ ពណ៌​ថ្មី
//                       ),
//                     ),
//                   ],
//                 ),

//                 // ✅ Added “Login as Admin” Button
//                 const SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text("Login as "),
//                     TextButton(
//                       onPressed: () {
//                         Get.to(() => AdminLoginScreen());
//                       },
//                       child: const Text(
//                         "Admin",
//                         style: TextStyle(
//                           color: Color(0xFF142338),
//                           fontWeight: FontWeight.bold,
//                         ),
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

//   Widget _buildSocialIcon(IconData icon, Color color) {
//     return InkWell(
//       onTap: () {},
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//                 color: const Color.fromARGB(37, 0, 0, 0),
//                 blurRadius: 4,
//                 offset: Offset(0, 2)), // ✅ ស្រមោល​ស្រទន់
//           ],
//         ),
//         child: FaIcon(icon, size: 20, color: color),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'register_screen.dart';
import 'forget_password_screen.dart';
import '../admin_auth/admin_login_screen.dart';
import '../../../controllers/user_auth_controller.dart';

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
                child: Icon(Icons.lock_rounded,
                    size: 70, color: primaryColor),
              ),
              const SizedBox(height: 24),

              // 🟣 Title
              Text(
                'Welcome Back 👋',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Login to continue your journey',
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
                  onPressed: () => Get.to(() => ForgetPasswordScreen()),
                  child: Text("Forgot Password?",
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.w500)),
                )
              ]),

              const SizedBox(height: 30),

              // 🔵 Login Button
              ElevatedButton(
                onPressed: () {
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  // backgroundColor: Colors.green.shade600,
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

              // 🔹 Divider with text
              Row(
                children: [
                  Expanded(
                      child: Divider(thickness: 1, color: Colors.grey[300])),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Or continue with",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  Expanded(
                      child: Divider(thickness: 1, color: Colors.grey[300])),
                ],
              ),
              const SizedBox(height: 25),

              // 🟢 Social buttons
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

              const SizedBox(height: 30),

              // 🔹 Register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don’t have an account? "),
                  TextButton(
                    onPressed: () => Get.to(() => SignUpScreen()),
                    child: Text("Register",
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),

              // 🔹 Admin Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Login as "),
                  TextButton(
                    onPressed: () => Get.to(() => AdminLoginScreen()),
                    child: Text("Admin",
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold)),
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

  Widget _buildSocialIcon(IconData icon, Color color) {
    return InkWell(
      onTap: () {},
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
