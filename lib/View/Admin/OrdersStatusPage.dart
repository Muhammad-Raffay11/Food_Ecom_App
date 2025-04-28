// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:ecom_app/View/Admin/DrawerData.dart';
import 'package:ecom_app/View/Admin/ViewOrderType.dart';
import 'package:flutter/material.dart';

class AdminOrders extends StatefulWidget {
  const AdminOrders({super.key});

  @override
  State<AdminOrders> createState() => _OrdersState();
}

class _OrdersState extends State<AdminOrders> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: SafeArea(
        child: Scaffold(
          drawer: Drawer(
            child: DrawerData(),
          ),
          appBar: AppBar(
            backgroundColor: Colors.deepOrangeAccent,
            title: Center(
              child: Text(
                "Admin Orders",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            bottom: TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.white70,
              labelColor: Colors.white,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.orangeAccent,
              ),
              indicatorWeight: 3,
              tabs: [
                Tab(child: Text("Pending")),
                Tab(child: Text("Accepted")),
                Tab(child: Text("In Progress")),
                Tab(child: Text("Completed")),
                Tab(child: Text("Cancelled")),
              ],
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.orange.shade100],
              ),
            ),
            child: TabBarView(
              children: [
                ViewOrderType(type: "pending"),
                ViewOrderType(type: "accepted"),
                ViewOrderType(type: "inprogress"),
                ViewOrderType(type: "complete"),
                ViewOrderType(type: "cancel"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
