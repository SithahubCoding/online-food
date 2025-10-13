import 'package:flutter/material.dart';
import 'package:get/get.dart';
class FavoriteScreen  extends StatelessWidget{
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
          "Favorite List",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Row(
              children: const [
                Icon(Icons.notifications),
                SizedBox(width: 12),
                Icon(Icons.shopping_cart),
              ],
            ),
          ),
        ],
      ),
    );
  }
}