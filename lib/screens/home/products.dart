
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/screens/home/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Products extends StatelessWidget {
   Products({Key? key}) : super(key: key);
   List<Map<String, dynamic>> productsData = [];

  final Map<String, dynamic> product = {
    'name': 'Sample Product',
    'price': 99.99,
    'description': 'This is a sample product description. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    'imageUrl': 'assets/images/logo.png',
    'images': [
      'assets/images/logo.png',
      'assets/images/banner1.png',
      'assets/images/banner2.png',
    ],
  };

  Stream<List<Map<String, dynamic>>> dataStream() async* {
    QuerySnapshot<Map<String, dynamic>> cat = await FirebaseFirestore.instance.collection('categories').get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in cat.docs) {
      QuerySnapshot<Map<String, dynamic>> data = await doc.reference.collection('products').get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> product in data.docs) {
        productsData.add(product.data());
      }

      yield productsData;
    }
    debugPrint('Products ${productsData.length}');

  }


  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: StreamBuilder(stream: dataStream(), builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if(!snapshot.hasData) {
          return const Center(child: Text('No Products'));

        }

          debugPrint('Products Length ${snapshot.data!.length}');
          return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                String url =  snapshot.data![index]['imageUrl'][index];

                return Padding(padding: const EdgeInsets.all(5.0,),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(ProductDetailsScreen(product: productsData[index]));
                    },


                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedNetworkImage(imageUrl: snapshot.data![index]['imageUrl'][index],
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
                                  Text(snapshot.data![index]['name'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),),
                                  Text('\$${ snapshot.data![index]['price']}',),

                                ],),
                                IconButton(onPressed: () {},
                                  icon: const Icon(
                                      Icons.favorite, color: Colors.red),),
                              ],
                            ),
                          ),

                        ],),
                    ),
                  ),
                );
              });
        //}
        // return const Text('No Products');
      }),
    );

  }
}
