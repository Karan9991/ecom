// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class Products extends StatefulWidget {
//   const Products({super.key});
//
//   @override
//   State<Products> createState() => _ProductsState();
// }
//
// class _ProductsState extends State<Products> {
//   final _firestore = FirebaseFirestore.instance;
//   List<Map<String, dynamic>> products = [];
//
//
//   @override
//   initState() {
//     super.initState();
//
//     _fetchData();
//   }
//
//   Future<void> _fetchData() async {
//     try {
//       QuerySnapshot categorySnapshot =
//           await _firestore.collection('categories').get();
//       for (QueryDocumentSnapshot categoryDoc in categorySnapshot.docs) {
//         // Fetch products for each category
//         QuerySnapshot productSnapshot =
//             await categoryDoc.reference.collection('products').get();
//         for (QueryDocumentSnapshot productDoc in productSnapshot.docs) {
//           Map<String, dynamic> productData =
//               productDoc.data() as Map<String, dynamic>;
//           products.add(productData);
//         }
//       }
//
//       // Now allProducts contains products from all categories
//       print('All Products: $products');
//     } catch (e) {
//       debugPrint('Firestore Error $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         const Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Text(
//             'Products',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//         ),
//         GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             // childAspectRatio: 0.9,
//           ),
//           itemCount: products.length,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: Card(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Image.network(
//                       products[index]['imageUrl'][index],
//                       height: 120,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 products[index]['name'],
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 '\$${products[index]['price']}',
//                               ),
//                             ],
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               // Add your favorite icon onPressed logic here
//                             },
//                             icon: const Icon(
//                               Icons.favorite,
//                               color: Colors.red,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ]),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  Stream<List<Map<String, dynamic>>> dataStream() async* {
    List<String> list = [];
    List<Map<String, dynamic>> productsData = [];
    QuerySnapshot<Map<String, dynamic>> cat = await FirebaseFirestore.instance.collection('categories').get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in cat.docs) {
      QuerySnapshot<Map<String, dynamic>> data = await doc.reference.collection('products').get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> product in data.docs) {
        Map<String, dynamic> products = product.data();
        productsData.add(product.data());
        debugPrint('Products ${products['name']}');
        list.add(products['name']);
      }
      yield productsData;
    }
  }


  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: StreamBuilder(stream: dataStream(), builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        return GridView.builder(
          shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index){

            return Padding(padding: EdgeInsets.all(5.0,),
              child:  Card(
              child: Column(crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Image.network(snapshot.data![index]['imageUrl'][index],
                  height: 120,
                  width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                Padding(padding: EdgeInsets.all(8.0),
                  child:
                Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [


                Column(children: [
                   Text(snapshot.data![index]['name'],
                   style: TextStyle(fontWeight: FontWeight.bold),),
                  Text('\$${ snapshot.data![index]['price']}',),

                ],),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.favorite, color: Colors.red),),
                  ],
                ),
                ),

              ],),
              ),
            );

            });
      }),
    );

  }
}
