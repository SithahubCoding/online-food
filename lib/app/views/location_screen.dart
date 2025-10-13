import 'package:flutter/material.dart';
import '../models/food_model.dart';
import 'package:get/get.dart';
import './home_screen.dart';
class LocationSCreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
            Get.to(() => HomeScreen());
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Location",
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