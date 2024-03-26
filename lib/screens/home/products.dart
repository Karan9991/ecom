
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  Stream<List<Map<String, dynamic>>> dataStream() async* {
    List<Map<String, dynamic>> productsData = [];
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
                return Padding(padding: const EdgeInsets.all(5.0,),
                  child: GestureDetector(
                    onTap: () {
                     // Get.off(ProductDetail());
                    },

                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            snapshot.data![index]['imageUrl'][index],
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
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
