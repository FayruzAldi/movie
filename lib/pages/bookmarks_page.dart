import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import 'movie_detail_page.dart';
import 'home_page.dart';
import 'profile_page.dart';

class BookmarksPage extends StatelessWidget {
  final MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
        automaticallyImplyLeading: false, // Menonaktifkan ikon tanda panah
      ),
      body: Obx(() {
        return mainController.favoriteMovies.isNotEmpty
            ? ListView.builder(
                itemCount: mainController.favoriteMovies.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(mainController.favoriteMovies[index].title),
                    subtitle: Text(mainController.favoriteMovies[index].description),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Konfirmasi sebelum menghapus
                        Get.defaultDialog(
                          title: 'Hapus Favorit',
                          middleText: 'Apakah Anda yakin ingin menghapus film ini dari favorit?',
                          onConfirm: () {
                            mainController.deleteMovieFromFavorites(mainController.favoriteMovies[index].id);
                            Get.back(); // Tutup dialog
                          },
                          onCancel: () {
                            Get.back(); // Tutup dialog
                          },
                        );
                      },
                    ),
                    onTap: null, // Menghilangkan ikon tanda panah
                  );
                },
              )
            : Center(child: Text('Tidak ada film favorit.'));
      }),
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
        currentIndex: 1, // Set index ke 1 untuk Bookmarks
        onTap: (index) {
          // Logika untuk navigasi ke halaman yang sesuai
          if (index == 0) {
            Get.to(() => HomePage());
          } else if (index == 2) {
            Get.to(() => ProfilePage());
          }
        },
      ),
    );
  }
}
