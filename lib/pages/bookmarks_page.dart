import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import 'movie_detail_page.dart';
import 'home_page.dart';
import 'profile_page.dart';
import '../models/favorite_movie_model.dart';
import '../models/task_model.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/movie_list_tile.dart';
import '../widgets/custom_bottom_navigation_bar.dart';

class BookmarksPage extends StatelessWidget {
  final MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Bookmarks',
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        return mainController.favoriteMovies.isNotEmpty
            ? ListView.builder(
                itemCount: mainController.favoriteMovies.length,
                itemBuilder: (context, index) {
                  FavoriteMovieModel favoriteMovie = mainController.favoriteMovies[index];
                  TaskModel originalMovie = mainController.movieList.firstWhere(
                    (movie) => movie.id == favoriteMovie.id,
                    orElse: () => TaskModel(
                      id: favoriteMovie.id,
                      title: favoriteMovie.title,
                      description: favoriteMovie.description,
                      imageUrl: favoriteMovie.imageUrl,
                      isFavorite: true,
                    ),
                  );
                  return MovieListTile(
                    movie: originalMovie,
                    isFavorite: true,
                    onTap: () {
                      Get.to(() => MovieDetailPage(movie: originalMovie));
                    },
                    onFavoriteToggle: () {
                      Get.defaultDialog(
                        title: 'Hapus Favorit',
                        middleText: 'Apakah Anda yakin ingin menghapus film ini dari favorit?',
                        onConfirm: () {
                          mainController.deleteMovieFromFavorites(favoriteMovie.id);
                          Get.back();
                        },
                        onCancel: () {
                          // Tidak perlu melakukan apa-apa saat membatalkan
                        },
                      );
                    },
                    trailingIcon: Icons.delete, // Mengganti ikon hati dengan ikon tong sampah
                  );
                },
              )
            : Center(child: Text('Tidak ada film favorit.'));
      }),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
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
