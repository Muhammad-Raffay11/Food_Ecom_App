// ignore_for_file: avoid_print, prefer_const_constructors, unused_local_variable

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/Helper/Global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddToCartController extends GetxController {
  var userCart = [];
  Map<String, dynamic>? paymentIntent;

  TextEditingController address = TextEditingController();
  TextEditingController contactno = TextEditingController();

  calculateTotalPrice() {
  var totalPrice = 0;
  for (var item in userCart) {
    var dishPrice = int.tryParse(item["DishPrice"]?.toString() ?? "0") ?? 0; // ✅ Safe parsing
    var quantity = (item["quantity"] as num?)?.toInt() ?? 1; // ✅ Convert safely

    totalPrice += (dishPrice * quantity); // ✅ Guaranteed int values
  }
  update(); // Notify UI updates if using GetX
}



  // Make Payment function
  Future<void> makePayment(int amount) async {
    try {
      print("Creating Payment Intent for amount: $amount");

      paymentIntent = await createPaymentIntent(amount.toString(), 'usd');
      print('Payment Intent Created: ${paymentIntent!['client_secret']}');

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: 'My Store',
        ),
      );

      print("Payment Sheet Initialized. Showing payment sheet now...");
      await displayPaymentSheet(amount);
    } catch (err) {
      print("Error in makePayment: $err");
      Get.snackbar("Payment Error", "Failed to process payment. Please try again.");
    }
  }

  // Display Payment Sheet
  Future<void> displayPaymentSheet(int amount) async {
    try {
      print("Presenting Payment Sheet...");
      await Stripe.instance.presentPaymentSheet();
      print('Payment Successful');

      // Order is placed only if payment is successful
      await orderNow(amount);
      Get.snackbar("Success", "Payment Completed & Order Placed!");
    } catch (e) {
      print('Error displaying Payment Sheet: $e');
      Get.snackbar("Payment Failed", "Payment was not completed. Try again.");
    }
  }

  // Calculate amount for Stripe (Stripe expects the amount in cents)
  String calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }

  // Create Payment Intent
  Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
   const String secretKey = 'sk_test_51Q7b33P8hq2vnhwLdej4HlY5EfIgecx3hFj2XKOfZvPpVeDK8n2miMZ59pJsnwxFSxprYuJkkWa9YGb2gWNh66II00kWLT5sez'; 
    final uri = Uri.parse('https://api.stripe.com/v1/payment_intents');
    final headers = {
     'Authorization': 'Bearer $secretKey',
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    Map<String, dynamic> body = {
      'amount': calculateAmount(amount),
      'currency': currency,
      'payment_method_types[]': 'card', // Required field for Stripe
    };

    try {
      print("Sending request to Stripe...");
      final response = await http.post(uri, headers: headers, body: body);

      print("Stripe Response Status: ${response.statusCode}");
      print("Stripe Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to create payment intent: ${response.body}');
      }
    } catch (err) {
      print("Error Creating Payment Intent: $err");
      throw Exception('Failed to create payment intent: $err');
    }
  }

  // Add items to cart
  Future<void> userAddToCart(data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    data["quantity"] = 1;
    userCart.add(data);
    Cartlist.add(data); // Assuming `Cartlist` is a global variable
    update(); // Refresh state
  }

  // Fetch data from cart
  void getData() {
    userCart = Cartlist; // Assuming `Cartlist` is globally available
    update(); // Refresh state
  }

// remove item from cart
    void removeItem(int index) {
    if (index >= 0 && index < userCart.length) {
      userCart.removeAt(index);
      update(); // Notify UI of changes
    }
  }

  // Update cart (increase or decrease quantity)
  updateCart(int index, String status) {
    if (status == "inc") {
      userCart[index]["quantity"] += 1;
    } else if (userCart[index]["quantity"] > 1) {
      userCart[index]["quantity"] -= 1;
    }
    update(); // Refresh state
  }

  // Check if an item is already in the cart
  bool checkCart(data) {
    for (var i = 0; i < userCart.length; i++) {
      if (userCart[i]["DishKey"] == data["DishKey"]) {
        return true;
      }
    }
    return false;
  }

  // Display bottom sheet for order details
  void showBottomSheetFunc(BuildContext context, int totalPrice) {
  totalPrice = totalPrice; // Ensure total price is not null

  print("Current Cart: $userCart");
  print("Calculated Total Price: $totalPrice");

  showModalBottomSheet(
    isDismissible: false,
    isScrollControlled: true, // 👈 Allows bottom sheet to resize with keyboard
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // 👈 Prevents overlap
          left: 10,
          right: 10,
          top: 20,
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min, // 👈 Adjusts size dynamically
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Order Details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 15),

                // Contact Number Field
                TextField(
                  controller: contactno,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Enter Contact Number",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),

                // Address Field
                TextField(
                  controller: address,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    labelText: "Enter Address",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                // Place Order Button
                ElevatedButton(
                  onPressed: () {
                    checkAndValidate(context, totalPrice);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Place Order",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    },
  );
}


  // Validate address and contact number
  void checkAndValidate(BuildContext context, int totalPrice) {
    if (address.text.isEmpty) {
      Get.snackbar("Error", "Please Enter your Address");
    } else if (contactno.text.isEmpty || contactno.text.length != 10) {
      Get.snackbar("Error", "Please Enter a valid contact number");
    } else {
      Navigator.pop(context);
      showAlertDialog(context, totalPrice);
    }
  }

  // Show alert dialog for order confirmation
  void showAlertDialog(BuildContext context, int totalPrice) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Your Order"),
          content: Text("Order Place Confirmation\nPrice: $totalPrice"),
          actions: [
            TextButton(
              child: Text("No"),
              onPressed: () {
                print("User clicked NO. Closing dialog.");
                Navigator.pop(dialogContext);
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () async {
                print("User clicked YES. Closing dialog and starting payment.");
                Navigator.pop(dialogContext); // Close the confirmation dialog first

                await Future.delayed(Duration(milliseconds: 500)); // Small delay to ensure dialog closes properly

                await makePayment(totalPrice); // Start Stripe payment
              },
            ),
          ],
        );
      },
    );
  }

  // Place the order after payment confirmation
  Future<void> orderNow(int totalPrice) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString("email");
      var uid = FirebaseAuth.instance.currentUser?.uid;
      var key = FirebaseDatabase.instance.ref('Orders').push().key;

      var orderData = {
        "userUid": uid,
        "email": email,
        "orders": userCart,
        "totalPrice": totalPrice,
        "address": address.text,
        "contact": contactno.text,
        "orderkey": key,
        "status": "pending",
        "reason": ""
      };

      CollectionReference userOrderInst = FirebaseFirestore.instance.collection("userOrder");
      CollectionReference adminOrderInst = FirebaseFirestore.instance.collection("allOrder");

      await userOrderInst.doc(key).set(orderData);
      await adminOrderInst.doc(key).set(orderData);

      userCart.clear();
      update(); // Refresh state
      Get.back(); // Close the payment sheet
      Get.back(); // Close the confirmation dialog
      Get.snackbar("Success", "Order placed successfully");
    } catch (e) {
      print('Error placing order: $e');
      Get.snackbar("Error", "Failed to place order. Please try again.");
    }
  }

  @override
  void dispose() {
    address.dispose();
    contactno.dispose();
    super.dispose();
  }
}