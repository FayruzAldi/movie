import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import '../widgets/movie_item.dart';

class HomePage extends StatelessWidget {
  final MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beranda'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: MovieSearchDelegate(controller),
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.dummyMovies.length,
          itemBuilder: (context, index) {
            return MovieItem(index: index);
          },
        );
      }),
    );
  }
}

class MovieSearchDelegate extends SearchDelegate {
  final MainController controller;

  MovieSearchDelegate(this.controller);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.searchMovies(query);
    });
    return Obx(() {
      final searchResults = controller.searchResults;
      return ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          return MovieItem(index: index, isSearchResult: true);
        },
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.searchMovies(query);
    });
    return Obx(() {
      final searchResults = controller.searchResults;
      return ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          return MovieItem(index: index, isSearchResult: true);
        },
      );
    });
  }
}