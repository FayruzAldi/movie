import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/pages/bookmarks_page.dart';
import '../controllers/main_controller.dart';
import '../pages/home_page.dart';

class ProfilePage extends StatelessWidget {
  final MainController mainController = Get.find();

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        automaticallyImplyLeading: false, // Menonaktifkan ikon tanda panah
      ),
      body: Center(child: Text('Profile Page')),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 2, // Set index ke 2 untuk Profile
        onTap: (index) {
          // Logika untuk navigasi ke halaman yang sesuai
          if (index == 0) {
            Get.to(() => HomePage());
          } else if (index == 1) {
            Get.to(() => BookmarksPage());
          }
        },
      ),
    );
  }
}
