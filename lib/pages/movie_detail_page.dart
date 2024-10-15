import 'package:flutter/material.dart';
import '../models/task_model.dart';

class MovieDetailPage extends StatelessWidget {
  final TaskModel movie;

  MovieDetailPage({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              movie.imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    movie.description,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  // Tambahkan informasi tambahan film di sini jika ada
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
