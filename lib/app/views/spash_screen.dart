
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home/home_screen.dart';
import 'introduction_screen.dart';
// import './auth/login_screen.dart';

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

