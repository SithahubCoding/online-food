import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'auth/login_screen.dart';

class IntroScreenDemo extends StatefulWidget {
  const IntroScreenDemo({super.key});
  @override
  State<IntroScreenDemo> createState() => _IntroScreenDemoState();
}

class _IntroScreenDemoState extends State<IntroScreenDemo> {
  final _introKey = GlobalKey<IntroductionScreenState>();

  // 📱 List of Introduction Pages
  final List<PageViewModel> listPagesViewModel = [
    PageViewModel(
      title: "",
      bodyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/burger_splash.png',
            width: 250,
            height: 250,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          const Text(
            "All Favorite Food in One Place",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
        ],
      ),
      decoration: const PageDecoration(
        contentMargin: EdgeInsets.symmetric(horizontal: 16, vertical: 60),
      ),
    ),
    PageViewModel(
      title: "",
      bodyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/burger_splash.png',
            width: 250,
            height: 250,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          const Text(
            "Order From Your Nearest Restaurant",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
        ],
      ),
      decoration: const PageDecoration(
        contentMargin: EdgeInsets.symmetric(horizontal: 16, vertical: 60),
      ),
    ),
    PageViewModel(
      title: "",
      bodyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/burger_splash.png',
            width: 250,
            height: 250,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          const Text(
            "Enjoy Our Free Delivery",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
        ],
      ),
      decoration: const PageDecoration(
        contentMargin: EdgeInsets.symmetric(horizontal: 16, vertical: 60),
      ),
    ),
    PageViewModel(
      title: "",
      bodyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/burger_splash.png',
            width: 250,
            height: 250,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          const Text(
            "Easily Track Your Order",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
        ],
      ),
      decoration: const PageDecoration(
        contentMargin: EdgeInsets.symmetric(horizontal: 16, vertical: 60),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        key: _introKey,
        pages: listPagesViewModel,
        showSkipButton: true,
        skip: const Text("Skip", style: TextStyle(color: Colors.grey)),
        next: const Icon(Icons.arrow_forward, color: Colors.orange),
        done: const Text("Done", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
        onDone: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => LoginScreen()),
          );
        },
        dotsDecorator: const DotsDecorator(
          activeColor: Colors.orange,
          size: Size(8.0, 8.0),
          activeSize: Size(12.0, 12.0),
        ),
      ),
    );
  }
}
