import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/data/fetchData.dart';
import 'package:ecom/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddressController extends GetxController{

  var address = ''.obs;
  var isLoading = false.obs;
  late TextEditingController addressController ;


  @override
  void onInit() {
    // TODO: implement onInit
    load();
    super.onInit();
  }

  Future<void> load() async{
    addressController = TextEditingController();
    isLoading.value = true;
    List<Users> user = await FetchData().fetchUser();
    address.value = user[0].address;
    addressController.text = address.value;
    isLoading.value = false;
  }

  Future<void> updateAddress() async{
    User? user  = FirebaseAuth.instance.currentUser;
    if(user != null){
      final ref = FirebaseFirestore.instance.collection('users').doc(user.uid);
      await ref.update({
        'address': addressController.text,
      });
      Get.snackbar('Address Updated', '');
    }

  }
}