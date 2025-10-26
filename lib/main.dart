import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/views/spash_screen.dart';
import 'app/theme/custom_colors.dart';
import './app/bindings/initial_binding.dart';
import 'app/controllers/language_controller.dart';
import 'app/translations/en_US.dart';
import 'app/translations/km_KH.dart';
import 'routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Color lightThemeAccent = const Color(0xFFffe699);
  final Color darkThemeAccent = const Color(0xFF1d1b20);

  final LanguageController langController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        initialBinding: InitialBinding(),
        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.grey[100],
          extensions: <ThemeExtension<dynamic>>[
            CustomColors(accentColor: lightThemeAccent, darkTextColor: Colors.black),
          ],
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color.fromARGB(255, 39, 2, 2),
          extensions: <ThemeExtension<dynamic>>[
            CustomColors(accentColor: const Color.fromARGB(255, 246, 244, 240), darkTextColor: const Color.fromARGB(255, 10, 0, 0)),
          ],
        ),
        themeMode: ThemeMode.system,
        translations: MyTranslations(),
        locale: langController.currentLocale.value,
        fallbackLocale: const Locale('en', 'US'),
        home: const CustomSplashScreen(),
        getPages: AppPages.pages,
      ),
    );
  }
}

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'en_US': enUS, 'km_KH': kmKH};
}
