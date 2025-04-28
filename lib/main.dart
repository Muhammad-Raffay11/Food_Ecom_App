// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:ecom_app/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print('Firebase initialization error: $e');
  }

  // Initialize Stripe
  Stripe.publishableKey = 'pk_test_51Q7b33P8hq2vnhwLKdDwq7wV6F4hbU9LG4Likfzizyuv9PjlFvjtXNPpnit70181G3nyxOmDtSDwpTDYSP1pvAgR00jp4cmU96';
  await Stripe.instance.applySettings();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: SplashScreen(),
    );
  }
}