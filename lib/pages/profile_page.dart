import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';

class ProfilePage extends StatelessWidget {
  final MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
          SizedBox(height: 20),
          Obx(() => Text(
            controller.username.value,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          )),
          SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Email'),
            subtitle: Text('${controller.username.value.toLowerCase()}@email.com'),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifikasi'),
            trailing: Switch(value: true, onChanged: (value) {}),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Bahasa'),
            trailing: Text('Indonesia'),
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Bantuan'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Keluar'),
            onTap: () {
              controller.logout();
              Get.offAllNamed('/login');
            },
          ),
        ],
      ),
    );
  }
}