import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';

class MovieItem extends StatelessWidget {
  final int index;
  final bool isSearchResult;
  final MainController controller = Get.find();

  MovieItem({required this.index, this.isSearchResult = false});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final movie = isSearchResult
          ? controller.searchResults[index]
          : controller.dummyMovies[index];
      return Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: ListTile(
          leading: Image.network(
            movie['image'],
            width: 50,
            height: 75,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.error);
            },
          ),
          title: Text(movie['title']),
          subtitle: Text(movie['description']),
          trailing: IconButton(
            icon: Icon(
              movie['isLoved'] ? Icons.favorite : Icons.favorite_border,
              color: movie['isLoved'] ? Colors.red : null,
            ),
            onPressed: () {
              final movieIndex = isSearchResult
                  ? controller.dummyMovies.indexOf(movie)
                  : index;
              controller.toggleLove(movieIndex);
            },
          ),
        ),
      );
    });
  }
}