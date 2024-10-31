import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/models/task_model.dart';
import 'package:movie/pages/bookmarks_page.dart';
import 'package:movie/pages/profile_page.dart';
import 'package:movie/widgets/custom_bottom_navigation_bar.dart';
import '../controllers/main_controller.dart';
import 'movie_detail_page.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends GetView<MainController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Motify'),
      ),
      body: GetBuilder<MainController>(
        builder: (controller) {
          if (controller.movieList.isEmpty) {
            return Center(child: Text('Tidak ada film tersedia.'));
          }
          return Column(
            children: [
              _buildCarousel(controller, context),
              Expanded(
                child: _buildResponsiveMovieList(context, controller),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Get.to(() => HomePage());
          } else if (index == 1) {
            Get.to(() => BookmarksPage());
          } else if (index == 2) {
            Get.to(() => ProfilePage());
          }
        },
      ),
    );
  }

 Widget _buildCarousel(MainController controller, BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double carouselHeight;

  if (screenWidth > 600 && screenWidth <= 900) {
    carouselHeight = 300; // Medium size for tablet mode
  } else if (screenWidth > 900) {
    carouselHeight = 250; // Smaller size for larger screens
  } else {
    carouselHeight = 200; // Default size for smaller screens
  }

  return CarouselSlider(
    options: CarouselOptions(
      height: carouselHeight,
      enlargeCenterPage: true,
      autoPlay: true,
      aspectRatio: 16 / 9,
      autoPlayCurve: Curves.fastOutSlowIn,
      enableInfiniteScroll: true,
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      viewportFraction: 0.85,
    ),
    items: controller.movieList.map((TaskModel movie) {
      return Builder(
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              Get.to(() => MovieDetailPage(movie: movie));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(movie.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          movie.description,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }).toList(),
  );
}


  Widget _buildResponsiveMovieList(
      BuildContext context, MainController controller) {
    bool isTablet = MediaQuery.of(context).size.width > 600;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: isTablet
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 7,
              ),
              itemCount: controller.movieList.length,
              itemBuilder: (context, index) {
                final movie = controller.movieList[index];
                return _buildMovieCard(movie, controller);
              },
            )
          : ListView.builder(
              padding: EdgeInsets.only(bottom: 8), // Optional padding for spacing
              itemCount: controller.movieList.length,
              itemBuilder: (context, index) {
                final movie = controller.movieList[index];
                return _buildMovieCard(movie, controller);
              },
            ),
    );
  }

  Widget _buildMovieCard(TaskModel movie, MainController controller) {
    return GestureDetector(
      onTap: () {
        Get.to(() => MovieDetailPage(movie: movie));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.symmetric(vertical: 4),
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  movie.imageUrl,
                  width: 40,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Text(
                      movie.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 10),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: movie.isFavorite ? Colors.red : null,
                  size: 18,
                ),
                onPressed: () {
                  controller.toggleFavorite(movie);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
