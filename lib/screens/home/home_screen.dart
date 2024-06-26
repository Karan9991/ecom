import 'package:ecom/controller/home_controller.dart';
import 'package:ecom/data/fetchData.dart';
import 'package:ecom/model/product_%20model.dart';
import 'package:ecom/screens/favourite/favourite_screen.dart';
import 'package:ecom/screens/home/cart.dart';
import 'package:ecom/screens/home/home.dart';
import 'package:ecom/screens/profile/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:badges/badges.dart' as badges;
import 'package:cloud_firestore/cloud_firestore.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic selected;
  PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

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
      bottomNavigationBar: StylishBottomBar(
        option: AnimatedBarOptions(
          barAnimation: BarAnimation.fade,
          iconStyle: IconStyle.animated,
        ),
        items: [
          BottomBarItem(
            icon: const Icon(
              Icons.house_outlined,
            ),
            selectedIcon: const Icon(Icons.house_rounded),
            backgroundColor: Colors.greenAccent,
            title: const Text('Home'),
          ),
          BottomBarItem(
            icon: const Icon(Icons.category),
            selectedIcon: const Icon(Icons.category),
            selectedColor: Colors.green,
            unSelectedColor: Colors.purple,
            backgroundColor: Colors.orange,
            title: const Text('Category'),
          ),
          BottomBarItem(
              icon: const Icon(
                Icons.favorite,
              ),
              selectedIcon: const Icon(
                Icons.favorite,
              ),
              backgroundColor: Colors.amber,
              selectedColor: Colors.deepOrangeAccent,
              title: const Text('Favourite')),
          BottomBarItem(
              icon: const Icon(
                Icons.person_outline,
              ),
              selectedIcon: const Icon(
                Icons.person,
              ),
              backgroundColor: Colors.purpleAccent,
              selectedColor: Colors.deepPurple,
              title: const Text('Profile')),
        ],
        hasNotch: true,
        fabLocation: StylishBarFabLocation.center,
        currentIndex: selected ?? 0,
        onTap: (index) {
          pageController.jumpToPage(index);
          setState(() {
            selected = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
         Get.to(CartScreen());
        },
        child:
          badges.Badge(
            badgeStyle: badges.BadgeStyle(badgeColor: Colors.lightBlueAccent),
            badgeContent: Text(
              '3',
              style: TextStyle(color: Colors.white),
            ),
            position: badges.BadgePosition.topEnd(top: -15, end: -9),
            child: Icon(Icons.shopify_sharp, size: 30, color: Colors.red,),


          )

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              selected = index;
            });
          },
          children:  [
            Home(),
            Center(child: Text('Style')),
            Favourite(),
            ProfileTab(),
          ],
        ),
      ),
    );
  }
}
