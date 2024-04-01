import 'package:ecom/model/product_%20model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecom/model/user_model.dart';
import 'package:ecom/model/cart_model.dart';
class FetchData{

  final firestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  List<String> productDocumentId = [];

  Future<List<Product>> fetchProducts() async{
    List<Product> productsData = [];
    QuerySnapshot<Map<String, dynamic>> categories = await firestore.collection('categories').get();
    for(QueryDocumentSnapshot snapshot in categories.docs){
      QuerySnapshot<Map<String, dynamic>> products = await snapshot.reference.collection('products').get();
      for(QueryDocumentSnapshot snaps in products.docs){
        productDocumentId.add(snaps.id);
        final data = snaps.data() as Map<String, dynamic>;
        productsData.add(Product.fromJson(data));
      }
    }
    // debugPrint('fetch data ${productsData[0].imageUrl[0]}');
    return productsData;
  }

  Future<List<Map<String, dynamic>>> fetchProductsMap() async{
    List<Map<String, dynamic>> productsData = [];
    QuerySnapshot<Map<String, dynamic>> categories = await firestore.collection('categories').get();
    for(QueryDocumentSnapshot snapshot in categories.docs){
      QuerySnapshot<Map<String, dynamic>> products = await snapshot.reference.collection('products').get();
      for(QueryDocumentSnapshot snaps in products.docs){
        productDocumentId.add(snaps.id);
        final data = snaps.data() as Map<String, dynamic>;
        productsData.add(data);
      }
    }
    // debugPrint('fetch data ${productsData[0].imageUrl[0]}');
    return productsData;
  }

  Future<List<String>> fetchProductsDocumentId() async{
   await fetchProducts();
    //debugPrint('products id $productDocumentId');
    return productDocumentId;
  }


  Future<List<Users>> fetchUser() async{
    List<Users> usersData = [];
    User? user = firebaseAuth.currentUser;
    try{
      if(user != null){
        QuerySnapshot<Map<String, dynamic>> data = await firestore.collection('users').get();
        for(QueryDocumentSnapshot queryDocumentSnapshot in data.docs){
         final data = queryDocumentSnapshot.data() as Map<String, dynamic>;
          usersData.add(Users.fromJson(data));
        }
      }
      return usersData;
      // debugPrint('fetch users data ${usersData[0].name}');

    }catch (e){
      debugPrint('Error fetching users data $e');
      return [];
    }
  }

  Future<List<Cart>> fetchCart() async{
    List<Cart> carts = [];
    User? user = firebaseAuth.currentUser;
    try{
      if(user != null){
        QuerySnapshot<Map<String, dynamic>> cart = await firestore.collection(
            'users').doc(user.uid).collection('cart').get();
        for (QueryDocumentSnapshot queryDocumentSnapshot in cart.docs) {
          final data = queryDocumentSnapshot.data() as Map<String, dynamic>;
          carts.add(Cart.fromJson(data));
        }
      }
      debugPrint('fetch cart data ${carts[0].name}');

      return carts;

    }catch(e){
      debugPrint('Error fetching cart data $e');
      return [];

    }
  }

  Future<List<String>> fetchFavourites() async{
    User? user = firebaseAuth.currentUser;
    List<String> favourites = [];

    try {
      if (user != null) {
        QuerySnapshot<Map<String, dynamic>> favouritesSnapshot = await firestore
            .collection(
            'users').doc(user.uid).collection('favourites').get();
        for (QueryDocumentSnapshot queryDocumentSnapshot in favouritesSnapshot.docs) {
          final data = queryDocumentSnapshot.data() as Map
          <String, dynamic>;
          favourites.add(data['productId']);
          debugPrint('Favourites ${data['productId']}');
        }
      }
      return favourites;
    }catch (e){
      debugPrint('Error fetching favourites $e');
      return [];
    }
  }


}





