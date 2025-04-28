// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecom_app/Controller/AuthController.dart';
import 'package:ecom_app/View/Auth/Signup.dart';
import 'package:ecom_app/Widgets/TextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authController = Get.put(AuthController());

  String? emailError;
  String? passwordError;
  String? loginError;

  void validateAndLogin() {
    setState(() {
      emailError = null;
      passwordError = null;
      loginError = null;
    });

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty) {
      setState(() {
        emailError = "Email cannot be empty";
      });
      return;
    } else if (!GetUtils.isEmail(email)) {
      setState(() {
        emailError = "Enter a valid email";
      });
      return;
    }

    if (password.isEmpty) {
      setState(() {
        passwordError = "Password cannot be empty";
      });
      return;
    } else if (password.length < 6) {
      setState(() {
        passwordError = "Password must be at least 6 characters";
      });
      return;
    }

    // Call Login function and handle errors
    authController.LoginUser(email, password).catchError((error) {
      setState(() {
        loginError = "Invalid email or password"; // Handle login errors
      });
    });
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
                      'Hey User\nWelcome Back!',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Main login form container with SingleChildScrollView
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Sign in',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),

                          // Email TextField with error message
                          TextFieldWidget(
                            passwordField: false,
                            suffixIcon: Icon(Icons.email),
                            hintText: 'Enter email',
                            controller: emailController,
                            width: MediaQuery.of(context).size.width * 0.96,
                            hintTextdaat: '',
                          ),
                          if (emailError != null)
                            Padding(
                              padding: EdgeInsets.only(left: 10, top: 5),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  emailError!,
                                  style: TextStyle(color: Colors.red, fontSize: 14),
                                ),
                              ),
                            ),

                          const SizedBox(height: 10),

                          // Password TextField with error message
                          TextFieldWidget(
                            passwordField: true,
                            show: controller.password,
                            suffixIcon: controller.password
                                ? Icon(Icons.visibility_off_outlined)
                                : Icon(Icons.visibility_outlined),
                            onPress: () {
                              controller.setPassword(controller.password);
                            },
                            hintText: 'Enter password',
                            controller: passwordController,
                            width: MediaQuery.of(context).size.width * 0.96,
                            hintTextdaat: '',
                          ),
                          if (passwordError != null)
                            Padding(
                              padding: EdgeInsets.only(left: 10, top: 5),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  passwordError!,
                                  style: TextStyle(color: Colors.red, fontSize: 14),
                                ),
                              ),
                            ),

                          const SizedBox(height: 20),

                          // Forgot Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Color(0xff281537),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Login button with loading indicator and error message
                          controller.isLoading
                              ? CircularProgressIndicator()
                              : Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: validateAndLogin,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color.fromARGB(255, 255, 102, 0), // Button color
                                        minimumSize: Size(150, 45), // Size of the button
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12), // Rounded edges
                                        ),
                                        shadowColor: Colors.black.withOpacity(0.2),
                                        elevation: 5,
                                      ),
                                      child: Text(
                                        "SIGN IN",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),

                                    if (loginError != null)
                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                          loginError!,
                                          style: TextStyle(color: Colors.red, fontSize: 14),
                                        ),
                                      ),
                                  ],
                                ),

                          const SizedBox(height: 45),

                          // Sign-up prompt
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.off(SignUp());
                                  },
                                  child: Text(
                                    "Sign up",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
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
