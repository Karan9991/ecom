import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SignInController extends GetxController {
  var emailController = TextEditingController();
  var emailResetController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var rememberMe = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    loadRememberMe();
    super.onInit();
  }

  Future<void> loadRememberMe() async {
    bool? remember = GetStorage().read('rememberme');
    if (remember != null && remember) {
      emailController.text = GetStorage().read('email') ?? '';
      passwordController.text = GetStorage().read('password') ?? '';
      rememberMe.value = remember;
    }
  }

  Future<void> saveRememberMe(bool value, String email, String password) async {
    if (value) {
      GetStorage().write('rememberme', value);
      GetStorage().write('email', email);
      GetStorage().write('password', password);
    } else {
      GetStorage().write('rememberme', value);
      GetStorage().write('email', '');
      GetStorage().write('password', '');
    }
  }

  Future<void> signIn() async {
    if (formKey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Get.snackbar('Signin', 'Sign in ');
        saveRememberMe(rememberMe.value, emailController.text, passwordController.text);
        // Navigate to the next screen upon successful sign-in
        // Get.off(NextScreen());
      } catch (e) {
        Get.snackbar('Error', e.toString());
      }
    }
  }

  void forgotPassword() {
    Color primaryColor = Theme.of(Get.context!).primaryColor;
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: Get.context!,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
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
                    controller: emailResetController,
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
                      // Add email format validation if needed
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        foregroundColor: Colors.white,
                        backgroundColor: primaryColor,
                      ),
                      onPressed: resetPassword,
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

  void resetPassword() async {
    if (emailResetController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your email');
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: emailResetController.text);
      Get.snackbar('Success', 'Password reset email sent');
      Get.back(); // Close the bottom sheet
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
