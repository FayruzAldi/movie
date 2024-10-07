import 'package:get/get.dart';

class MainController extends GetxController {
  var currentIndex = 0.obs;
  var isLoggedIn = false.obs;
  var username = ''.obs;
  
  final RxList<Map<String, dynamic>> dummyMovies = <Map<String, dynamic>>[
    {
      'title': 'Inception',
      'description': 'Film sci-fi tentang mimpi',
      'rating': 4.8,
      'image': 'https://play-lh.googleusercontent.com/buKf27Hxendp3tLNpNtP3E-amP0o4yYV-SGKyS2u-Y3GdGRTyfNCIT5WAVs2OudOz6so5K1jtYdAUKI9nw8',
      'isLoved': false
    },
    {
      'title': 'The Shawshank Redemption',
      'description': 'Drama tentang perjuangan di penjara',
      'rating': 4.9,
      'image': 'https://m.media-amazon.com/images/M/MV5BMDAyY2FhYjctNDc5OS00MDNlLThiMGUtY2UxYWVkNGY2ZjljXkEyXkFqcGc@._V1_.jpg',
      'isLoved': false
    },
    {
      'title': 'The Dark Knight',
      'description': 'Film superhero Batman',
      'rating': 4.7,
      'image': 'https://m.media-amazon.com/images/S/pv-target-images/e9a43e647b2ca70e75a3c0af046c4dfdcd712380889779cbdc2c57d94ab63902.jpg',
      'isLoved': false
    },
    {
      'title': 'Pulp Fiction',
      'description': 'Film crime dengan alur non-linear',
      'rating': 4.6,
      'image': 'https://musicart.xboxlive.com/7/767c6300-0000-0000-0000-000000000002/504/image.jpg?w=1920&h=1080',
      'isLoved': false
    },
    {
      'title': 'Forrest Gump',
      'description': 'Drama komedi tentang perjalanan hidup',
      'rating': 4.8,
      'image': 'https://m.media-amazon.com/images/M/MV5BNWIwODRlZTUtY2U3ZS00Yzg1LWJhNzYtMmZiYmEyNmU1NjMzXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_FMjpg_UX1000_.jpg',
      'isLoved': false
    },
    {
      'title': 'The Matrix',
      'description': 'Film sci-fi tentang dunia virtual',
      'rating': 4.7,
      'image': 'https://m.media-amazon.com/images/I/613ypTLZHsL._AC_UF894,1000_QL80_.jpg',
      'isLoved': false
    },
    {
      'title': 'Interstellar',
      'description': 'Film sci-fi tentang perjalanan luar angkasa',
      'rating': 4.6,
      'image': 'https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p10543523_p_v8_as.jpg',
      'isLoved': false
    },
    {
      'title': 'Gladiator',
      'description': 'Film epik tentang pejuang Romawi',
      'rating': 4.5,
      'image': 'https://upload.wikimedia.org/wikipedia/en/f/fb/Gladiator_%282000_film_poster%29.png',
      'isLoved': false
    },
    {
      'title': 'The Godfather',
      'description': 'Film tentang keluarga mafia',
      'rating': 4.9,
      'image': 'https://play-lh.googleusercontent.com/ZucjGxDqQ-cHIN-8YA1HgZx7dFhXkfnz73SrdRPmOOHEax08sngqZMR_jMKq0sZuv5P7-T2Z2aHJ1uGQiys',
      'isLoved': false
    },
    {
      'title': 'Fight Club',
      'description': 'Film tentang klub pertarungan rahasia',
      'rating': 4.8,
      'image': 'https://m.media-amazon.com/images/M/MV5BOTgyOGQ1NDItNGU3Ny00MjU3LTg2YWEtNmEyYjBiMjI1Y2M5XkEyXkFqcGc@._V1_.jpg',
      'isLoved': false
    },
    {
      'title': 'The Lord of the Rings: The Fellowship of the Ring',
      'description': 'Film fantasi tentang perjalanan epik',
      'rating': 4.8,
      'image': 'https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p28828_p_v8_ao.jpg',
      'isLoved': false
    },
    {
      'title': 'Star Wars: Episode IV - A New Hope',
      'description': 'Film sci-fi tentang perang bintang',
      'rating': 4.7,
      'image': 'https://m.media-amazon.com/images/S/pv-target-images/4a48991096eef46e47ecb17a0a677c46d7d7607aedaec7b67447645bee668816.jpg',
      'isLoved': false
    },
    {
      'title': 'The Lion King',
      'description': 'Film animasi tentang petualangan singa',
      'rating': 4.8,
      'image': 'https://m.media-amazon.com/images/S/pv-target-images/2c6bf6218aa296881bfba2aa6838a21a8bf768d844ad4522fe9931cdcb7a9f33.jpg',
      'isLoved': false
    },
    {
      'title': 'Jurassic Park',
      'description': 'Film sci-fi tentang taman dinosaurus',
      'rating': 4.7,
      'image': 'https://play-lh.googleusercontent.com/BVSejbKFir0thw8OmJKsWL-uDexGT9LDwSOcDuGE7vTC13b2JxjBHGzby7suSzvzziI',
      'isLoved': false
    },
    {
      'title': 'The Avengers',
      'description': 'Film superhero tentang tim Avengers',
      'rating': 4.6,
      'image': 'https://m.media-amazon.com/images/M/MV5BNGE0YTVjNzUtNzJjOS00NGNlLTgxMzctZTY4YTE1Y2Y1ZTU4XkEyXkFqcGc@._V1_.jpg',
      'isLoved': false
    },
  ].obs;

  var searchResults = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    searchResults.assignAll(dummyMovies);
  }

  List<Map<String, dynamic>> get lovedMovies => dummyMovies.where((movie) => movie['isLoved'] as bool).toList();

  void changeTab(int index) {
    currentIndex.value = index;
  }

  void toggleLove(int index) {
    final movie = dummyMovies[index];
    movie['isLoved'] = !(movie['isLoved'] as bool);
    dummyMovies[index] = movie;
    dummyMovies.refresh();
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
    if (query.isEmpty) {
      searchResults.assignAll(dummyMovies);
    } else {
      searchResults.assignAll(dummyMovies.where((movie) => 
        movie['title'].toString().toLowerCase().contains(query.toLowerCase()) ||
        movie['description'].toString().toLowerCase().contains(query.toLowerCase())
      ).toList());
    }
  }

  void clearSearchResults() {
    searchResults.assignAll(dummyMovies); // Reset hasil pencarian ke semua film
  }
}