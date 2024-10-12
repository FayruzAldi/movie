import 'package:get/get.dart';
import '../models/task_model.dart';
import '../controllers/task_controller.dart';

class MainController extends GetxController {
  var username = ''.obs; // Menyimpan username
  var password = ''.obs; // Menyimpan password
  var movieList = <TaskModel>[].obs; // Daftar film
  TaskController dbHelper = TaskController();

  @override
  void onInit() {
    fetchMoviesFromDb();
    super.onInit();
  }

  void fetchMoviesFromDb() async {
    var movies = await dbHelper.fetchMovies();
    movieList.assignAll(movies);
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
}
