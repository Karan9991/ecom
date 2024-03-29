import 'package:ecom/screens/home/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:badges/badges.dart' as badges;

class ProductDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 1;
  String? mainImage; // Initialize mainImage variable
  bool _favouriteToggle = false;


  Future<void> addToCart(Map<String, dynamic> product, int quantity) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Reference to the "cart" collection for the current user
        CollectionReference cartRef = FirebaseFirestore.instance.collection('users').doc(user.uid).collection('cart');

        // Add the product data to the user's cart collection
        await cartRef.add({
          'image': product['imageUrl'], // Assuming 'image' is the key for the product image URL
          'name': product['name'],
          'price': product['price'],
          'description': product['description'],
          'quantity': quantity,
          'timestamp': FieldValue.serverTimestamp(), // Optional: Timestamp of when the item was added
        });

        print('Product added to cart successfully!');
      } else {
        print('No user signed in.');
      }
    } catch (e) {
      print('Error adding product to cart: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          badges.Badge(
            badgeStyle: badges.BadgeStyle(badgeColor: Colors.green),
            badgeContent: Text(
              '3',
              style: TextStyle(color: Colors.white),
            ),
            position: badges.BadgePosition.topEnd(top: 0, end: 3),
            child: IconButton(
              onPressed: () {
                Get.to(CartScreen());
              },
              icon: Icon(Icons.shopify_sharp, size: 35,),
              color: Colors.red,

            ),
          ),

        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child:
                ClipRRect(borderRadius: BorderRadius.circular(8.0),
                  child:
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                        width: 2.0
                      )
                    ),
                    child:
                    Image.network(
                      mainImage ?? widget.product['imageUrl'][0],
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),

                  ),
                ),
            ),

            const SizedBox(height: 16.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var image in widget.product['imageUrl'])
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        mainImage = image;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: mainImage == image
                                  ? Colors.green
                                  : Colors.transparent,
                              width: 2.0,
                            ),
                          ),
                          child:
                            Image.network(image, fit: BoxFit.cover),

                        ),
                      ),
                    ),
                  ),
              ],
            ),
             SizedBox(height: 16.0),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product['name'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '\$${widget.product['price']}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    widget.product['description'],
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16.0),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Quantity:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      IconButton(onPressed: (){
                        setState(() {
                          if(_quantity > 1) {
                            _quantity--;
                          }
                        });

                      }, icon: Icon(Icons.remove)),
                      Text('$_quantity', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),

                      IconButton(onPressed: (){
                        setState(() {
                          _quantity++;

                        });
                      }, icon: Icon(Icons.add)),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _favouriteToggle = !_favouriteToggle;
                          });
                        },
                        icon: Icon(_favouriteToggle ? Icons.favorite : Icons.favorite_border, color: Colors.red,),
                      ),
                    ],

                  ),

                  const SizedBox(height: 16.0,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      onPressed: () async{
                       await addToCart(widget.product, _quantity);
                        await Get.to(CartScreen());
                      },
                      child: const Text('Add to Cart', style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              ),

            ),
          ],
        ),
      ),
    );
  }

}
