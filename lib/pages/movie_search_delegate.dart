import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';

class MovieSearchDelegate extends SearchDelegate {
  final MainController mainController;

  MovieSearchDelegate(this.mainController);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Kosongkan input pencarian
          mainController.clearSearchResults(); // Kosongkan hasil pencarian
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        mainController.clearSearchResults(); // Kosongkan hasil pencarian saat tombol back ditekan
        close(context, null); // Tutup halaman pencarian
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mainController.searchMovies(query); // Panggil fungsi pencarian dengan query terbaru
    });

    return Obx(() {
      if (mainController.searchResults.isEmpty) {
        return const Center(child: Text('No results found.'));
      }
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
                mainController.toggleLove(index); // Toggle 'loved' status
              },
            ),
          );
        },
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mainController.searchMovies(query); // Panggil fungsi pencarian dengan query terbaru
    });

    return Obx(() {
      if (mainController.searchResults.isEmpty) {
        return const Center(child: Text('No suggestions available.'));
      }
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
                mainController.toggleLove(index); // Toggle 'loved' status
              },
            ),
          );
        },
      );
    });
  }
}
