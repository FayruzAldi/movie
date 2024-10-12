import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import 'movie_detail_page.dart';

class BookmarksPage extends StatelessWidget {
  final MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
      ),
      body: Obx(() {
        final favoriteMovies = mainController.movieList.where((movie) => movie.isFavorite).toList();
        return favoriteMovies.isNotEmpty
            ? ListView.builder(
                itemCount: favoriteMovies.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(favoriteMovies[index].title),
                    subtitle: Text(favoriteMovies[index].description),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Konfirmasi sebelum menghapus
                        Get.defaultDialog(
                          title: 'Hapus Favorit',
                          middleText: 'Apakah Anda yakin ingin menghapus film ini dari favorit?',
                          onConfirm: () {
                            mainController.deleteMovie(favoriteMovies[index].id!);
                            Get.back(); // Tutup dialog
                          },
                          onCancel: () {
                            Get.back(); // Tutup dialog
                          },
                        );
                      },
                    ),
                    onTap: () {
                      Get.to(() => MovieDetailPage(movie: favoriteMovies[index]));
                    },
                  );
                },
              )
            : Center(child: Text('Tidak ada film favorit.'));
      }),
    );
  }
}
