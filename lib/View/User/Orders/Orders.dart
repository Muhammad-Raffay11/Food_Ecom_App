// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:ecom_app/View/User/Orders/ViewOrders.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 4, // Adds slight shadow for a premium feel
          title: Text(
            "Orders",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: TabBar(
                isScrollable: true,
                labelColor: Colors.orange,
                unselectedLabelColor: Colors.black54,
                indicator: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(18),
                ),
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                tabs: [
                  Tab(child: Text("Pending")),
                  Tab(child: Text("Accepted")),
                  Tab(child: Text("In Progress")),
                  Tab(child: Text("Completed")),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: TabBarView(
            children: [
              UserOrders(status: "pending"),
              UserOrders(status: "accepted"),
              UserOrders(status: "inprogress"),
              UserOrders(status: "completed"),
            ],
          ),
        ),
      ),
    );
  }
}
