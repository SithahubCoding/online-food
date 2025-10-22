import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cart_screen.dart';
class NotificationScreen  extends StatelessWidget{
  const NotificationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Notification List",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Row(
              children: [
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
      ),
    );
  }
}