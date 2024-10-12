import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../models/task_model.dart';

class BookmarksPage extends StatelessWidget {
  final TaskController dbController = Get.find();
  final List<TaskModel> lovedMovies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bookmarks')),
      body: FutureBuilder<List<TaskModel>>(
        future: dbController.fetchMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final tasks = snapshot.data ?? []; // Menangani null
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(tasks[index].imageUrl ?? '', width: 50, height: 50), // Tambahkan gambar
                  title: Text(tasks[index].title),
                  subtitle: Text(tasks[index].description),
                );
              },
            );
          }
        },
      ),
    );
  }
}