import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = Get.isDarkMode.obs;

  void toggleTheme(bool value) {
    isDarkMode.value = value;
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }
}
