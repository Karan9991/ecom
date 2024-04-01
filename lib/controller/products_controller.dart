import 'dart:math';

import 'package:ecom/data/fetchData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductController extends GetxController{
   var favouriteTogg = false.obs;
 //  var favouriteToggle = <bool>[].obs;
  var isLoading = true.obs;
  RxList<bool> favouriteToggle = <bool>[].obs;

  var products = <Map<String, dynamic>>[].obs;
  var productDocumentId = <String>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    load();
    super.onInit();
  }

  Future<void> load() async{
    await fetchProducts();
    await isProductFavourite();
    isLoading.value = false;
  }

  Future<void> fetchProducts() async{
   //products.value = await FetchData().fetchProductsMap();
    List<Map<String, dynamic>> productsData = [];
    QuerySnapshot<Map<String, dynamic>> categories = await FirebaseFirestore.instance.collection('categories').get();
    for(QueryDocumentSnapshot snapshot in categories.docs){
      QuerySnapshot<Map<String, dynamic>> products = await snapshot.reference.collection('products').get();
      for(QueryDocumentSnapshot snaps in products.docs){
        productDocumentId.add(snaps.id);
        final data = snaps.data() as Map<String, dynamic>;
        productsData.add(data);
      }
    }

    products.value = productsData;
  }


  Future<void> isProductFavourite() async {
    List<String> fav = await FetchData().fetchFavourites();

    debugPrint('isProductFavourite product length ${products.length}');

    for(int i = 0; i < products.length; i++) {
      favouriteToggle.add(fav.contains(productDocumentId[i]));
    }
    debugPrint('isProductFavourite ${favouriteToggle}');;

  }

  // Future<void> favourite(String productId, int index) async{
  //   try{
  //     User? user = FirebaseAuth.instance.currentUser;
  //     if(user != null){
  //       DocumentSnapshot favouriteDoc = await FirebaseFirestore.instance
  //           .collection('users').doc(user.uid).collection('favourites').doc(productId).get();
  //
  //       if(favouriteDoc.exists){
  //         await favouriteDoc.reference.delete();
  //         favouriteToggle.value[index] = false;
  //       }else{
  //         await FirebaseFirestore.instance.collection('users').doc(user.uid)
  //             .collection('favourites').doc(productId).set({'productId' : productId});
  //         favouriteToggle.value[index] = true;
  //       }
  //     }
  //   }catch (e){
  //     debugPrint('Error toggling favourite $e');
  //   }
  //
  // }

   Future<void> favourite(int index) async{
    debugPrint('favourite favouriteToggle List start ${favouriteToggle}');
    debugPrint('favourite index ${index}');


    if(favouriteToggle.value[index] == true){
      debugPrint('favourite if ${favouriteToggle.value[index]}');

      favouriteToggle.value[index] = false;
    }else {

      favouriteToggle.value[index] = true;
      debugPrint('favourite else ${favouriteToggle.value[index]}');

    }

    debugPrint('favourite favouriteToggle List end ${favouriteToggle}');

   }


}