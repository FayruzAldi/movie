import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';

class MovieItem extends StatelessWidget {
  final Map<String, dynamic> movie;
  final int index;
  final bool isSearchResult;

  const MovieItem({super.key, required this.movie, required this.index, this.isSearchResult = false});

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.find<MainController>();
    
    return ListTile(
      leading: Image.network(movie['image'], width: 50, height: 75, fit: BoxFit.cover),
      title: Text(movie['title']),
      subtitle: Text(movie['description']),
      trailing: IconButton(
        icon: Icon(
          movie['isLoved'] ? Icons.favorite : Icons.favorite_border,
          color: movie['isLoved'] ? Colors.red : null,
        ),
        onPressed: () => controller.toggleLove(index),
      ),
    );
  }
}