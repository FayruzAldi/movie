import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';

class SearchPage extends StatelessWidget {
  final MainController controller = Get.find();
  final searchController = TextEditingController();
  final RxList<Map<String, dynamic>> searchResults = <Map<String, dynamic>>[].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Cari film...',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            searchResults.value = controller.searchMovies(value);
          },
        ),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            final movie = searchResults[index];
            return ListTile(
              leading: Image.network(movie['image'] as String),
              title: Text(movie['title'] as String),
              subtitle: Text(movie['description'] as String),
              trailing: Text('Rating: ${movie['rating']}'),
            );
          },
        ),
      ),
    );
  }
}