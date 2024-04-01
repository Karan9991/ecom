import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Banner extends StatelessWidget {


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
                //autoPlay: true,
                aspectRatio: 16 / 9,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
              ),
              itemBuilder: (context, index, realIndex) {
                final banner = banners[index];
               // debugPrint('banner $banner');

                final imageUrl = banner['imageUrl'];

               // debugPrint('imageurl $imageUrl');

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
