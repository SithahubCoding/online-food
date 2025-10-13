import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/views/spash_screen.dart';
import 'app/theme/custom_colors.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final Color lightThemeAccent = const Color(0xFFffe699);
  final Color darkThemeAccent = const Color(0xFF1d1b20);
  @override

  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
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
      home: CustomSplashScreen(),
    );
  }
}
