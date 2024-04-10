import 'package:ecom/data/fetchData.dart';
import 'package:ecom/model/user_model.dart';
import 'package:ecom/screens/auth/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileTabController extends GetxController{

  var email = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    load();
    super.onInit();
  }

  Future<void> load() async{
    isLoading.value = true;
   List<Users> user = await FetchData().fetchUser();
   email.value = user[0].email;
    isLoading.value = false;
  }

  Future<void> logout() async{
    FirebaseAuth _auth = await FirebaseAuth.instance;
    try{
      _auth.signOut();
      Get.offAllNamed('/signin');
    }catch (e){
      debugPrint('Error logging out: $e');
    }
  }

}