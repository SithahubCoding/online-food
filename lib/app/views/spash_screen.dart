
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'home/home_screen.dart';
// import 'introduction_screen.dart';
// import '../views/dashboard/dashboard_screen.dart'; 

// class CustomSplashScreen extends StatefulWidget {
//   const CustomSplashScreen({super.key});

//   @override
//   State<CustomSplashScreen> createState() => _CustomSplashScreenState();
// }

// class _CustomSplashScreenState extends State<CustomSplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 2), () {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         // Check user role from Firestore
//         FirebaseFirestore.instance.collection('users').doc(user.uid).get().then((doc) {
//           if (doc.exists && doc['role'] == 'admin') {
//             Get.offAll(() => const DashboardScreen());
//           } else {
//             Get.offAll(() => HomeScreen());
//           }
//         }).catchError((e) {
//           // If error, go to user home
//           Get.offAll(() => HomeScreen());
//         });
//       } else {
//         // Not logged in
//         Get.offAll(() => IntroScreenDemo());
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     const splashColor = Color(0xFFFFC107);

//     return const Scaffold(
//       backgroundColor: splashColor,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Icon(
//               Icons.lunch_dining, 
//               size: 100,
//               color: Colors.black87,
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Foodies',
//               style: TextStyle(
//                 fontSize: 34,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Serif', 
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'home/home_screen.dart';
// import 'introduction_screen.dart';
// import '../views/dashboard/dashboard_screen.dart';

// class CustomSplashScreen extends StatefulWidget {
//   const CustomSplashScreen({super.key});

//   @override
//   State<CustomSplashScreen> createState() => _CustomSplashScreenState();
// }

// class _CustomSplashScreenState extends State<CustomSplashScreen> {
//   final primaryColor = const Color(0xFF142338);
//   final accentColor = const Color(0xFFFFC107);

//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 2), () {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         FirebaseFirestore.instance.collection('users').doc(user.uid).get().then((doc) {
//           if (doc.exists && doc['role'] == 'admin') {
//             Get.offAll(() => const DashboardScreen());
//           } else {
//             Get.offAll(() => HomeScreen());
//           }
//         }).catchError((e) {
//           Get.offAll(() => HomeScreen());
//         });
//       } else {
//         Get.offAll(() => IntroScreenDemo());
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: accentColor, // backgroundColor 0xFFFFC107
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Logo in Circle with shadow (like LoginScreen)
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 10,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Icon(
//                 Icons.lunch_dining,
//                 size: 70,
//                 color: primaryColor,
//               ),
//             ),
//             const SizedBox(height: 24),
//             // App name
//             Text(
//               'Foodies',
//               style: TextStyle(
//                 fontSize: 34,
//                 fontWeight: FontWeight.bold,
//                 color: primaryColor,
//                 fontFamily: 'Serif',
//               ),
//             ),
//             const SizedBox(height: 10),
//             // Tagline or welcome message
//             Text(
//               'Welcome to Foodies App',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey[800],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home/home_screen.dart';
import 'introduction_screen.dart';
import '../views/dashboard/dashboard_screen.dart';

class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({super.key});

  @override
  State<CustomSplashScreen> createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen>
    with TickerProviderStateMixin {
  final primaryColor = const Color(0xFF142338);

  late AnimationController _logoController;
  late AnimationController _textController;

  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();

    _logoController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _logoAnimation = Tween<double>(begin: 0, end: 1).animate(_logoController);

    _textController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _textAnimation = Tween<double>(begin: 0, end: 1).animate(_textController);

    _logoController.forward();
    Future.delayed(const Duration(milliseconds: 400), () {
      _textController.forward();
    });

    Future.delayed(const Duration(seconds: 2), () {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get()
            .then((doc) {
          if (doc.exists && doc['role'] == 'admin') {
            Get.offAll(() => const DashboardScreen());
          } else {
            Get.offAll(() => HomeScreen());
          }
        }).catchError((e) {
          Get.offAll(() => HomeScreen());
        });
      } else {
        Get.offAll(() => IntroScreenDemo());
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFC107), Color(0xFFFF6F00),],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _logoAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                          begin: const Offset(0, 0.3), end: Offset.zero)
                      .animate(_logoController),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.lunch_dining,
                      size: 70,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FadeTransition(
                opacity: _textAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                          begin: const Offset(0, 0.3), end: Offset.zero)
                      .animate(_textController),
                  child: Column(
                    children: [
                      Text(
                        'Foodies',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Serif',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Welcome to Foodies App',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
