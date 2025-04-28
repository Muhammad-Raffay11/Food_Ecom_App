// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecom_app/View/Admin/Categories/category.dart';
import 'package:ecom_app/View/Admin/ChatList.dart';
import 'package:ecom_app/View/Admin/Dashboard.dart';
import 'package:ecom_app/View/Admin/Dish/dish.dart';
import 'package:ecom_app/View/Admin/OrdersStatusPage.dart';
import 'package:ecom_app/View/Admin/UserList.dart';
import 'package:ecom_app/View/Auth/Login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerData extends StatefulWidget {
  const DrawerData({super.key});

  @override
  State<DrawerData> createState() => _DrawerDataState();
}

class _DrawerDataState extends State<DrawerData> {
  var name = "";
  var email = "";

  @override
  void initState() {
    super.initState();
    setData();
  }

  setData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name") ?? "Admin";
    email = prefs.getString("email") ?? "admin@example.com";
    setState(() {});
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.offAll(LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepOrange, Colors.orangeAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40,
                  child: Icon(Icons.person, size: 50, color: Colors.deepOrangeAccent),
                ),
                SizedBox(width: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(email, style: TextStyle(color: Colors.white, fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),
          _buildDrawerItem(Icons.dashboard, "Dashboard", () => Get.off(AdminDashboard())),
          _buildDrawerItem(Icons.people, "Users", () => Get.off(UserList())),
          _buildDrawerItem(Icons.category, "Add Category", () => Get.to(AddCategory())),
          _buildDrawerItem(Icons.restaurant_menu, "Dish Page", () => Get.to(AdminDishPage())),
          _buildDrawerItem(Icons.shopping_cart, "Order Page", () => Get.to(AdminOrders())),
          _buildDrawerItem(Icons.chat, "Chat Page", () => Get.to(ChatsScreenAdmin())),
          _buildDrawerItem(Icons.settings, "Settings", () {}),
          Divider(),
          _buildDrawerItem(Icons.logout, "Log Out", () => logout(), color: Colors.red),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap, {Color color = Colors.black87}) {
    return ListTile(
      leading: Icon(icon, color: color, size: 28),
      title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      onTap: onTap,
    );
  }
}
