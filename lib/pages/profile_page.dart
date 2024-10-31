import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/widgets/custom_bottom_navigation_bar.dart';
import '../controllers/main_controller.dart';
import 'home_page.dart';
import 'bookmarks_page.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  final MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('lib/assets/profile.png'),
                    ),
                    SizedBox(height: 16),
                    Text(
                      mainController.username.value,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'asd@gmail.com',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Edit Profil'),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  // Implementasi untuk mengedit profil
                },
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notifikasi'),
                trailing: Switch(
                  value: true, // Ganti dengan nilai sebenarnya dari controller
                  onChanged: (bool value) {
                    // Implementasi untuk mengubah pengaturan notifikasi
                  },
                ),
              ),
              ListTile(
                leading: Icon(Icons.language),
                title: Text('Bahasa'),
                trailing: Text('Bahasa Indonesia'), // Ganti dengan bahasa yang dipilih
                onTap: () {
                  // Implementasi untuk mengubah bahasa
                },
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text('Bantuan & Dukungan'),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  // Implementasi untuk halaman bantuan
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('Tentang Aplikasi'),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  // Implementasi untuk halaman tentang aplikasi
                },
              ),
              SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  child: Text('Keluar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  onPressed: () {
                    // Logika untuk keluar
                    mainController.username.value = '';
                    mainController.password.value = '';
                    Get.offAll(() => LoginPage());
                  },
                ),
              ),
            ],
          ),
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
