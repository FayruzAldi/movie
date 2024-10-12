import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import 'home_page.dart'; // Pastikan untuk mengimpor halaman tujuan

class LoginPage extends StatelessWidget {
  final MainController mainController = Get.find();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                login();
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  void login() {
    String username = usernameController.text;
    String password = passwordController.text;
    if (username.isNotEmpty && password.isNotEmpty) {
      mainController.username.value = username;
      mainController.password.value = password;
      // Navigasi ke halaman Home setelah login
      Get.offAllNamed('/home'); // Menggunakan GetX untuk navigasi
    } else {
      Get.snackbar('Error', 'Username and password cannot be empty');
    }
  }
}
