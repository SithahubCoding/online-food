// import 'package:flutter/material.dart';
// import '../app/views/cart_screen.dart';
// import '../app/views/notification_screen.dart';
// import 'package:get/get.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const CustomAppBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: const Text(
//         "Foodies",
//         style: TextStyle(
//           fontFamily: 'Poppins',
//           fontWeight: FontWeight.bold,
//           fontSize: 25,
//           color: Colors.black87,
//         ),
//       ),
//       actions: [
//         Padding(
//           padding: const EdgeInsets.only(left: 12, right: 12),
//           child: Row(
//             children: [
//               InkWell(
//                 splashColor: Colors.blueAccent, // Customize splash color
//                 onTap: () {
//                   Get.to(() => NotificationScreen());
//                 },
//                 child: Icon(Icons.notifications),
//               ),
//               SizedBox(width: 12),
//               InkWell(
//                 splashColor: Colors.greenAccent,
//                 onTap: () {
//                   Get.to(() => CartScreen());
//                 },
//                 child: Icon(Icons.shopping_cart),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../app/views/cart_screen.dart';
// import '../app/views/notification_screen.dart';
// import '../app/theme/custom_colors.dart';

// class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
//   const CustomAppBar({super.key});

//   @override
//   State<CustomAppBar> createState() => _CustomAppBarState();

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

// class _CustomAppBarState extends State<CustomAppBar>
//     with TickerProviderStateMixin {
//   late AnimationController _iconsController;
//   late Animation<double> _iconsAnimation;

//   @override
//   void initState() {
//     super.initState();

//     // Animation Controller
//     _iconsController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );

//     _iconsAnimation = Tween<double>(
//       begin: 0,
//       end: 1,
//     ).animate(CurvedAnimation(parent: _iconsController, curve: Curves.easeOut));

//     _iconsController.forward();
//   }

//   @override
//   void dispose() {
//     _iconsController.dispose();
//     super.dispose();
//   }

//   Widget _buildAnimatedIcon({
//     required IconData icon,
//     required VoidCallback onTap,
//   }) {
//     return FadeTransition(
//       opacity: _iconsAnimation,
//       child: SlideTransition(
//         position: Tween<Offset>(
//           begin: const Offset(0, 0.5),
//           end: Offset.zero,
//         ).animate(_iconsController),
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(50),
//           child: Ink(
//             padding: const EdgeInsets.all(8),
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.transparent,
//             ),
//             child: Icon(icon, color: Colors.white, size: 26),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final customColors = Theme.of(context).extension<CustomColors>();
//     return AppBar(
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       flexibleSpace: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: Theme.of(context).brightness == Brightness.dark
//                 ? [
//                     Colors.grey.shade800,
//                     Colors.grey.shade900,
//                   ] // Dark mode gradient
//                 : [Color(0xFFFFC107), Color(0xFFFF6F00)], // Light mode gradient
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//       ),
//       title: Text(
//         "Foodies",
//         style: TextStyle(
//           fontFamily: 'Serif',
//           fontWeight: FontWeight.bold,
//           fontSize: 26,
//           color: Theme.of(context).brightness == Brightness.dark
//               ? Colors
//                     .white // Dark mode font color
//               : Colors.white, // Light mode font color (អាចប្តូរ)
//         ),
//       ),
//       actions: [
//         IconButton(
//           icon: Icon(
//             Icons.notifications,
//             color: Theme.of(context).brightness == Brightness.dark
//                 ? Colors.white
//                 : Colors.white,
//           ),
//           onPressed: () => Get.to(() => NotificationScreen()),
//         ),
//         IconButton(
//           icon: Icon(
//             Icons.shopping_cart,
//             color: Theme.of(context).brightness == Brightness.dark
//                 ? Colors.white
//                 : Colors.white,
//           ),
//           onPressed: () => Get.to(() => CartScreen()),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app/views/cart_screen.dart';
import '../app/views/notification_screen.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar>
    with TickerProviderStateMixin {
  late AnimationController _iconsController;
  late Animation<double> _iconsAnimation;

  @override
  void initState() {
    super.initState();
    _iconsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _iconsAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _iconsController, curve: Curves.easeOut),
    );
    _iconsController.forward();
  }

  @override
  void dispose() {
    _iconsController.dispose();
    super.dispose();
  }

  Widget _buildAnimatedIcon({required IconData icon, required VoidCallback onTap}) {
    return FadeTransition(
      opacity: _iconsAnimation,
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero)
            .animate(_iconsController),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(50),
          child: Ink(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle, 
              color: Colors.transparent
            ),
            child: Icon(icon, color: Colors.white, size: 26),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      // រក្សា background color ជា Color(0xFFFF6F00) ទាំង Dark & Light mode
      backgroundColor: const Color(0xFFFF6F00),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFC107), Color(0xFFFF6F00)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      title: const Text(
        "Foodies",
        style: TextStyle(
          fontFamily: 'Serif',
          fontWeight: FontWeight.bold,
          fontSize: 26,
          color: Colors.white,
          shadows: [
            Shadow(
              color: Colors.black26,
              offset: Offset(1, 1),
              blurRadius: 2,
            ),
          ],
        ),
      ),
      actions: [
        _buildAnimatedIcon(
          icon: Icons.notifications,
          onTap: () => Get.to(() => NotificationScreen()),
        ),
        _buildAnimatedIcon(
          icon: Icons.shopping_cart,
          onTap: () => Get.to(() => CartScreen()),
        ),
      ],
    );
  }
}
