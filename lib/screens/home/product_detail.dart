import 'package:ecom/controller/productDetails_controller.dart';
import 'package:ecom/controller/products_controller.dart';
import 'package:ecom/data/fetchData.dart';
import 'package:ecom/screens/home/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> product;
  final String productId;
  final int productIndex;

   ProductDetailsScreen({super.key, required this.product, required this.productId,
   required this.productIndex});

  final ProductDetailsController controller = Get.put(ProductDetailsController());
  final productsController = Get.put(ProductController());
  String? mainImage;

  @override
  Widget build(BuildContext context) {
    controller.initialFavourite(productId);
    controller.resetMainImage();
    controller.resetQuantity();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          badges.Badge(
            badgeStyle: badges.BadgeStyle(badgeColor: Colors.green),
            badgeContent: Text(
              '3',
              style: TextStyle(color: Colors.white),
            ),
            position: badges.BadgePosition.topEnd(top: 0, end: 3),
            child: IconButton(
              onPressed: () {
                Get.to(CartScreen());
              },
              icon: Icon(Icons.shopify_sharp, size: 35,),
              color: Colors.red,

            ),
          ),

        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child:
                ClipRRect(borderRadius: BorderRadius.circular(18.0),
                  child:
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                        width: 4.0
                      )
                    ),
                    child:
                        Obx(() =>
                        CachedNetworkImage(imageUrl:  controller.mainImage.value.isNotEmpty ?
                        controller.mainImage.value : product['imageUrl'][0],
                          width: double.infinity,
                          fit: BoxFit.cover,),
                        ),
                  ),
                ),
            ),

            const SizedBox(height: 16.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var image in product['imageUrl'])
                  GestureDetector(
                    onTap: () {
                      controller.updateMainImage(image);

                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child:
                      Container(
                          padding: EdgeInsets.all(3), // Border width
                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(16.0)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Obx(() =>  Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: controller.mainImage.value == image
                                      ? Colors.greenAccent
                                      : Colors.transparent,
                                  width: 2.0,
                                ),
                              ),
                              child: SizedBox.fromSize(
                                  size: Size.fromRadius(48), // Image radius
                                  child: CachedNetworkImage(imageUrl: image, fit: BoxFit.cover)
                              ),
                            ),
                            ),
                          )
                      ),

                    ),
                  ),
              ],
            ),
             SizedBox(height: 16.0),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '\$${product['price']}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    product['description'],
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Quantity:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      IconButton(onPressed: (){
                          if(controller.quantity > 1) {
                            controller.quantity--;
                          }

                      }, icon: Icon(Icons.remove)),
                      Obx(() => Text('${controller.quantity.value}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                      ),

                      IconButton(onPressed: (){
                        controller.quantity++;

                      }, icon: Icon(Icons.add)),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          productsController.isLoading2.value = true;
                          controller.favourite(productId, product);
                          productsController.setFavouriteToggle();
                          productsController.isLoading2.value = false;

                        },
                        icon:
                            Obx(() =>
                        Icon(controller.favouriteToggle.value ? Icons.favorite : Icons.favorite_border, color: Colors.red,),
                            ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16.0,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      onPressed: () async{
                       await controller.addToCart(product);
                      },
                      child: const Text('Add to cart', style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              ),

            ),
          ],
        ),
      ),
    );
  }

}
