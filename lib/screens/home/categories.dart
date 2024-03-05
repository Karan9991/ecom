import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  final List<String> categories = ['Demo', 'Which', 'Where'];
  final List<String> categoryImages = [
    'assets/images/onboard_1.png',
    'assets/images/onboard_2.png',
    'assets/images/onboard_3.png',
  ];

   CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Categories',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(categoryImages[index]),
                    ),
                    SizedBox(height: 4),
                    Text(
                      categories[index],
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
