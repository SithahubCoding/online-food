import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'package:get/get.dart';
import 'home/home_screen.dart';
import 'category_one.dart';
import './cart_screen.dart';
import './notification_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
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
          "Food Category",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
      ),
      body: SingleChildScrollView(
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), // Disable GridView scroll
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          itemCount: categories.length, // Don't forget itemCount
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => CategoryOne(category: categories[index]));
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Image.asset("${categories[index].icon}"),
                    SizedBox(height: 10),
                    Text("${categories[index].name}"),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
