import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import '../widgets/movie_item.dart'; // Impor widget MovieItem
import '../pages/login_page.dart'; // Impor halaman Login

class MyListPage extends StatelessWidget {
  final MainController controller = Get.find<MainController>();

  MyListPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Saya'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search), // Tombol pencarian
            onPressed: () async {
              // Tampilkan loading screen dengan latar belakang hitam
              Get.dialog(
                Center(
                  child: CircularProgressIndicator(),
                ),
                barrierColor: Colors.black54, // Latar belakang hitam
                barrierDismissible: false,
              );
              // Simulasi loading
              await Future.delayed(Duration(seconds: 2));
              Get.back(); // Tutup loading screen
              Get.to(LoginPage()); // Arahkan ke halaman login
            },
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.lovedMovies.length,
          itemBuilder: (context, index) {
            final movie = controller.lovedMovies[index];
            return MovieItem(movie: movie, index: index); // Gunakan widget MovieItem
          },
        ),
      ),
    );
  }
}