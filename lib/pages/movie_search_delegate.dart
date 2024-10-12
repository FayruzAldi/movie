import 'package:flutter/material.dart';
import '../controllers/task_controller.dart';
import '../models/task_model.dart';

class MovieSearchDelegate extends SearchDelegate {
  final TaskController dbController = TaskController();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<TaskModel>>(
      future: dbController.fetchMovies(), // Ambil data dari database
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final results = snapshot.data!.where((task) => task.title.contains(query)).toList();
          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(results[index].title),
                subtitle: Text(results[index].description),
                trailing: IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {
                    // Logika toggle love
                  },
                ),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(); // Anda bisa menambahkan saran di sini
  }
}
