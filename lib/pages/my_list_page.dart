import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';

class MyListPage extends StatelessWidget {
  final MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Saya'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.lovedMovies.length,
          itemBuilder: (context, index) {
            final movie = controller.lovedMovies[index];
            return ListTile(
              leading: Image.network(movie['image']),
              title: Text(movie['title']),
              subtitle: Text(movie['description']),
            );
          },
        ),
      ),
    );
  }
}