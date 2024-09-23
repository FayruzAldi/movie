import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';

class HomePage extends StatelessWidget {
  final MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beranda'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.dummyMovies.length,
          itemBuilder: (context, index) {
            final movie = controller.dummyMovies[index];
            return Card(
              margin: EdgeInsets.all(8),
              child: ListTile(
                leading: Image.network(movie['image']),
                title: Text(movie['title']),
                subtitle: Text(movie['description']),
                trailing: IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: movie['isLoved'] ? Colors.red : Colors.grey,
                  ),
                  onPressed: () => controller.toggleLove(index),
                ),
                onTap: () {
                  Get.snackbar('Film Dipilih', 'Anda memilih ${movie['title']}');
                },
              ),
            );
          },
        ),
      ),
    );
  }
}