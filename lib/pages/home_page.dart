import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/models/favorite_movie_model.dart';
import 'package:movie/pages/bookmarks_page.dart';
import 'package:movie/pages/profile_page.dart';
import '../controllers/main_controller.dart';
import 'movie_detail_page.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Tambahkan import ini

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MainController mainController = Get.find(); // Mengambil instance MainController
  int _selectedIndex = 0; // Menyimpan indeks yang dipilih

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      Get.to(() => BookmarksPage()); // Navigasi ke halaman bookmarks
    } else if (index == 2) {
      Get.to(() => ProfilePage()); // Navigasi ke halaman profile
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Slider'),
      ),
      body: Column(
        children: [
          // Tambahkan CarouselSlider di sini
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
            items: [1,2,3,4,5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                    ),
                    child: Center(
                      child: Text('Slide $i', style: TextStyle(fontSize: 16.0)),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          // Daftar film yang sudah ada
          Expanded(
            child: Obx(() {
              return mainController.movieList.isNotEmpty
                  ? ListView.builder(
                      itemCount: mainController.movieList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(mainController.movieList[index].title),
                          subtitle: Text(mainController.movieList[index].description),
                          trailing: IconButton(
                            icon: Icon(
                              mainController.movieList[index].isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: mainController.movieList[index].isFavorite
                                  ? Colors.red // Mengubah warna menjadi merah jika favorit
                                  : null, // Warna default jika tidak favorit
                            ),
                            onPressed: () {
                              // Toggle favorit
                              if (mainController.movieList[index].isFavorite) {
                                mainController.deleteMovieFromFavorites(mainController.movieList[index].id!); // Tambahkan '!' untuk mengatasi nullability
                              } else {
                                mainController.addMovieToFavorites(FavoriteMovieModel(
                                  id: mainController.movieList[index].id ?? 0, // Menggunakan nilai default 0 jika id null
                                  title: mainController.movieList[index].title,
                                  description: mainController.movieList[index].description,
                                ));
                              }
                              mainController.movieList[index].isFavorite = !mainController.movieList[index].isFavorite;
                              mainController.updateMovie(mainController.movieList[index]);
                            },
                          ),
                          onTap: () {
                            Get.to(() => MovieDetailPage(movie: mainController.movieList[index])); // Navigasi ke halaman detail
                          },
                        );
                      },
                    )
                  : Center(child: Text('Tidak ada film tersedia.')); // Pesan jika tidak ada film
            }),
          ),
        ],
      ),
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
