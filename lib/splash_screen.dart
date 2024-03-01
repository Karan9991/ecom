import 'package:ecom/screens/auth/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

       // Delay navigation to the signup screen using GetX
    Future.delayed(const Duration(seconds: 2), () {
      Get.off(SignUpScreen());
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Replace the Image.asset() with your app logo
            Image.asset(
              'assets/images/logo.png',
              width: 150,
              height: 150,
            ),
            // Display the splash title
           
          ],
        ),
      ),
    );
  }
}