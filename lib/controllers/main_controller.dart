import 'package:get/get.dart';
import '../models/task_model.dart';
import '../models/favorite_movie_model.dart';
import '../controllers/task_controller.dart';

class MainController extends GetxController {
  var username = ''.obs; // Menyimpan username
  var password = ''.obs; // Menyimpan password
  var movieList = <TaskModel>[].obs; // Daftar film
  var favoriteMovies = <FavoriteMovieModel>[].obs; // Daftar film favorit
  TaskController dbHelper = TaskController();

  @override
  void onInit() {
    fetchMoviesFromDb();
    fetchFavoriteMoviesFromDb();
    super.onInit();
  }

  void fetchMoviesFromDb() async {
    var movies = await dbHelper.fetchMovies();
    movieList.assignAll(movies);
    updateFavoriteStatus();
  }

  void fetchFavoriteMoviesFromDb() async {
    var favorites = await dbHelper.fetchFavoriteMovies();
    favoriteMovies.assignAll(favorites);
    updateFavoriteStatus();
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

  void toggleFavorite(TaskModel movie) {}
}
