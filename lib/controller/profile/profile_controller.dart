import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/data/fetchData.dart';
import 'package:ecom/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{

  var email = ''.obs;
  var name = ''.obs;
  var isLoading = false.obs;
  late TextEditingController nameController ;
  late TextEditingController emailController ;


  @override
  void onInit() {
    // TODO: implement onInit
    load();
    super.onInit();
  }

  Future<void> load() async{
    nameController = TextEditingController();
    emailController = TextEditingController();
    isLoading.value = true;
    List<Users> user = await FetchData().fetchUser();
    email.value = user[0].email;
    name.value = user[0].name;
    nameController.text = name.value;
    emailController.text = email.value;
    isLoading.value = false;
  }

  Future<void> updateUser() async{
    User? user  = FirebaseAuth.instance.currentUser;
    if(user != null){
      final ref = FirebaseFirestore.instance.collection('users').doc(user.uid);
      await ref.update({
        'name': nameController.text,
      });
      Get.snackbar('Profile Updated', '');
    }

  }
}