import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/widgets/cart_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class CartScreen extends StatefulWidget {
   CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> products = [];
  List<String> documentId = [];


  Future<List<Map<String, dynamic>>> getCart() async{
    User? user = await FirebaseAuth.instance.currentUser;

    if(user != null){
      debugPrint('user is not null');

      final cartRef = FirebaseFirestore.instance.collection('users').doc(user.uid).collection('cart');
      QuerySnapshot<Map<String, dynamic>>  aa = await  cartRef.get();
      for(int i=0; i< aa.size; i++){
       QueryDocumentSnapshot snapshot = aa.docs[i];
       documentId.add(snapshot.id);
       final data =snapshot.data() as Map<String, dynamic>;
       products.add(data) ;
      }

      debugPrint('cart list ${products}');
      debugPrint('documentId list ${documentId}');
      return products;

    }else{
      debugPrint('user is null');
      return products;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),

       child: FutureBuilder<List<Map<String, dynamic>>> (future: getCart(),builder: (context, snapshot){
         if(snapshot.connectionState == ConnectionState.waiting){
           CircularProgressIndicator();
         }
         if(snapshot.hasData){
           return ListView.builder(itemCount: snapshot.data!.length, itemBuilder: (context, index){
             return Padding(padding: EdgeInsets.all(8.0),
             child:CartWidget(product: snapshot.data![index], documentId: documentId[index]),);
           });


         }
         return const Text('No data found');

       },),

      ),
    //),
    );
  }
}

// void main() async {
//
//     runApp( CartScreen());
// }
