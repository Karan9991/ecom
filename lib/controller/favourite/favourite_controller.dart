import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/data/fetchData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FavouriteController extends GetxController{

  var products = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var productDocumentId = <String>[].obs;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();

   // debugPrint('on init called');
    load();

  }

  Future<void> load() async{
   // debugPrint('load called');

    // Listen to changes in the Firestore database
    isLoading.value = true;

    FirebaseFirestore.instance
        .collection('users').doc(user!.uid).collection('favourites')
        .snapshots()
        .listen((snapshot) async {
      debugPrint('firebase listen');
      products.clear();
      productDocumentId.clear();

      await favouriteList();

      //isLoading.value = false;

      //await printData();


    });
  }

  Future<void> printData() async{
    debugPrint('printData called');

    debugPrint('Product list ${products.value}');
    debugPrint('ProductId list ${productDocumentId.value}');
    debugPrint('isLoading  ${isLoading.value}');

  }

  Future<void> printData2() async{
    debugPrint('printData2 called');

    debugPrint('Product list ${products.value}');
    debugPrint('ProductId list ${productDocumentId.value}');
    debugPrint('isLoading  ${isLoading.value}');

  }

  Future<void> favouriteList() async{
    //debugPrint('favouriteList called');

    try{
       productDocumentId.value = await FetchData().fetchFavouritesId();

      products.value = await FetchData().fetchFavourites();

    }catch(e){
      debugPrint('Error favouriteList $e');
    }finally{
      isLoading.value = false;

    }
  }

  Future<void> unFavourite(String productId, int index) async{
    // debugPrint('unFavourite called');
    // debugPrint('productId $productId');
    // debugPrint('index $index');

    try{
      isLoading.value = true;

      if(user != null){
        final ref  = await FirebaseFirestore.instance.collection('users').doc(user!.uid)
            .collection('favourites').doc(productId).get();
        if(ref.exists){
          await ref.reference.delete();
          // productDocumentId.value.removeAt(index);
         // printData2();
          //await favouriteList();
        }
      }
    }catch(e){

      debugPrint(' UnFavourite Error $e');
    }finally{
     // isLoading.value = false;

    }


  }


  
}