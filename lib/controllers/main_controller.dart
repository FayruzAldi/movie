import 'package:get/get.dart';
import '../models/task_model.dart';
import '../models/favorite_movie_model.dart';
import '../controllers/task_controller.dart';

class MainController extends GetxController {
  var username = ''.obs; // Menyimpan username
  var password = ''.obs; // Menyimpan password
  List<TaskModel> movieList = [];
  List<FavoriteMovieModel> favoriteMovies = [];
  TaskController dbHelper = Get.find<TaskController>();

  @override
  void onInit() {
    fetchMoviesFromDb();
    fetchFavoriteMoviesFromDb();
    super.onInit();
  }

  void fetchMoviesFromDb() async {
    var movies = await dbHelper.fetchMovies();
    movieList = movies;
    updateFavoriteStatus();
    update();
  }

  void loadDummyMovies() {
    movieList.addAll([
      TaskModel(
        id: 1,
        title: 'Antman',
        description: 'Deskripsi Antman',
        imageUrl: 'lib/assets/antman.png',
        isFavorite: false,
      ),
      TaskModel(
        id: 2,
        title: 'Black Panther',
        description: 'Deskripsi Black Panther',
        imageUrl: 'lib/assets/blackpanther.png',
        isFavorite: false,
      ),
      // Tambahkan film lainnya...
    ]);
  }

  void fetchFavoriteMoviesFromDb() async {
    var favorites = await dbHelper.fetchFavoriteMovies();
    favoriteMovies = favorites;
    updateFavoriteStatus();
    update();
  }

  void updateFavoriteStatus() {
    for (var movie in movieList) {
      movie.isFavorite = favoriteMovies.any((fav) => fav.id == movie.id);
    }
    update();
  }

  void addMovie(TaskModel task) async {
    await dbHelper.addMovie(task);
    fetchMoviesFromDb();
  }

  void deleteMovie(int id) async {
    await dbHelper.deleteMovie(id);
    fetchMoviesFromDb();
  }

  void updateMovie(TaskModel task) async {
    await dbHelper.updateMovie(task);
    fetchMoviesFromDb();
  }

  void logout() {}

  void addMovieToFavorites(FavoriteMovieModel movie) async {
    await dbHelper.addFavoriteMovie(movie);
    fetchFavoriteMoviesFromDb();
  }

  void deleteMovieFromFavorites(int id) async {
    await dbHelper.deleteFavoriteMovie(id);
    fetchFavoriteMoviesFromDb();
  }

  void toggleFavorite(TaskModel movie) async {
    try {
      if (movie.isFavorite) {
        await dbHelper.deleteFavoriteMovie(movie.id!);
        favoriteMovies.removeWhere((fav) => fav.id == movie.id);
      } else {
        FavoriteMovieModel favMovie = FavoriteMovieModel(
          id: movie.id!,
          title: movie.title,
          description: movie.description,
          imageUrl: movie.imageUrl,
        );
        await dbHelper.addFavoriteMovie(favMovie);
        favoriteMovies.add(favMovie);
      }
      movie.isFavorite = !movie.isFavorite;
      await dbHelper.updateMovie(movie);
      updateFavoriteStatus();
    } catch (e) {
      print("Error toggling favorite: $e");
      Get.snackbar("Error", "Gagal mengubah status favorit");
    }
  }

  void loadMovies() {
    // Tambahkan beberapa film dummy untuk pengujian
    movieList.addAll([
      TaskModel(
        id: 1,
        title: 'Film 1',
        description: 'Deskripsi Film 1',
        imageUrl: 'assets/images/movie1.jpg',
        isFavorite: false,
      ),
      TaskModel(
        id: 2,
        title: 'Film 2',
        description: 'Deskripsi Film 2',
        imageUrl: 'assets/images/movie2.jpg',
        isFavorite: false,
      ),
      // Tambahkan lebih banyak film jika diperlukan
    ]);
  }
}
