import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Tambahkan impor ini
import 'package:movie/bindings/main_binding.dart';
import 'package:movie/pages/home_page.dart';
import 'package:movie/pages/login_page.dart';
import 'package:movie/pages/profile_page.dart';
import 'package:movie/pages/splash_screen.dart';
import 'package:movie/pages/bookmarks_page.dart'; // Tambahkan impor ini
import 'package:movie/controllers/task_controller.dart';

void main() {
  // Inisialisasi databaseFactory
  databaseFactory = databaseFactoryFfi;

  // Pastikan SQLite diinisialisasi sebelum menjalankan aplikasi
  sqfliteFfiInit(); // Tambahkan ini untuk inisialisasi FFI

  Get.put(TaskController()); // Inisialisasi TaskController

  runApp(const MyApp()); // Menjalankan aplikasi MyApp
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
      home: SplashScreen(), // Halaman awal adalah SplashScreen
      initialBinding: MainBinding(),
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),  // Splash screen as the initial route
        GetPage(name: '/login', page: () => LoginPage()), // Login page route
        GetPage(name: '/home', page: () => HomePage(), binding: MainBinding()), // Home page route
        GetPage(name: '/profile', page: () => ProfilePage(), binding: MainBinding()), // Profile page route
        GetPage(name: '/bookmarks', page: () => BookmarksPage()), // Rute untuk Bookmarks
      ],
    );
  }
}
