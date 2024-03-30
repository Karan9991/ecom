
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDetailsController extends GetxController{
  var quantity = 1.obs;
  var mainImage = ''.obs;
  var favouriteToggle = false.obs;

  void updateMainImage(String image){
    mainImage.value = image;
  }

  Future<void> addToCart(Map<String, dynamic> product) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Reference to the "cart" collection for the current user
        CollectionReference cartRef = FirebaseFirestore.instance.collection('users').doc(user.uid).collection('cart');

        // Add the product data to the user's cart collection
        await cartRef.add({
          'image': product['imageUrl'], // Assuming 'image' is the key for the product image URL
          'name': product['name'],
          'price': product['price'],
          'description': product['description'],
          'quantity': quantity.value,
          'timestamp': FieldValue.serverTimestamp(), // Optional: Timestamp of when the item was added
        });

        print('Product added to cart successfully!');
        Get.snackbar(
          'Product added to cart!', '',
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        );
      } else {
        print('No user signed in.');
      }
    } catch (e) {
      print('Error adding product to cart: $e');
    }
  }

  Future<void> favourite(String productId) async{
    try{
      User? user = FirebaseAuth.instance.currentUser;
      if(user != null){
        DocumentSnapshot favouriteDoc = await FirebaseFirestore.instance
            .collection('users').doc(user.uid).collection('favourites').doc(productId).get();

        if(favouriteDoc.exists){
          await favouriteDoc.reference.delete();
          favouriteToggle.value = false;
        }else{
          await FirebaseFirestore.instance.collection('users').doc(user.uid)
              .collection('favourites').doc(productId).set({'productId' : productId});
          favouriteToggle.value = true;
        }
      }
    }catch (e){
      debugPrint('Error toggling favourite $e');

    }
    
  }

  Future<void> favouritee(String name, int price, String description) async{
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Reference to the "favourite" collection for the current user
        CollectionReference favouriteRef = FirebaseFirestore.instance
            .collection('users').doc(user.uid).collection('favourite');
        // Add the product data to the user's favourite collection
        await favouriteRef.add({
          'image': mainImage.value,
          // Assuming 'image' is the key for the product image URL
          'name': name,
          'price': price,
          'description': description,
        });
        print('Product added to favourite successfully!');
        Get.snackbar(
          'Product added to favourite!', '',
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        );
        favouriteToggle.value = true;

      }
    }catch (e){

    }

  }

}