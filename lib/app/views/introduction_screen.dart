// import 'package:flutter/material.dart';
// import 'package:introduction_screen/introduction_screen.dart';
// import 'auth/user_auth/login_screen.dart';

// class IntroScreenDemo extends StatefulWidget {
//   const IntroScreenDemo({super.key});
//   @override
//   State<IntroScreenDemo> createState() => _IntroScreenDemoState();
// }

// class _IntroScreenDemoState extends State<IntroScreenDemo> {
//   final _introKey = GlobalKey<IntroductionScreenState>();

//   // 📱 List of Introduction Pages
//   final List<PageViewModel> listPagesViewModel = [
//     PageViewModel(
//       title: "",
//       bodyWidget: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             'assets/images/burger_splash.png',
//             width: 250,
//             height: 250,
//             fit: BoxFit.contain,
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             "All Favorite Food in One Place",
//             textAlign: TextAlign.center,
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
//           ),
//         ],
//       ),
//       decoration: const PageDecoration(
//         contentMargin: EdgeInsets.symmetric(horizontal: 16, vertical: 60),
//       ),
//     ),
//     PageViewModel(
//       title: "",
//       bodyWidget: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             'assets/images/burger_splash.png',
//             width: 250,
//             height: 250,
//             fit: BoxFit.contain,
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             "Order From Your Nearest Restaurant",
//             textAlign: TextAlign.center,
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
//           ),
//         ],
//       ),
//       decoration: const PageDecoration(
//         contentMargin: EdgeInsets.symmetric(horizontal: 16, vertical: 60),
//       ),
//     ),
//     PageViewModel(
//       title: "",
//       bodyWidget: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             'assets/images/burger_splash.png',
//             width: 250,
//             height: 250,
//             fit: BoxFit.contain,
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             "Enjoy Our Free Delivery",
//             textAlign: TextAlign.center,
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
//           ),
//         ],
//       ),
//       decoration: const PageDecoration(
//         contentMargin: EdgeInsets.symmetric(horizontal: 16, vertical: 60),
//       ),
//     ),
//     PageViewModel(
//       title: "",
//       bodyWidget: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             'assets/images/burger_splash.png',
//             width: 250,
//             height: 250,
//             fit: BoxFit.contain,
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             "Easily Track Your Order",
//             textAlign: TextAlign.center,
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
//           ),
//         ],
//       ),
//       decoration: const PageDecoration(
//         contentMargin: EdgeInsets.symmetric(horizontal: 16, vertical: 60),
//       ),
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IntroductionScreen(
//         key: _introKey,
//         pages: listPagesViewModel,
//         showSkipButton: true,
//         skip: const Text("Skip", style: TextStyle(color: Colors.grey)),
//         next: const Icon(Icons.arrow_forward, color: Colors.orange),
//         done: const Text("Done", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
//         onDone: () {
//           Navigator.of(context).pushReplacement(
//             MaterialPageRoute(builder: (_) => LoginScreen()),
//           );
//         },
//         dotsDecorator: const DotsDecorator(
//           activeColor: Colors.orange,
//           size: Size(8.0, 8.0),
//           activeSize: Size(12.0, 12.0),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:introduction_screen/introduction_screen.dart';
// import 'package:get/get.dart';
// import 'auth/user_auth/login_screen.dart';

// class IntroScreenDemo extends StatefulWidget {
//   const IntroScreenDemo({super.key});

//   @override
//   State<IntroScreenDemo> createState() => _IntroScreenDemoState();
// }

// class _IntroScreenDemoState extends State<IntroScreenDemo>
//     with TickerProviderStateMixin {
//   final _introKey = GlobalKey<IntroductionScreenState>();

//   late AnimationController _imageController;
//   late AnimationController _textController;

//   late Animation<double> _imageAnimation;
//   late Animation<double> _textAnimation;

//   final primaryColor = const Color(0xFF142338);
//   final accentColor = const Color(0xFFFFC107);

//   @override
//   void initState() {
//     super.initState();

//     _imageController = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 1000));
//     _imageAnimation =
//         Tween<double>(begin: 0, end: 1).animate(_imageController);

//     _textController = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 1200));
//     _textAnimation = Tween<double>(begin: 0, end: 1).animate(_textController);

//     _imageController.forward();
//     Future.delayed(const Duration(milliseconds: 400), () {
//       _textController.forward();
//     });
//   }

//   @override
//   void dispose() {
//     _imageController.dispose();
//     _textController.dispose();
//     super.dispose();
//   }

//   List<PageViewModel> getPages() {
//     List<String> titles = [
//       "All Your Favorite Foods in One Place",
//       "Order from Your Nearest Restaurants",
//       "Enjoy Our Fast & Free Delivery",
//       "Track Your Orders Easily"
//     ];

//     return titles.map((title) {
//       return PageViewModel(
//         title: "",
//         bodyWidget: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             FadeTransition(
//               opacity: _imageAnimation,
//               child: SlideTransition(
//                 position: Tween<Offset>(
//                         begin: const Offset(0, 0.3), end: Offset.zero)
//                     .animate(_imageController),
//                 child: Container(
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 10,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Image.asset(
//                     'assets/images/burger_splash.png',
//                     width: 150,
//                     height: 150,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),
//             FadeTransition(
//               opacity: _textAnimation,
//               child: SlideTransition(
//                 position: Tween<Offset>(
//                         begin: const Offset(0, 0.3), end: Offset.zero)
//                     .animate(_textController),
//                 child: Text(
//                   title,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: primaryColor,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         decoration: const PageDecoration(
//           contentMargin: EdgeInsets.symmetric(horizontal: 16, vertical: 60),
//           pageColor: Colors.white, // solid white background
//         ),
//       );
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IntroductionScreen(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFFFFC107), Color(0xFFFF6F00)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         key: _introKey,
//         pages: getPages(),
//         showSkipButton: true,
//         skip: Text(
//           "Skip",
//           style: TextStyle(
//               color: primaryColor, fontWeight: FontWeight.bold),
//         ),
//         next: Icon(Icons.arrow_forward, color: primaryColor),
//         done: Text(
//           "Done",
//           style: TextStyle(
//               color: primaryColor, fontWeight: FontWeight.bold),
//         ),
//         onDone: () => Get.offAll(() => const LoginScreen()),
//         dotsDecorator: DotsDecorator(
//           activeColor: primaryColor,
//           color: Colors.grey,
//           size: const Size(8.0, 8.0),
//           activeSize: const Size(12.0, 12.0),
//         ),
//         globalBackgroundColor: Colors.white,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:get/get.dart';
import 'auth/user_auth/login_screen.dart';

class IntroScreenDemo extends StatefulWidget {
  const IntroScreenDemo({super.key});

  @override
  State<IntroScreenDemo> createState() => _IntroScreenDemoState();
}

class _IntroScreenDemoState extends State<IntroScreenDemo>
    with TickerProviderStateMixin {
  final _introKey = GlobalKey<IntroductionScreenState>();

  late AnimationController _imageController;
  late AnimationController _textController;

  late Animation<double> _imageAnimation;
  late Animation<double> _textAnimation;

  final Color primaryColor = Colors.white; // text/logo color
  final Color accentColor = const Color(0xFFFFC107);

  @override
  void initState() {
    super.initState();

    _imageController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _imageAnimation =
        Tween<double>(begin: 0, end: 1).animate(_imageController);

    _textController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _textAnimation = Tween<double>(begin: 0, end: 1).animate(_textController);

    _imageController.forward();
    Future.delayed(const Duration(milliseconds: 400), () {
      _textController.forward();
    });
  }

  @override
  void dispose() {
    _imageController.dispose();
    _textController.dispose();
    super.dispose();
  }

  List<PageViewModel> getPages() {
    List<String> titles = [
      "All Your Favorite Foods in One Place",
      "Order from Your Nearest Restaurants",
      "Enjoy Our Fast & Free Delivery",
      "Track Your Orders Easily"
    ];

    return titles.map((title) {
      return PageViewModel(
        title: "",
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _imageAnimation,
              child: SlideTransition(
                position: Tween<Offset>(
                        begin: const Offset(0, 0.3), end: Offset.zero)
                    .animate(_imageController),
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
                  child: Image.asset(
                    'assets/images/burger_splash.png',
                    width: 150,
                    height: 150,
                    fit: BoxFit.contain,
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
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        decoration: const PageDecoration(
          contentMargin: EdgeInsets.symmetric(horizontal: 16, vertical: 60),
          pageColor: Colors.transparent, // transparent to show gradient
        ),
      );
    }).toList();
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
        child: IntroductionScreen(
          key: _introKey,
          pages: getPages(),
          showSkipButton: true,
          skip: Text(
            "Skip",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          ),
          next: Icon(Icons.arrow_forward, color: primaryColor),
          done: Text(
            "Done",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          ),
          onDone: () => Get.offAll(() => const LoginScreen()),
          dotsDecorator: DotsDecorator(
            activeColor: primaryColor,
            color: Colors.white54,
            size: const Size(8.0, 8.0),
            activeSize: const Size(12.0, 12.0),
          ),
          globalBackgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:introduction_screen/introduction_screen.dart';
// import 'package:get/get.dart';
// import 'auth/user_auth/login_screen.dart';

// // Leaf model
// class Leaf {
//   double dx;
//   double dy;
//   double size;
//   double speed;

//   Leaf({
//     required this.dx,
//     required this.dy,
//     required this.size,
//     required this.speed,
//   });
// }

// class IntroScreenDemo extends StatefulWidget {
//   const IntroScreenDemo({super.key});

//   @override
//   State<IntroScreenDemo> createState() => _IntroScreenDemoState();
// }

// class _IntroScreenDemoState extends State<IntroScreenDemo>
//     with TickerProviderStateMixin {
//   final _introKey = GlobalKey<IntroductionScreenState>();

//   late AnimationController _imageController;
//   late AnimationController _textController;
//   late AnimationController _leavesController;

//   late Animation<double> _imageAnimation;
//   late Animation<double> _textAnimation;

//   final Color primaryColor = Colors.white;
//   final Color accentColor = const Color(0xFFFFC107);

//   // Leaves
//   final int numberOfLeaves = 8;
//   final Random random = Random();
//   late List<Leaf> leaves;

//   @override
//   void initState() {
//     super.initState();

//     // Image & Text animations
//     _imageController = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 1000));
//     _imageAnimation =
//         Tween<double>(begin: 0, end: 1).animate(_imageController);

//     _textController = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 1200));
//     _textAnimation = Tween<double>(begin: 0, end: 1).animate(_textController);

//     _imageController.forward();
//     Future.delayed(const Duration(milliseconds: 400), () {
//       _textController.forward();
//     });

//     // Leaves animation controller
//     _leavesController =
//         AnimationController(vsync: this, duration: const Duration(seconds: 10))
//           ..repeat();

//     // Initialize leaves
//     leaves = List.generate(
//       numberOfLeaves,
//       (index) => Leaf(
//         dx: random.nextDouble(),
//         dy: random.nextDouble(),
//         size: random.nextDouble() * 20 + 20,
//         speed: random.nextDouble() * 0.003 + 0.001,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _imageController.dispose();
//     _textController.dispose();
//     _leavesController.dispose();
//     super.dispose();
//   }

//   List<PageViewModel> getPages() {
//     List<String> titles = [
//       "All Your Favorite Foods in One Place",
//       "Order from Your Nearest Restaurants",
//       "Enjoy Our Fast & Free Delivery",
//       "Track Your Orders Easily"
//     ];

//     return titles.map((title) {
//       return PageViewModel(
//         title: "",
//         bodyWidget: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             FadeTransition(
//               opacity: _imageAnimation,
//               child: SlideTransition(
//                 position: Tween<Offset>(
//                         begin: const Offset(0, 0.3), end: Offset.zero)
//                     .animate(_imageController),
//                 child: Container(
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 10,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Image.asset(
//                     'assets/images/burger_splash.png',
//                     width: 150,
//                     height: 150,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),
//             FadeTransition(
//               opacity: _textAnimation,
//               child: SlideTransition(
//                 position: Tween<Offset>(
//                         begin: const Offset(0, 0.3), end: Offset.zero)
//                     .animate(_textController),
//                 child: Text(
//                   title,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: primaryColor,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         decoration: const PageDecoration(
//           contentMargin: EdgeInsets.symmetric(horizontal: 16, vertical: 60),
//           pageColor: Colors.transparent,
//         ),
//       );
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Gradient background
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFFa8e063), Color(0xFFFFC107)], // farm/green to yellow
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),
//           // Animated leaves
//           AnimatedBuilder(
//             animation: _leavesController,
//             builder: (context, child) {
//               return CustomPaint(
//                 painter: LeavesPainter(leaves, _leavesController.value),
//                 child: Container(),
//               );
//             },
//           ),
//           // IntroductionScreen content
//           IntroductionScreen(
//             key: _introKey,
//             pages: getPages(),
//             showSkipButton: true,
//             skip: Text(
//               "Skip",
//               style:
//                   TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
//             ),
//             next: Icon(Icons.arrow_forward, color: primaryColor),
//             done: Text(
//               "Done",
//               style:
//                   TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
//             ),
//             onDone: () => Get.offAll(() => const LoginScreen()),
//             dotsDecorator: DotsDecorator(
//               activeColor: primaryColor,
//               color: Colors.white54,
//               size: const Size(8.0, 8.0),
//               activeSize: const Size(12.0, 12.0),
//             ),
//             globalBackgroundColor: Colors.transparent,
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Leaves painter
// class LeavesPainter extends CustomPainter {
//   final List<Leaf> leaves;
//   final double animationValue;

//   LeavesPainter(this.leaves, this.animationValue);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..color = Colors.green.withOpacity(0.6);

//     for (var leaf in leaves) {
//       double x = (leaf.dx * size.width + animationValue * size.width) % size.width;
//       double y = (leaf.dy * size.height + animationValue * size.height * leaf.speed * 100) % size.height;
//       canvas.drawOval(
//           Rect.fromCenter(center: Offset(x, y), width: leaf.size, height: leaf.size * 0.6),
//           paint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant LeavesPainter oldDelegate) => true;
// }

