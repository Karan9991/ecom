import 'package:ecom/screens/home/banner.dart' as banner;
import 'package:ecom/screens/home/categories.dart';
import 'package:ecom/screens/home/products.dart';
import 'package:flutter/material.dart';
import 'package:ecom/model/product_ model.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          // Banners
          banner.Banner(),
          // Categories
          CategorySection(),
          // Products
         const Products(),
        ],
      ),
    );
  }
}
