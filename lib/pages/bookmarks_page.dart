import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import 'movie_detail_page.dart';
import 'home_page.dart';
import 'profile_page.dart';
import '../models/favorite_movie_model.dart';
import '../models/task_model.dart';

class BookmarksPage extends StatelessWidget {
  final MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        return mainController.favoriteMovies.isNotEmpty
            ? ListView.builder(
                itemCount: mainController.favoriteMovies.length,
                itemBuilder: (context, index) {
                  FavoriteMovieModel favoriteMovie = mainController.favoriteMovies[index];
                  // Cari film yang sesuai di movieList
                  TaskModel? originalMovie = mainController.movieList.firstWhere(
                    (movie) => movie.id == favoriteMovie.id,
                    orElse: () => TaskModel(
                      id: favoriteMovie.id,
                      title: favoriteMovie.title,
                      description: favoriteMovie.description,
                      imageUrl: favoriteMovie.imageUrl,
                      isFavorite: true,
                    ),
                  );
                  return ListTile(
                    leading: Image.asset(
                      originalMovie.imageUrl,
                      width: 50,
                      height: 75,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        print('Error loading image: ${originalMovie.imageUrl}');
                        return Image.asset(
                          'lib/assets/image.png',
                          width: 50,
                          height: 75,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    title: Text(originalMovie.title),
                    subtitle: Text(originalMovie.description),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        Get.defaultDialog(
                          title: 'Hapus Favorit',
                          middleText: 'Apakah Anda yakin ingin menghapus film ini dari favorit?',
                          onConfirm: () {
                            mainController.deleteMovieFromFavorites(favoriteMovie.id);
                            Get.back(); // Ini akan menutup dialog
                          },
                          onCancel: () {
                            // Hapus Get.back() di sini
                            // Tidak perlu melakukan apa-apa saat membatalkan
                          },
                        );
                      },
                    ),
                    onTap: () {
                      Get.to(() => MovieDetailPage(movie: originalMovie));
                    },
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
        currentIndex: 1,
        onTap: (index) {
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
