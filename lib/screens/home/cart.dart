import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/controller/cart_controller.dart';
import 'package:ecom/widgets/cart_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartScreen extends StatefulWidget {
   CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  final controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
       child:
       Obx(() =>
          controller.isLoading.value ? Container() :
          ListView.builder(itemCount: controller.products.value.length,
              itemBuilder: (context, index){
             return Padding(padding: EdgeInsets.all(8.0),
             child: Obx(() => controller.isLoading.value ? Container() :

                Container(decoration: BoxDecoration(
               color: Colors.grey[100],
               borderRadius: BorderRadius.all(Radius.circular(10.0)),
             ) ,
                child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                ClipRRect(child:

                CachedNetworkImage(imageUrl: controller.products.value[index]['image'][0],
                   height: 130, width: 120, fit: BoxFit.fill,),
                borderRadius: BorderRadius.circular(12),
                ),
                Expanded(
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text('${controller.products.value[index]['name']}', style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                ),),
                SizedBox(height: 8.0),
                Text('\$${controller.products.value[index]['price']}', style: TextStyle(
                color: Colors.green,
                fontSize: 18
                ),),
                SizedBox(height: 12.0),

                Container(
                height: 37,
                width: 120,
                decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
                ),
                ],
                ),
                child: Center(
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                IconButton(
                onPressed: () {
                   if(controller.quantity.value[index] >= 2){
                   controller.decrementQuantity(controller.documentId.value[index], index);
                   }

                },
                icon: Icon(Icons.remove),
                color: Colors.white,
                ),
                Obx(() => controller.isLoading2.value ?
                Text(
                '${controller.quantity.value[index]}',
                style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                ),
                ): Text(
                   '${controller.quantity.value[index]}',
                   style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                   ),
                ),),

                IconButton(
                onPressed: () {
                   controller.incrementQuantity(
                       controller.documentId.value[index], index);

                },
                icon: Icon(Icons.add),
                color: Colors.white,
                ),
                ],
                ),
                ),
                ),
                ],

                ),

                ),

                ),
                IconButton(
                icon: Icon(Icons.remove_circle),
                color: Colors.red,
                onPressed: () {
                setState(() {
               controller.removeFromCart(controller.documentId.value[index], index);

                });
                },
                ),

                ],
                ),
                ),
             ),

             );
           }) ,

       ),
      ),
      bottomSheet:    ElevatedButton(
        onPressed: () {
          // Show modal bottom sheet
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Total amount text
                    Text(
                      'Total Amount: 200', // Format total amount with two decimal places
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    // Check-out button
                    ElevatedButton(
                      onPressed: () {
                        // Handle check-out button press
                        Get.back(); // Close the bottom sheet
                        // Add your check-out logic here
                      },
                      child: const Text('Check Out'),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Text('View Cart'),
      ),
    );
  }
}
