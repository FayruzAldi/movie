import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import 'movie_detail_page.dart'; // Impor halaman detail film

class HomePage extends StatelessWidget {
  final MainController mainController = Get.find(); // Mengambil instance MainController
  int _selectedIndex = 0; // Menyimpan indeks yang dipilih

  void _onItemTapped(int index) {
    _selectedIndex = index;
    if (index == 1) {
      Get.toNamed('/bookmarks'); // Navigasi ke halaman bookmarks
    } else if (index == 2) {
      Get.toNamed('/profile'); // Navigasi ke halaman profile
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
          // Slider Gambar
          Container(
            height: 200, // Atur tinggi sesuai kebutuhan
            child: PageView(
              children: [
                Image.asset('lib/assets/image.png'), // Gambar placeholder
                Image.asset('lib/assets/image.png'), // Gambar placeholder
                Image.asset('lib/assets/image.png'), // Gambar placeholder
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Obx(() {
                return mainController.movieList.isNotEmpty // Cek apakah ada film
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
                              ),
                              onPressed: () {
                                // Toggle favorit
                                mainController.movieList[index].isFavorite =
                                    !mainController.movieList[index].isFavorite;
                                // Update di database
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
