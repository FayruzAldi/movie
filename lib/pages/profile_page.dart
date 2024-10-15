import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/widgets/custom_bottom_navigation_bar.dart';
import '../controllers/main_controller.dart';
import 'home_page.dart';
import 'bookmarks_page.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  final MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('lib/assets/profile.png'), // Menggunakan lib/assets/image.png
            ),
            SizedBox(height: 20),
            Text(
              mainController.username.value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              child: Text('Keluar'),
              onPressed: () {
                // Logika untuk keluar
                mainController.username.value = '';
                mainController.password.value = '';
                Get.offAll(() => LoginPage());
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Get.to(() => HomePage());
          } else if (index == 1) {
            Get.to(() => BookmarksPage());
          } else if (index == 2) {
            Get.to(() => ProfilePage());
          }
        },
      ),
    );
  }
}
