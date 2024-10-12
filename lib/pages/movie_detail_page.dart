import 'package:flutter/material.dart';
import '../models/task_model.dart';

class MovieDetailPage extends StatelessWidget {
  final TaskModel movie;

  MovieDetailPage({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(movie.description),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Logika untuk memutar video
                // Misalnya, menggunakan video_player package
              },
              child: Text('Play Video'),
            ),
          ],
        ),
      ),
    );
  }
}