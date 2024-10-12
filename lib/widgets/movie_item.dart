import 'package:flutter/material.dart';
import '../models/task_model.dart';

class MovieItem extends StatelessWidget {
  final TaskModel task;
  final Function(TaskModel) toggleLove;

  MovieItem({required this.task, required this.toggleLove});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: IconButton(
        icon: Icon(Icons.favorite_border),
        onPressed: () {
          toggleLove(task);
        },
      ),
    );
  }
}