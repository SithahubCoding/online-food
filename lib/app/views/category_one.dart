import 'package:flutter/material.dart';
import '../models/food_model.dart';
import 'package:get/get.dart';
import './home_screen.dart';
import '../models/food_model.dart';
import './category_screen.dart';
import './detail_screen.dart';
class CategoryOne extends StatelessWidget{
  final CategoryModel category; 
  CategoryOne({required this.category});
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text("${category.name} Subcategories"),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemCount: category.subCategories.length,
        itemBuilder: (context, index){
          final sub = category.subCategories[index];
          return GestureDetector(
            onTap: () {
             
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.asset("${sub.icon}"),
                  SizedBox(height: 10),
                  Text("${sub.name}"),

                ],
              ),
            )
          );
        }
      ),

     );
  }
}
