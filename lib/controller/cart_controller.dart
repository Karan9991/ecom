import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartController extends GetxController{
  var products = <Map<String, dynamic>>[].obs;
  var documentId = <String>[].obs;
  var isLoading = true.obs;
  var isLoading2 = true.obs;
  var isLoading3 = true.obs;
  var quantity = <int>[].obs;
  var price = <int>[].obs;
  var total = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    load();
    super.onInit();
  }

  Future<void> load() async {
    await getCart();
    isLoading.value = false;
    isLoading2.value = false;
    isLoading3.value = false;
   await calculateTotalPrice();

  }

  Future<void> totalAmountReset() async{
    total.value = 0;
  }

  int calculateTotalPrice() {

    if (!isLoading2.value) {

      int totalPrice = 0;
      for (int i = 0; i < products.length; i++) {
        int itemTotalPrice = quantity[i] * price[i];
        totalPrice += itemTotalPrice;
      }
      total.value = totalPrice;
      return totalPrice;
    }
    else{
      return 0;
    }
  }


  Future<List<Map<String, dynamic>>> getCart() async{
    User? user = await FirebaseAuth.instance.currentUser;

    if(user != null){
      debugPrint('user is not null');

      final cartRef = FirebaseFirestore.instance.collection('users').doc(user.uid).collection('cart');
      QuerySnapshot<Map<String, dynamic>>  aa = await  cartRef.get();
      for(int i=0; i< aa.size; i++){
        QueryDocumentSnapshot snapshot = aa.docs[i];
        documentId.value.add(snapshot.id);
        final data =snapshot.data() as Map<String, dynamic>;
        quantity.value.add(data['quantity']);
        price.value.add(data['price']);
        products.value.add(data);
      }

      debugPrint('cart list ${products}');
      debugPrint('documentId list ${documentId}');
      await totalAmountReset();
      await calculateTotalPrice();
      return products;

    }else{
      debugPrint('user is null');
      return products;
    }
  }

  Future<void> removeFromCart(String documentId, int index) async {
    // totalAmountReset();
    isLoading.value = true;
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if(user != null) {
        debugPrint('removeFromCart start ${products}');
        debugPrint('removeFromCart ${index}');

        // Get a reference to the current user's cart item document
        CollectionReference cartRef =
        FirebaseFirestore.instance.collection('users').doc(user.uid).collection(
            'cart');
        await cartRef.doc(documentId).delete();
        products.value.removeAt(index);
        quantity.value.removeAt(index);
        price.value.removeAt(index);
        debugPrint('removeFromCart end ${products}');

        print('Product removed from cart successfully!');
      }
    } catch (e) {
      print('Error removing product from cart: $e');
    }
    isLoading.value = false;
    await totalAmountReset();
    await calculateTotalPrice();
  }

  Future<void> incrementQuantity(String documentId, int index) async{

    isLoading2.value = true;

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Get a reference to the current user's cart item document
      CollectionReference cartRef =
      FirebaseFirestore.instance.collection('users').doc(user.uid).collection(
          'cart');
      await cartRef.doc(documentId).update(
          {'quantity': FieldValue.increment(1)});
      quantity.value[index]++;
      print('Quantity incremented successfully!');
    }
    isLoading2.value = false;
   await totalAmountReset();
   await calculateTotalPrice();
  }

  Future<void> decrementQuantity(String documentId, int index) async{
    isLoading2.value = true;

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Get a reference to the current user's cart item document
      CollectionReference cartRef =
      FirebaseFirestore.instance.collection('users').doc(user.uid).collection(
          'cart');
      await cartRef.doc(documentId).update(
          {'quantity': FieldValue.increment(-1)});
      quantity.value[index]--;

      print('Quantity decremented successfully!');
      isLoading2.value = false;

      await totalAmountReset();
      await calculateTotalPrice();
    }
  }


}