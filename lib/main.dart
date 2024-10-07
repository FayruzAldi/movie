import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/bindings/main_binding.dart';
import 'package:movie/pages/home_page.dart';
import 'package:movie/pages/login_page.dart';
import 'package:movie/controllers/main_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        hintColor: Colors.red,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          color: Colors.black,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.white,
        ),
      ),
      initialBinding: MainBinding(),
      home: Obx(() {
        final MainController mainController = Get.find();
        return mainController.isLoggedIn.value ? HomePage() : LoginPage();
      }),
    );
  }
}
