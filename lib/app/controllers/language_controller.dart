import 'package:flutter/material.dart'; // 🟢 ត្រូវមាន
import 'package:get/get.dart';

class LanguageController extends GetxController {
  var currentLocale = const Locale('en', 'US').obs;

  void changeLanguage(String langCode) {
    if (langCode == 'km') {
      currentLocale.value = const Locale('km', 'KH');
      Get.updateLocale(const Locale('km', 'KH'));
    } else {
      currentLocale.value = const Locale('en', 'US');
      Get.updateLocale(const Locale('en', 'US'));
    }
  }
}
