import 'package:flutter/material.dart';
import '../models/task_model.dart';

class MovieListTile extends StatelessWidget {
  final TaskModel movie;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;
  final bool isFavorite;
  final IconData trailingIcon;

  const MovieListTile({
    Key? key,
    required this.movie,
    required this.onTap,
    required this.onFavoriteToggle,
    required this.isFavorite,
    this.trailingIcon = Icons.favorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        movie.imageUrl,
        width: 50,
        height: 75,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('Error loading image: ${movie.imageUrl}');
          return Image.asset(
            'lib/assets/image.png',
            width: 50,
            height: 75,
            fit: BoxFit.cover,
          );
        },
      ),
      title: Text(movie.title),
      subtitle: Text(movie.description),
      trailing: IconButton(
        icon: Icon(
          trailingIcon,
          color: isFavorite ? Colors.red : null,
        ),
        onPressed: onFavoriteToggle,
      ),
      onTap: onTap,
    );
  }
}
