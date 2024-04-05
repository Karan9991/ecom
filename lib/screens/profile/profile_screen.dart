import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme
        .of(context)
        .primaryColor;
    return Scaffold(
      appBar: AppBar(title: Text('Profile',
      style: TextStyle(color: primaryColor),),),
      body: Padding(padding: EdgeInsets.all(10),
    child:Stack(
      alignment: Alignment.bottomCenter,
    children: [

    Container(
      padding: EdgeInsets.all(20),
      height: 240,
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
  //          mainAxisAlignment: MainAxisAlignment.center,
//crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                  Text('Name ', style: TextStyle(
                    fontSize: 18,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  SizedBox(width: 10,),
                  Container(width: 280,
                    height: 60,
                    child:
                  TextField(
                    cursorColor: primaryColor,
                    decoration: InputDecoration(
                      label: Text('Name'),
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

                ],),
              SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Email ', style: TextStyle(
                    fontSize: 18,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(width: 10,),
                  Container(width: 280,
                    child:
                    TextField(
                      cursorColor: primaryColor,
                      decoration: InputDecoration(
                        label: Text('Email'),
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
                ],),
              SizedBox(height: 15,),
              ElevatedButton(onPressed: (){}, child: Text('Update'),
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


