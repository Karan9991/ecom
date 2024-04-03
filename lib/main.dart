import 'package:ecom/widgets/cart_widget.dart';
import 'package:ecom/firebase_options.dart';
import 'package:ecom/screens/auth/sign_in.dart';
import 'package:ecom/screens/home/cart.dart';
import 'package:ecom/screens/home/home.dart';
import 'package:ecom/screens/home/home_screen.dart';
import 'package:ecom/screens/home/product_detail.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await GetStorage.init();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp( MainApp());
  });
}

class MainApp extends StatelessWidget {
   MainApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: SignInScreen(),
    );
  }
}
