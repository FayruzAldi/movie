import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/controllers/task_controller.dart';
import 'package:movie/controllers/main_controller.dart';
import 'package:movie/bindings/main_binding.dart';
import 'package:movie/pages/bookmarks_page.dart';
import 'package:movie/pages/home_page.dart';
import 'package:movie/pages/login_page.dart';
import 'package:movie/pages/profile_page.dart';
import 'package:movie/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inisialisasi controllers
  await Get.putAsync(() => TaskController().init());
  Get.put(MainController());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
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
      home: SplashScreen(),
      initialBinding: MainBinding(),
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/home', page: () => HomePage(), binding: MainBinding()),
        GetPage(name: '/profile', page: () => ProfilePage(), binding: MainBinding()),
        GetPage(name: '/bookmarks', page: () => BookmarksPage()),
      ],
    );
  }
}
