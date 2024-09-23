import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/main_controller.dart';
import 'home_page.dart';
import 'search_page.dart';
import 'favorite_page.dart';
import 'profile_page.dart';

void main() {
  // Inisialisasi MainController
  Get.put(MainController());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(color: Colors.red, fontSize: 20),
        ),
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (Get.find<MainController>().currentIndex.value) {
          case 0:
            return const HomePage();
          case 1:
            return const SearchPage();
          case 2:
            return const FavoritePage();
          case 3:
            return const ProfilePage();
          default:
            return const HomePage();
        }
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.white,
          currentIndex: Get.find<MainController>().currentIndex.value,
          onTap: (index) {
            Get.find<MainController>().currentIndex.value = index;
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        );
      }),
    );
  }
}
