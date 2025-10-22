import 'package:flutter/material.dart';
import '../app/views/cart_screen.dart';
import '../app/views/notification_screen.dart';
import 'package:get/get.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Foodies"),
      actions: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Row(
              children: [
                InkWell(
                  splashColor: Colors.blueAccent, // Customize splash color
                  onTap: () {
                    Get.to(() => NotificationScreen());
                  },
                  child: Icon(Icons.notifications),
                ),
                SizedBox(width: 12),
                InkWell(
                  splashColor: Colors.greenAccent,
                  onTap: () {
                    Get.to(() => CartScreen());
                  },
                  child: Icon(Icons.shopping_cart),
                ),
              ],
            ),
          ),
        ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
