import 'package:get/get.dart';

class MainController extends GetxController {
  var currentIndex = 0.obs;
  var isLoggedIn = false.obs;
  var username = ''.obs;
  
  final RxList<Map<String, dynamic>> dummyMovies = <Map<String, dynamic>>[
    {'title': 'Inception', 'description': 'Film sci-fi tentang mimpi', 'rating': 4.8, 'image': 'https://via.placeholder.com/150', 'isLoved': false},
    {'title': 'The Shawshank Redemption', 'description': 'Drama tentang perjuangan di penjara', 'rating': 4.9, 'image': 'https://via.placeholder.com/150', 'isLoved': false},
    {'title': 'The Dark Knight', 'description': 'Film superhero Batman', 'rating': 4.7, 'image': 'https://via.placeholder.com/150', 'isLoved': false},
    {'title': 'Pulp Fiction', 'description': 'Film crime dengan alur non-linear', 'rating': 4.6, 'image': 'https://via.placeholder.com/150', 'isLoved': false},
    {'title': 'Forrest Gump', 'description': 'Drama komedi tentang perjalanan hidup', 'rating': 4.8, 'image': 'https://via.placeholder.com/150', 'isLoved': false},
    {'title': 'The Matrix', 'description': 'Film sci-fi tentang realitas virtual', 'rating': 4.7, 'image': 'https://via.placeholder.com/150', 'isLoved': false},
    {'title': 'Goodfellas', 'description': 'Film gangster klasik', 'rating': 4.7, 'image': 'https://via.placeholder.com/150', 'isLoved': false},
    {'title': 'The Silence of the Lambs', 'description': 'Thriller psikologis', 'rating': 4.6, 'image': 'https://via.placeholder.com/150', 'isLoved': false},
  ].obs;

  var searchResults = <Map<String, dynamic>>[].obs;

  List<Map<String, dynamic>> get lovedMovies => dummyMovies.where((movie) => movie['isLoved'] as bool).toList();

  void changeTab(int index) {
    currentIndex.value = index;
  }

  void toggleLove(int index) {
    final movie = dummyMovies[index];
    movie['isLoved'] = !(movie['isLoved'] as bool);
    dummyMovies[index] = movie;
  }

  void login(String user) {
    isLoggedIn.value = true;
    username.value = user;
  }

  void logout() {
    isLoggedIn.value = false;
    username.value = '';
    currentIndex.value = 0;
  }

  void searchMovies(String query) {
    searchResults.value = dummyMovies.where((movie) => 
      movie['title'].toString().toLowerCase().contains(query.toLowerCase()) ||
      movie['description'].toString().toLowerCase().contains(query.toLowerCase())
    ).toList();
  }
}