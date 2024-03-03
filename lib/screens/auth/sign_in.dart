import 'package:ecom/screens/auth/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _emailResetController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _rememberMe = false;
  final rememberMe = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadRememberMe();
  }

  Future<void> loadRememberMe() async {
    bool? rememberMee = rememberMe.read('rememberme');

    if (rememberMee == null || rememberMee == false) {
    } else {
      setState(() {
        _emailController.text = rememberMe.read('email');
        _passwordController.text = rememberMe.read('password');
        _rememberMe = rememberMee;
      });
    }
  }

  Future<void> saveRememberMe(bool value, String email, String password) async {
    if (value) {
      rememberMe.write('rememberme', value);
      rememberMe.write('email', email);
      rememberMe.write('password', password);
    } else {
      rememberMe.write('rememberme', value);
      rememberMe.write('email', null);
      rememberMe.write('password', null);
    }
  }

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        Get.snackbar('Signin', 'Sign in ');
        saveRememberMe(
            _rememberMe, _emailController.text, _passwordController.text);

        // Navigate to the next screen upon successful sign-in
        // Get.off(NextScreen());
      } catch (e) {
        Get.snackbar('Error', e.toString());
      }
    }
  }

  void _forgotPassword() {
    Color primaryColor = Theme.of(context).primaryColor;

    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            // Wrap with SingleChildScrollView to avoid overflow
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    cursorColor: primaryColor,
                    controller: _emailResetController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.mail,
                          color: Colors.greenAccent,
                        ),
                        fillColor: primaryColor,
                        labelText: 'Email',
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Set border radius

                            borderSide: BorderSide(color: primaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Set border radius

                            borderSide: BorderSide(color: primaryColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Set border radius

                            borderSide: BorderSide(color: primaryColor))),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      // Add email format validation if needed
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  // ElevatedButton(
                  //   onPressed: _resetPassword,
                  //   child: Text('Reset Password'),
                  // ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          foregroundColor: Colors.white,
                          backgroundColor: primaryColor),
                      onPressed: _resetPassword,
                      child: const Text('Reset Password'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _resetPassword() async {
    if (_emailResetController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your email');
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: _emailResetController.text);
      Get.snackbar('Success', 'Password reset email sent');
      Navigator.pop(context); // Close the bottom sheet
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
          //   title: Text('Sign Up'),
          ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 200,
                  height: 150,
                ),
                TextFormField(
                  cursorColor: primaryColor,
                  controller: _emailController,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.mail,
                        color: Colors.greenAccent,
                      ),
                      fillColor: primaryColor,
                      labelText: 'Email',
                      labelStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // Set border radius

                          borderSide: BorderSide(color: primaryColor)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // Set border radius

                          borderSide: BorderSide(color: primaryColor)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // Set border radius

                          borderSide: BorderSide(color: primaryColor))),
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
                  cursorColor: primaryColor,
                  controller: _passwordController,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.greenAccent,
                      ),
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // Set border r
                          borderSide: BorderSide(color: primaryColor)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // Set border r
                          borderSide: BorderSide(color: primaryColor)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // Set border r
                          borderSide: BorderSide(color: primaryColor))),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Checkbox(
                      side: BorderSide(color: Colors.grey),
                      activeColor: primaryColor,
                      focusColor: primaryColor,
                      checkColor: Colors.white,
                      hoverColor: primaryColor,
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value!;
                        });
                      },
                    ),
                    const Text(
                      style: TextStyle(color: Colors.grey),
                      'Remember Me',
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    InkWell(
                      onTap: _forgotPassword,
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        text: 'By login you agree with all the ',
                      ),
                      TextSpan(
                        text: 'Terms & Conditions',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        foregroundColor: Colors.white,
                        backgroundColor: primaryColor),
                    onPressed: _signIn,
                    child: const Text('Sign In'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        foregroundColor: Colors.white,
                        backgroundColor: primaryColor),
                    onPressed: () {
                      Get.to(SignUpScreen());
                    },
                    child: const Text('Sign Up'),
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
