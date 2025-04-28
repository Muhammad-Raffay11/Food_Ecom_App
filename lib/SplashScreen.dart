// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:ecom_app/View/Admin/dashboard.dart';
import 'package:ecom_app/View/Auth/Login.dart';
import 'package:ecom_app/View/User/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      checkUser();
    });
  }

  checkUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var userCheck = prefs.getBool('Login') ?? false;

      if (userCheck) {
        var userType = prefs.getString('userType');
        if (userType == 'admin') {
          Get.offAll(() => AdminDashboard());
        } else {
          Get.offAll(() => UserDashboard());
        }
      } else {
        Get.offAll(() => LoginScreen());
      }
    } catch (e) {
      print('Error checking user: $e');
      Get.offAll(() => LoginScreen()); // Fallback to login screen on error
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.asset(
            'images/assets/splash.jpg',
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}