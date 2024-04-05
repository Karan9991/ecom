import 'package:ecom/screens/profile/address_screen.dart';
import 'package:ecom/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      //backgroundColor: Theme.of(context).primaryColor,

      body: Column(children: [
        Container(
          decoration: BoxDecoration(
            color: primaryColor,
          ),
          child: Padding(padding: EdgeInsets.all(20.0),
            child: Row(
            children: [
              Container(
                width: 64, // Adjust width and height to make it circular
                height: 64,
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(2),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child:Icon(Icons.person, size: 60, color: Colors.green,),
                ),
              ),
              const SizedBox(width: 20,),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Karan74406@gmail.com ',
                  style: TextStyle(color: Colors.white, fontSize: 18,
                  fontWeight: FontWeight.bold
                  ),),
                  Text('March 11, 2024', style: TextStyle(color: Colors.white),),
                ],
              ))
            ],
          ),
          ),
        ),

        //2
        Expanded(child: SingleChildScrollView(
          child: Ink(
            color: Colors.green[100],
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text('General', style: TextStyle(color: primaryColor,
                    fontSize: 16),),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,
                          vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: (){
                              Get.to(ProfileScreen());
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                children: [
                                  Row(children: [
                                    Icon(Icons.person),
                                    const SizedBox(width: 10,),
                                    Text('Profile'),
                                  ],)
                                ],
                              ),
                            ),

                          ),
                          const Divider(),

                          InkWell(
                            onTap: (){
                              Get.to(AddressScreen());

                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                children: [
                                  Row(children: [
                                    Icon(Icons.location_on),
                                    const SizedBox(width: 10,),
                                    Text('My Address'),
                                  ],)
                                ],
                              ),
                            ),

                          ),
                          const Divider(),

                          InkWell(
                            onTap: (){},
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                children: [
                                  Row(children: [
                                    Icon(Icons.language),
                                    const SizedBox(width: 10,),
                                    Text('Language'),
                                  ],)
                                ],
                              ),
                            ),

                          ),
                        ],
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 20,),


                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(left: 20, right: 20),
                      child: Text('Personal', style: TextStyle(color: primaryColor,
                          fontSize: 16),),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,
                          vertical: 2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ]
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: (){},
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                children: [
                                  Row(children: [
                                    Icon(Icons.shopping_bag),
                                    const SizedBox(width: 10,),
                                    Text('My Orders'),
                                  ],)
                                ],
                              ),
                            ),

                          ),
                          const Divider(),

                          InkWell(
                            onTap: (){},
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                children: [
                                  Row(children: [
                                    Icon(Icons.account_balance_wallet),
                                    const SizedBox(width: 10,),
                                    Text('My Wallet'),
                                  ],)
                                ],
                              ),
                            ),

                          ),
                          const Divider(),

                          InkWell(
                            onTap: (){},
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                children: [
                                  Row(children: [
                                    Icon(Icons.favorite),
                                    const SizedBox(width: 10,),
                                    Text('Wishlist'),
                                  ],)
                                ],
                              ),
                            ),

                          ),
                        ],
                      ),
                    )
                  ],
                ),

              ],
            ),
          ),
        ))



      ],),

    );
  }
}

