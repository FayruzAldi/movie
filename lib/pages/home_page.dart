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
          // Ganti CarouselSlider dengan kode berikut
          Obx(() {
            return CarouselSlider(
              options: CarouselOptions(
                height: 300.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              items: mainController.movieList.map((movie) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => MovieDetailPage(movie: movie));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(movie.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  movie.description,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          }),
          // Daftar film yang sudah ada
          Expanded(
            child: Obx(() {
              return mainController.movieList.isNotEmpty
                  ? ListView.builder(
                      itemCount: mainController.movieList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.asset(
                            mainController.movieList[index].imageUrl,
                            width: 50,
                            height: 75,
                            fit: BoxFit.cover,
                          ),
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
                                mainController.deleteMovieFromFavorites(mainController.movieList[index].id!);
                              } else {
                                mainController.addMovieToFavorites(FavoriteMovieModel(
                                  id: mainController.movieList[index].id ?? 0,
                                  title: mainController.movieList[index].title,
                                  description: mainController.movieList[index].description,
                                  imageUrl: mainController.movieList[index].imageUrl, // Pastikan ini benar
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
