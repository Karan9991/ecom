//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecom/controller/products_controller.dart';
// import 'package:ecom/data/fetchData.dart';
// import 'package:ecom/screens/home/product_detail.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cached_network_image/cached_network_image.dart';
//
// class Products extends StatelessWidget {
//    Products({Key? key}) : super(key: key);
//    List<Map<String, dynamic>> productsData = [];
//    List<String> productId = [];
//    final controller = Get.put(ProductController());
//
//   Stream<List<Map<String, dynamic>>> dataStream() async* {
//     QuerySnapshot<Map<String, dynamic>> cat = await FirebaseFirestore.instance.collection('categories').get();
//
//     for (QueryDocumentSnapshot<Map<String, dynamic>> doc in cat.docs) {
//       QuerySnapshot<Map<String, dynamic>> data = await doc.reference.collection('products').get();
//
//       for (QueryDocumentSnapshot<Map<String, dynamic>> product in data.docs) {
//         productId.add(product.id);
//         productsData.add(product.data());
//       }
//       yield productsData;
//     }
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return SingleChildScrollView(
//       child: StreamBuilder(stream: dataStream(), builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         }
//         if(!snapshot.hasData) {
//           return const Center(child: Text('No Products'));
//
//         }
//
//           return GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2),
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 // bool isFavourite = controller.isProductFavourite(productId[index]);
//                 controller.isProductFavourite(productId[index]);
//
//                 //controller.pId.value = productId[index];
//                 debugPrint('productIdd ${productId[index]}');
//              //   debugPrint('controller.pId.value ${controller.pId.value}');
//
//                 debugPrint('toggle value ${controller.favouriteToggle.value}');
//
//                 return Padding(padding: const EdgeInsets.all(5.0,),
//                   child: GestureDetector(
//                     onTap: () {
//                       Get.to(ProductDetailsScreen(product: productsData[index],
//                       productId: productId[index],));
//                     },
//
//                     child: Card(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CachedNetworkImage(imageUrl: snapshot.data![index]['imageUrl'][index],
//                           height: 120,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                             placeholder: (context, url) => Center(child:CircularProgressIndicator() ,),
//                             errorWidget: (context, url, error) => Icon(Icons.error),
//
//                           ),
//
//                           Padding(padding: const EdgeInsets.all(8.0),
//                             child:
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//
//                                 Column(children: [
//                                   Text(snapshot.data![index]['name'],
//                                     style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16),),
//                                   Text('\$${ snapshot.data![index]['price']}',),
//
//                                 ],),
//                              IconButton(onPressed: (){
//
//
//                                 },
//                                   icon: Icon(
//                                      controller.favouriteToggle.value ? Icons.favorite : Icons.favorite_border , color: Colors.red),),
//
//                               ],
//                             ),
//                           ),
//
//                         ],),
//                     ),
//                   ),
//                 );
//               });
//       }),
//     );
//
//   }
// }






import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/controller/products_controller.dart';
import 'package:ecom/data/fetchData.dart';
import 'package:ecom/screens/home/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get_storage/get_storage.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child:
Obx(() {
  if (controller.isLoading.value) {
    return const Center(child: CircularProgressIndicator());
  }

  if (controller.products.isEmpty) {
    return const Center(child: Text('No Products'));
  }
        return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: controller.products.length,
            itemBuilder: (context, index) {


              return Padding(padding: const EdgeInsets.all(5.0,),
                child: GestureDetector(
                  onTap: () {
                      Get.to(ProductDetailsScreen(product: controller.products[index],
                        productId: controller.productDocumentId[index], productIndex: index,));

         },

                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(imageUrl: controller.products[index]['imageUrl'][index],
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Center(child:CircularProgressIndicator() ,),
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
                                Text('\$${ controller.products[index]['price']}',),

                              ],),
                              IconButton(onPressed: (){


                              },
                                icon: Icon(
                                  controller.favouriteToggle.value[index] ? Icons.favorite : Icons.favorite_border  , color: Colors.red),),

                            ],
                          ),
                        ),

                      ],),
                  ),
                ),
              );
            });
  }
    ),
      // }),
    );

  }
}
