import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/home_page.dart';
import '../pages/bookmarks_page.dart';
import '../pages/profile_page.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex, required Null Function(dynamic index) onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Bookmarks',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.red[600],
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index != currentIndex) {
          switch (index) {
            case 0:
              Get.to(() => HomePage());
              break;
            case 1:
              Get.to(() => BookmarksPage());
              break;
            case 2:
              Get.to(() => ProfilePage());
              break;
          }
        }
      },
    );
  }
}
