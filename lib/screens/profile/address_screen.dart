import 'package:ecom/controller/profile/address_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressScreen extends StatelessWidget {
   AddressScreen({super.key});

  final controller = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme
        .of(context)
        .primaryColor;
    return Scaffold(
      appBar: AppBar(title: Text('Address',
        style: TextStyle(color: primaryColor),),),
      body: Padding(padding: EdgeInsets.all(10),
        child:Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              height: 180,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]
              ),
              child:
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Address ', style: TextStyle(
                        fontSize: 18,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      SizedBox(width: 10,),
                      Container(width: 260,
                        height: 60,
                        child:
                       Obx(() =>  controller.isLoading.value ?
                        TextField(
                          controller: controller.addressController,
                          cursorColor: primaryColor,
                          decoration: InputDecoration(
                            label: Text('Address'),
                            labelStyle: TextStyle(color: primaryColor),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: primaryColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: primaryColor),
                            ),
                          ),
                        ):       TextField(
                              controller: controller.addressController,
                              cursorColor: primaryColor,
                              decoration: InputDecoration(
                                label: Text('Address'),
                                labelStyle: TextStyle(color: primaryColor),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: primaryColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: primaryColor),
                                ),
                              ),
                            ),
                      ),
                      ),

                    ],),
                  SizedBox(height: 10,),

                  SizedBox(height: 15,),
                  ElevatedButton(onPressed: (){
                    controller.updateAddress();
                  }, child: Text('Update'),
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: primaryColor
                    ),),

                ],) ,
            ),

          ],
        ),
      )
      ,

    );
  }
}


