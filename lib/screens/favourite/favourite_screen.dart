import 'package:ecom/controller/favourite/favourite_controller.dart';
import 'package:ecom/controller/productDetails_controller.dart';
import 'package:ecom/controller/products_controller.dart';
import 'package:ecom/screens/home/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';


class Favourite extends StatelessWidget {
  Favourite({super.key});

  final controller = Get.put(FavouriteController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:
      Obx(() =>
      controller.isLoading.value ? const CircularProgressIndicator() : GridView
          .builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            debugPrint('big testing ${controller.products.length}');
            return Padding(padding: const EdgeInsets.all(5.0,),
              child: GestureDetector(
                onTap: () {
                  Get.to(
                      ProductDetailsScreen(product: controller.products[index],
                        productId: controller.productDocumentId[index],
                        productIndex: index,));
                },

                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(imageUrl: controller
                          .products[index]['imageUrl'][index],
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator(),),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),

                      Padding(padding: const EdgeInsets.all(8.0),
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Column(children: [

                              Text(controller.products[index]['name'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),),
                              Text(
                                '\$${ controller.products[index]['price']}',),

                            ],),


                            // Obx(() =>
                            IconButton(onPressed: () {
                              controller.unFavourite(controller.productDocumentId.value[index],
                                  index);
                            },
                                icon:
                             Icon(
                                Icons.favorite
                                    , color: Colors.red),
                              ),
                            //),
                          ],
                        ),
                      ),

                    ],),
                ),
              ),

            );
          }),
        // }
      ),
    );
  }
}
