// ignore_for_file: prefer_const_constructors

import 'package:ecom_app/Controller/Admin/AdminDashboardController.dart';
import 'package:ecom_app/View/Admin/DrawerData.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  var controller = Get.put(AdminHomeController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDashboardData();
    });
  }

  getDashboardData() async {
    await controller.getDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Admin Dashboard", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 0,
      ),
      drawer: Drawer(
        child: DrawerData(),
      ),
      body: GetBuilder<AdminHomeController>(builder: (controller) {
        return controller.isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Overview",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    SizedBox(height: 16),
                    GridView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.2,
                      ),
                      children: [
                        _buildStatCard("Users", controller.userCount.toString(), Colors.blue),
                        _buildStatCard("Categories", controller.Category.toString(), Colors.green),
                        _buildStatCard("Dishes", controller.Dishes.toString(), Colors.purple),
                        _buildStatCard("Pending Orders", controller.PendingOrder.toString(), Colors.orange),
                        _buildStatCard("Accepted Orders", controller.acceptedOrder.toString(), Colors.teal),
                        _buildStatCard("Cancelled Orders", controller.CancelOrder.toString(), Colors.redAccent),
                        _buildStatCard("Completed Orders", controller.completeOrder.toString(), Colors.indigo),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              );
      }),
    );
  }

  Widget _buildStatCard(String title, String count, Color color) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [color.withOpacity(0.7), color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 8,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              count,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
