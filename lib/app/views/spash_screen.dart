
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'introduction_screen.dart';
import 'auth/login_screen.dart';

class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({super.key});

  @override
  State<CustomSplashScreen> createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (FirebaseAuth.instance.currentUser != null) {

        Get.offAll(() => HomeScreen());
      } else {
        Get.offAll(() =>  IntroScreenDemo());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const splashColor = Color(0xFFFFC107);

    return const Scaffold(
      backgroundColor: splashColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           
            Icon(
              Icons.lunch_dining, 
              size: 100,
              color: Colors.black87,
            ),
            
            SizedBox(height: 20),

            Text(
              'Foodies',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                fontFamily: 'Serif', 
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// **Important Notes:**
// 1. Replace the 'Icons.lunch_dining' placeholder with your actual image asset:
//    Image.asset('assets/burger_icon.png', width: 100, height: 100) 
// 2. Ensure your 'HomeScreen' and 'IntroScreenDemo' are properly defined and imported.
// 3. Ensure 'firebase_auth' is correctly initialized in your main application.