import 'package:ecom/model/product_%20model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecom/model/user_model.dart';
import 'package:ecom/model/cart_model.dart';
class FetchData{

  final firestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;

  Future<List<Product>> fetchProducts() async{
    List<Product> productsData = [];
    QuerySnapshot<Map<String, dynamic>> categories = await firestore.collection('categories').get();
    for(QueryDocumentSnapshot snapshot in categories.docs){
      QuerySnapshot<Map<String, dynamic>> products = await snapshot.reference.collection('products').get();
      for(QueryDocumentSnapshot snaps in products.docs){
        final data = snaps.data() as Map<String, dynamic>;
        productsData.add(Product.fromJson(data));
      }
    }
    // debugPrint('fetch data ${productsData[0].imageUrl[0]}');
    return productsData;
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
    //List<Map<String, dynamic>> carts = [];
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

}





