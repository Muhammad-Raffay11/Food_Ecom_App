// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, avoid_print, void_checks, non_constant_identifier_names

import 'package:ecom_app/Controller/AuthController.dart';
import 'package:ecom_app/Widgets/TextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Text editing controllers for name, email, and password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final authController = Get.put(AuthController());

  void signUp() {
     if (nameController.text.isEmpty) {
      showError("Error", "Please enter name");
    }
    else if (emailController.text.isEmpty) {
      showError("Error", "Please enter email");
    } else if (passwordController.text.isEmpty) {
      showError("Error", "Please enter password");
    }  else {
      authController.signUpUser(emailController.text, passwordController.text, nameController.text);
    }
  }

  void showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black87,
      borderRadius: 30,
      borderColor: Colors.red,
      borderWidth: 2,
      colorText:Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                // Background gradient
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [ 
                        Color.fromARGB(255, 255, 102, 0),
                        Color.fromARGB(255, 255, 160, 35),
                      ],
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 60.0, left: 22),
                    child: Text(
                      'Create\nYour Account',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Main sign-up form container wrapped in SingleChildScrollView
                Padding(
                  padding: const EdgeInsets.only(top: 200.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: Colors.white,
                    ),
                    height: double.infinity,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 30),
                      child: Column(
                        children: [
                           Text('Sign Up',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),),
                          

                          const SizedBox(height: 20),

                          // Name TextField
                          TextFieldWidget(
                            hintText: 'Enter Name',
                            controller: nameController,
                            width: MediaQuery.of(context).size.width * 0.96,
                            hintTextdaat: '',
                          ),

                          const SizedBox(height: 10),

                          // Email TextField
                          TextFieldWidget(
                            hintText: 'Enter Email',
                            controller: emailController,
                            width: MediaQuery.of(context).size.width * 0.96,
                            hintTextdaat: '',
                          ),

                          const SizedBox(height: 10),

                          // Password TextField
                          TextFieldWidget(
                            hintText: 'Enter Password',
                            controller: passwordController,
                            width: MediaQuery.of(context).size.width * 0.96,
                            hintTextdaat: '',
                          ),

                          const SizedBox(height: 20),

                          // Sign-up button with loading indicator and modern design
                          controller.isLoading
                              ? CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: signUp,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromARGB(255, 255, 102, 0),
                                    minimumSize: Size(150, 45),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    shadowColor: Colors.black.withOpacity(0.2),
                                    elevation: 5,
                                  ),
                                  child: Text(
                                    "SIGN UP",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
