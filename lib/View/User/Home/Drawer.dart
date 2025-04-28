// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecom_app/View/Auth/Login.dart';
import 'package:ecom_app/View/User/AddToCart/AddtoCart.dart';
import 'package:ecom_app/View/User/ChatScreen/chat.dart';
import 'package:ecom_app/View/User/Home/GoogleMaps.dart';
import 'package:ecom_app/View/User/Home/home.dart';
import 'package:ecom_app/View/User/Orders/orders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDrawerData extends StatefulWidget {
  const UserDrawerData({super.key});

  @override
  State<UserDrawerData> createState() => _UserDrawerDataState();
}

class _UserDrawerDataState extends State<UserDrawerData> {
  var name = "User";
  var email = "user@example.com";

  @override
  void initState() {
    super.initState();
    setData();
  }

  setData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name") ?? "User";
      email = prefs.getString("email") ?? "user@example.com";
    });
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.offAll(LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // **Standard Header (180px height)**
          Container(
            height: 180,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orangeAccent, Colors.deepOrange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
            ),
            child: Row(
              children: [
                // **User Profile Image**
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50, color: Colors.black54),
                ),

                SizedBox(width: 15), // Space between image and text

                // **User Info**
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      email,
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 10),

          // **Navigation Items**
          _buildDrawerItem(Icons.home, "Home", () => Get.to(UserDashboard())),
          _buildDrawerItem(Icons.shopping_cart, "My Cart", () => Get.to(AddToCart())),
          _buildDrawerItem(Icons.map, "Google Maps", () => Get.to(GoogleMaps())),
          _buildDrawerItem(Icons.chat, "Chats", () => Get.to(ChatsScreen())),
          _buildDrawerItem(Icons.list_alt, "Orders", () => Get.to(Orders())),

          Spacer(), // Pushes Logout Button to Bottom

          // **Logout Button**
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.redAccent, size: 28),
            title: Text("Log Out", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
            onTap: logout,
          ),

          SizedBox(height: 12), // Add some spacing at bottom
        ],
      ),
    );
  }

  // **Helper Widget for Drawer Items**
  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.orangeAccent, size: 28),
      title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      hoverColor: Colors.orange.shade100,
    );
  }
}
