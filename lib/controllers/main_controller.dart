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
    fetchFavoriteMoviesFromDb(); // Ambil film favorit saat inisialisasi
    super.onInit();
  }

  void fetchMoviesFromDb() async {
    var movies = await dbHelper.fetchMovies();
    movieList.assignAll(movies);
  }

  void fetchFavoriteMoviesFromDb() async {
    var favorites = await dbHelper.fetchFavoriteMovies();
    favoriteMovies.assignAll(favorites);
  }

  void addMovie(TaskModel task) async {
    await dbHelper.addMovie(task);
    fetchMoviesFromDb();
  }

  void deleteMovie(int id) async {
    await dbHelper.deleteMovie(id);
    fetchMoviesFromDb(); // Memuat ulang daftar film setelah menghapus
  }

  void updateMovie(TaskModel task) async {
    await dbHelper.updateMovie(task);
    fetchMoviesFromDb(); // Memuat ulang daftar film setelah memperbarui
  }

  void logout() {}

  void deleteMovieFromFavorite(String id) {
    // Hapus film dari daftar favorit
    favoriteMovies.removeWhere((movie) => movie.id == id);
    // Jika Anda ingin menghapus dari movieList, pastikan untuk tidak menghapusnya dari sini
  }

  void updateMovieFromFavorite(TaskModel task) {
    // Logika untuk memperbarui film
    int index = movieList.indexWhere((m) => m.id == task.id);
    if (index != -1) {
      movieList[index] = task;
    }
  }

  void addMovieToFavorites(FavoriteMovieModel movie) async {
    await dbHelper.addFavoriteMovie(movie);
    fetchFavoriteMoviesFromDb(); // Memuat ulang daftar film favorit setelah menambah
  }

  void deleteMovieFromFavorites(int id) async {
    await dbHelper.deleteFavoriteMovie(id);
    
    // Perbarui status isFavorite di movieList
    int index = movieList.indexWhere((movie) => movie.id == id);
    if (index != -1) {
      movieList[index].isFavorite = false; // Set isFavorite menjadi false
      print("Updated movie ${movieList[index].title} to not favorite."); // Log untuk debugging
    }

    fetchFavoriteMoviesFromDb();
  }
}
