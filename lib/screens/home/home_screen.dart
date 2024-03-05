import 'package:ecom/controller/home_controller.dart';
import 'package:ecom/screens/home/banner.dart' as banner;
import 'package:ecom/screens/home/categories.dart';
import 'package:ecom/screens/home/products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
          child: FlexibleSpaceBar(
            title: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
              height: 40, // Adjust height as needed
            ),
            centerTitle: false,
            titlePadding: EdgeInsets.all(0),
          ),
        ),
    
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banners
            banner.Banner(),

            // Categories

            CategorySection(),
            // Products

            Products(),
          ],
        ),
      ),
      bottomSheet: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.category),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
