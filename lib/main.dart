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
  final Map<String, dynamic> product = {
    'name': 'Sample Product',
    'price': 99.99,
    'description': 'This is a sample product description. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    'imageUrl': 'assets/images/logo.png',
    'images': [
      'assets/images/logo.png',
      'assets/images/banner1.png',
      'assets/images/banner2.png',
    ],
  };

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
