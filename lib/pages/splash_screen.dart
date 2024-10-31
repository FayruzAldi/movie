import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed('/login'); // Pindah ke halaman login setelah 3 detik
    });

    return const Scaffold(
      body: Center(
        child: Text(
          'Motify',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
