// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecom/screens/auth/sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SignUpScreen extends StatefulWidget {
//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   void _signUp() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         UserCredential userCredential =
//             await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: _emailController.text,
//           password: _passwordController.text,
//         );

//         // Store additional data in Firestore
//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(userCredential.user!.uid)
//             .set({
//           'name': _nameController.text,
//           'email': _emailController.text,
//           'address': _addressController.text,
//         });

//         // Send email verification
//         //await userCredential.user?.sendEmailVerification();
//         // Navigate to another screen after successful signup
//         // Get.to(AnotherScreen());
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'weak-password') {
//           Get.snackbar('Error', 'The password provided is too weak.');
//         } else if (e.code == 'email-already-in-use') {
//           Get.snackbar('Error', 'The account already exists for that email.');
//         }
//       } catch (e) {
//         Get.snackbar('Error', e.toString());
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Color primaryColor = Theme.of(context).primaryColor;

//     return Scaffold(
//       appBar: AppBar(
//           //   title: Text('Sign Up'),
//           ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               //  mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/images/logo.png',
//                   width: 200,
//                   height: 150,
//                 ),
//                 TextFormField(
//                   cursorColor: primaryColor,
//                   controller: _nameController,
//                   decoration: InputDecoration(
//                       labelText: 'Name',
//                       prefixIcon: const Icon(
//                         Icons.person,
//                         color: Colors.greenAccent,
//                       ),
//                       labelStyle: const TextStyle(color: Colors.grey),
//                       border: OutlineInputBorder(
//                           borderRadius:
//                               BorderRadius.circular(10.0), // Set border radius

//                           borderSide: BorderSide(color: primaryColor)),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius:
//                               BorderRadius.circular(10.0), // Set border radius

//                           borderSide: BorderSide(color: primaryColor)),
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius:
//                               BorderRadius.circular(10.0), // Set border radius

//                           borderSide: BorderSide(color: primaryColor))),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your name';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   cursorColor: primaryColor,
//                   controller: _addressController,
//                   decoration: InputDecoration(
//                       labelText: 'Address',
//                       prefixIcon: const Icon(
//                         Icons.location_on,
//                         color: Colors.greenAccent,
//                       ),
//                       labelStyle: const TextStyle(color: Colors.grey),
//                       border: OutlineInputBorder(
//                           borderRadius:
//                               BorderRadius.circular(10.0), // Set border radius

//                           borderSide: BorderSide(color: primaryColor)),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius:
//                               BorderRadius.circular(10.0), // Set border radius

//                           borderSide: BorderSide(color: primaryColor)),
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius:
//                               BorderRadius.circular(10.0), // Set border radius

//                           borderSide: BorderSide(color: primaryColor))),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your address';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   cursorColor: primaryColor,
//                   controller: _emailController,
//                   decoration: InputDecoration(
//                       prefixIcon: const Icon(
//                         Icons.mail,
//                         color: Colors.greenAccent,
//                       ),
//                       fillColor: primaryColor,
//                       labelText: 'Email',
//                       labelStyle: const TextStyle(color: Colors.grey),
//                       border: OutlineInputBorder(
//                           borderRadius:
//                               BorderRadius.circular(10.0), // Set border radius

//                           borderSide: BorderSide(color: primaryColor)),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius:
//                               BorderRadius.circular(10.0), // Set border radius

//                           borderSide: BorderSide(color: primaryColor)),
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius:
//                               BorderRadius.circular(10.0), // Set border radius

//                           borderSide: BorderSide(color: primaryColor))),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your email';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   cursorColor: primaryColor,
//                   controller: _passwordController,
//                   decoration: InputDecoration(
//                       prefixIcon: const Icon(
//                         Icons.lock,
//                         color: Colors.greenAccent,
//                       ),
//                       labelText: 'Password',
//                       labelStyle: const TextStyle(color: Colors.grey),
//                       border: OutlineInputBorder(
//                           borderRadius:
//                               BorderRadius.circular(10.0), // Set border r
//                           borderSide: BorderSide(color: primaryColor)),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius:
//                               BorderRadius.circular(10.0), // Set border r
//                           borderSide: BorderSide(color: primaryColor)),
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius:
//                               BorderRadius.circular(10.0), // Set border r
//                           borderSide: BorderSide(color: primaryColor))),
//                   obscureText: true,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your password';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 RichText(
//                   text: const TextSpan(
//                     style: TextStyle(color: Colors.grey),
//                     children: [
//                       TextSpan(
//                         text: 'By sign up you agree with all the ',
//                       ),
//                       TextSpan(
//                         text: 'Terms & Conditions',
//                         style: TextStyle(
//                           color: Colors.green,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         foregroundColor: Colors.white,
//                         backgroundColor: primaryColor),
//                     onPressed: _signUp,
//                     child: const Text('Sign Up'),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         foregroundColor: Colors.white,
//                         backgroundColor: primaryColor),
//                     onPressed: () {
//                       Get.to(SignInScreen());
//                     },
//                     child: const Text('Sign In'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:ecom/controller/signup_controller.dart';
import 'package:ecom/screens/auth/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  final SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 200,
                  height: 150,
                ),
                TextFormField(
                  controller: controller.nameController,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.greenAccent,
                    ),
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.addressController,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    prefixIcon: const Icon(
                      Icons.location_on,
                      color: Colors.greenAccent,
                    ),
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.emailController,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.mail,
                      color: Colors.greenAccent,
                    ),
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.passwordController,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.greenAccent,
                    ),
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        text: 'By sign up you agree with all the ',
                      ),
                      TextSpan(
                        text: 'Terms & Conditions',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.signUp,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      foregroundColor: Colors.white,
                      backgroundColor: primaryColor,
                    ),
                    child: const Text('Sign Up'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.off(SignInScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      foregroundColor: Colors.white,
                      backgroundColor: primaryColor,
                    ),
                    child: const Text('Sign In'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}