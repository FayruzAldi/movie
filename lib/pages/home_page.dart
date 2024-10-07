import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:movie/controllers/main_controller.dart';
import 'package:movie/pages/movie_search_delegate.dart';
import 'package:movie/pages/profile_page.dart';

class HomePage extends StatelessWidget {
  final MainController mainController = Get.put(MainController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          // Change title based on the current tab
          switch (mainController.currentIndex.value) {
            case 0:
              return const Text('Home Page');
            case 1:
              return const Text('My List');
            case 2:
              return const Text('Profile Page');
            default:
              return const Text('Home Page');
          }
        }),
        actions: [
          Obx(() {
            // Show search icon only on 'Home' and 'My List' tabs
            if (mainController.currentIndex.value != 2) {
              return IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: MovieSearchDelegate(mainController),
                  );
                },
              );
            } else {
              return const SizedBox(); // Hide icon on Profile page
            }
          }),
        ],
      ),
      body: Obx(() {
        switch (mainController.currentIndex.value) {
          case 0:
            return ListView.builder(
              itemCount: mainController.searchResults.length,
              itemBuilder: (context, index) {
                final movie = mainController.searchResults[index];
                return ListTile(
                  leading: Image.network(movie['image']),
                  title: Text(movie['title']),
                  subtitle: Text(movie['description']),
                  trailing: IconButton(
                    icon: Icon(
                      movie['isLoved'] ? Icons.favorite : Icons.favorite_border,
                      color: movie['isLoved'] ? Colors.red : null,
                    ),
                    onPressed: () {
                      mainController.toggleLove(index);
                    },
                  ),
                );
              },
            );
          case 1:
            return ListView.builder(
              itemCount: mainController.lovedMovies.length,
              itemBuilder: (context, index) {
                final movie = mainController.lovedMovies[index];
                return ListTile(
                  leading: Image.network(movie['image']),
                  title: Text(movie['title']),
                  subtitle: Text(movie['description']),
                  trailing: IconButton(
                    icon: Icon(
                      movie['isLoved'] ? Icons.favorite : Icons.favorite_border,
                      color: movie['isLoved'] ? Colors.red : null,
                    ),
                    onPressed: () {
                      mainController.toggleLove(index);
                    },
                  ),
                );
              },
            );
          case 2:
            return ProfilePage(); // Halaman profil
          default:
            return const Center(child: Text('Home'));
        }
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: mainController.currentIndex.value,
          onTap: (index) {
            mainController.changeTab(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'My List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        );
      }),
    );
  }
}
