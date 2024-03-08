import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Banner extends StatelessWidget {
  // List<String> banners = [
  //   'assets/images/onboard_1.png',
  //   'assets/images/onboard_2.png',
  //   'assets/images/onboard_3.png',
  //   'assets/images/banner1.png',
  //   'assets/images/banner2.png',
  //   'assets/images/banner_bg.png',
  // ];

  // @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(20),
  //     child: Container(
  //       height: 200,
  //       decoration: BoxDecoration(
  //           color: Colors.grey[200], borderRadius: BorderRadius.circular(20.0)),
  //       child: CarouselSlider.builder(
  //         itemCount: banners.length,
  //         options: CarouselOptions(
  //           autoPlay: true, // Set to true for auto-playing
  //           aspectRatio: 16 / 9, // Adjust aspect ratio as needed
  //           enlargeCenterPage: true, // Set to true for larger centered items
  //           viewportFraction: 0.8, // Adjust to show more or less of the items
  //         ),
  //         itemBuilder: (context, index, realIndex) {
  //           return Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(
  //                   20.0), // Adjust the value according to your preference
  //               child: Image.asset(
  //                 banners[index],
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('banners').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final banners = snapshot.data!.docs;
            return CarouselSlider.builder(
              itemCount: banners.length,
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 16 / 9,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
              ),
              itemBuilder: (context, index, realIndex) {
                final banner = banners[index];
                debugPrint('banner $banner');

                final imageUrl = banner['imageUrl'];

                debugPrint('imageurl $imageUrl');

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
