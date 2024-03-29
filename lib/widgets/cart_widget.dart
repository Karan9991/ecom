import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartWidget extends StatefulWidget {
  final Map<String, dynamic> product;
  final String documentId;
  const CartWidget({super.key, required this.product, required this.documentId});
  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {

  int quantity = 1;

  initState() {
    super.initState();
    quantity = widget.product['quantity'];
  }

  Future<void> removeFromCart() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if(user != null) {
        // Get a reference to the current user's cart item document
        CollectionReference cartRef =
        FirebaseFirestore.instance.collection('users').doc(user.uid).collection(
            'cart');
        await cartRef.doc(widget.documentId).delete();
        print('Product removed from cart successfully!');
      }
    } catch (e) {
      print('Error removing product from cart: $e');
    }
  }

  Future<void> incrementQuantity() async{

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Get a reference to the current user's cart item document
      CollectionReference cartRef =
      FirebaseFirestore.instance.collection('users').doc(user.uid).collection(
          'cart');
      await cartRef.doc(widget.documentId).update(
          {'quantity': FieldValue.increment(1)});
      print('Quantity incremented successfully!');
    }
  }

  Future<void> decrementQuantity() async{
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Get a reference to the current user's cart item document
      CollectionReference cartRef =
      FirebaseFirestore.instance.collection('users').doc(user.uid).collection(
          'cart');
      await cartRef.doc(widget.documentId).update(
          {'quantity': FieldValue.increment(-1)});

      print('Quantity decremented successfully!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ) ,
      child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(child: Image.network(widget.product['image'][0], height: 130, width: 120, fit: BoxFit.fill,),
          borderRadius: BorderRadius.circular(12),
            ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${widget.product['name']}', style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
               SizedBox(height: 8.0),
                Text('\$${widget.product['price']}', style: TextStyle(
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
                            setState(() {
                              if(quantity >= 2){
                                decrementQuantity();
                                quantity--;
                              }

                            });
                          },
                          icon: Icon(Icons.remove),
                          color: Colors.white,
                        ),
                        Text(
                          '${quantity}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            setState(() {
                              incrementQuantity();
                              quantity++;
                            });
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
              removeFromCart();

            });
          },
        ),

      ],
    ),
    );


  }

}
