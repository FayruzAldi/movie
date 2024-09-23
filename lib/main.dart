import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/main_controller.dart';
import 'pages/home_page.dart';
import 'pages/my_list_page.dart';
import 'pages/profile_page.dart';
import 'pages/login_page.dart';

void main() {
  Get.put(MainController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Aplikasi Film',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      initialRoute: '/login',
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/', page: () => MainPage()),
      ],
    );
  }
}

class MainPage extends StatelessWidget {
  final MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.isLoggedIn.value) {
        return LoginPage();
      }
      return Scaffold(
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: [
            HomePage(),
            MyListPage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
          selectedItemColor: Colors.red, // Warna merah untuk item yang dipilih
          unselectedItemColor: Colors.grey, // Warna abu-abu untuk item yang tidak dipilih
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Daftar Saya'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ],
        )),
      );
    });
  }
}
