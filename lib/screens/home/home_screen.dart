import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom/controller/home_controller.dart';
import 'package:ecom/model/home_%20model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecom/screens/home/banner.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  final List<String> banners = [
    'assets/images/onboard_1.png',
    'assets/images/onboard_2.png',
    'assets/images/onboard_3.png',
    'assets/images/banner1.png',
    'assets/images/banner2.png',
    'assets/images/banner_bg.png',
  ];

  final List<String> categories = ['Electronics', 'Clothing', 'Books'];

  final List<Product> products = [
    Product(name: 'Product 1', image: 'assets/images/onboard_1.png', price: 10),
    Product(name: 'Product 2', image: 'assets/images/onboard_2.png', price: 20),
    Product(name: 'Product 3', image: 'assets/images/onboard_3.png', price: 15),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Commerce App'),
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
            // Banners
            Padding(
              padding: EdgeInsets.all(20),
              child: // Banners
                  Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[
                      200], // Change the color to your desired background color
                  borderRadius: BorderRadius.circular(
                      20.0), // Adjust the value according to your preference
                ),
                child: Banner(),
                // color: Colors.grey[
                //     200], // Change the color to your desired background color
                // child: CarouselSlider.builder(
                //   itemCount: banners.length,
                //   options: CarouselOptions(
                //     autoPlay: true, // Set to true for auto-playing
                //     aspectRatio: 16 / 9, // Adjust aspect ratio as needed
                //     enlargeCenterPage:
                //         true, // Set to true for larger centered items
                //     viewportFraction:
                //         0.8, // Adjust to show more or less of the items
                //   ),
                //   itemBuilder: (context, index, realIndex) {
                //     return Padding(
                //       padding: EdgeInsets.all(8.0),
                //       child: ClipRRect(
                //         borderRadius: BorderRadius.circular(
                //             20.0), // Adjust the value according to your preference
                //         child: Image.asset(
                //           banners[index],
                //           fit: BoxFit.cover,
                //         ),
                //       ),
                //     );
                //   },
                // ),
              ),
            ),

            // Categories
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
                    child: Chip(
                      label: Text(categories[index]),
                      backgroundColor: Colors.blue,
                    ),
                  );
                },
              ),
            ),
            // Products
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Products',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        products[index].image,
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          products[index].name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
                        child: Text('\$${products[index].price}'),
                      ),
                    ],
                  ),
                );
              },
            ),
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
