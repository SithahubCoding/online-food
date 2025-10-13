import 'package:flutter/material.dart';
import 'package:get/get.dart';
class PoliPrSCreen extends StatelessWidget{
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
          "Privacy Policy",
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
      body: ListView.builder(
        itemBuilder: (context, index){
          
        }
      ),
    );
  }
}