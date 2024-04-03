
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
      Obx(() =>
       controller.isLoading.value ? CircularProgressIndicator() : GridView.builder(
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
                                controller.favourite(controller.productDocumentId[index],
                                    index);
                              },
                                icon: Obx(() => controller.isLoading2.value ?  Icon(
                                  controller.favouriteToggle.value[index] ? Icons.favorite :
                                  Icons.favorite_border  , color: Colors.red): Icon(
                                    controller.favouriteToggle.value[index] ? Icons.favorite :
                                    Icons.favorite_border  , color: Colors.red),
                                ),
                              ),
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


//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecom/controller/products_controller.dart';
// import 'package:ecom/data/fetchData.dart';
// import 'package:ecom/screens/home/product_detail.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:ecom/model/product_ model.dart';
//
// class Products extends StatefulWidget {
//
//   List<Product> products;
//    Products({super.key, required this.products});
//
//   @override
//   State<Products> createState() => _ProductsState();
// }
//
// class _ProductsState extends State<Products> {
//   final controller = Get.put(ProductController());
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     checking();
//     super.initState();
//   }
//
//   Future<void> checking() async{
//      final prod =await FetchData().fetchProducts();
//
//     debugPrint('checking testing ${prod[0].name}');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
// debugPrint('length ${widget.products.length}');
//     return SingleChildScrollView(
//       child:
// // Obx(() {
// //   if (controller.isLoading.value) {
// //     return const Center(child: CircularProgressIndicator());
// //   }
// //
// //   if (controller.products.isEmpty) {
// //     return const Center(child: Text('No Products'));
// //   }
// //       Obx(() =>
//
//       // controller.isLoading.value ? Container(child: Text('no data'),) :
//       GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2),
//           itemCount: widget.products.length,
//           itemBuilder: (context, index) {
//             return Padding(padding: const EdgeInsets.all(5.0,),
//               child: GestureDetector(
//                 onTap: () {
//                   Get.to(ProductDetailsScreen(product: controller.products[index],
//                     productId: controller.productDocumentId[index], productIndex: index,));
//                 },
//
//                 child: Card(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CachedNetworkImage(imageUrl: widget.products[index].imageUrl[index],
//                         height: 120,
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                         placeholder: (context, url) => Center(child:CircularProgressIndicator() ,),
//                         errorWidget: (context, url, error) => Icon(Icons.error),
//
//                       ),
//
//                       Padding(padding: const EdgeInsets.all(8.0),
//                         child:
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//
//                             Column(children: [
//                               Text('data ${widget.products[index].name}',
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16),),
//                               // Text(controller.products[index]['name'],
//                               //   style: const TextStyle(
//                               //       fontWeight: FontWeight.bold,
//                               //       fontSize: 16),),
//                               Text('\$${ widget.products[index].price}',),
//
//                             ],),
//
//                             IconButton(onPressed: (){
//                               controller.favourite(controller.productDocumentId[index],
//                                   index);
//                             },
//                               icon: Obx(() =>  Icon(
//                                   controller.favouriteToggle.value[index] ? Icons.favorite :
//                                   Icons.favorite_border  , color: Colors.red),),),
//                           ],
//                         ),
//                       ),
//
//                     ],),
//                 ),
//               ),
//             );
//           }),
//         // }
//       // ),
//     );
//
//   }
// }
