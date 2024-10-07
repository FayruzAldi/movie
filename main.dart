import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:movie/controllers/main_controller.dart';
import 'package:movie/main.dart';

void main() {
  // Inisialisasi GetX
  Get.lazyPut(() => MainController());

  runApp(const MyApp());
}