// ignore_for_file: prefer_const_constructors
import 'package:ecom_app/Controller/Admin/AdminUserController.dart';
import 'package:ecom_app/View/Admin/drawerData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  var userAdminController = Get.put(AdminUserController());

  @override
  void initState() {
    super.initState();
    getAllusers();
  }

  getAllusers() {
    print('all users');
    userAdminController.getAllusers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Users List", style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.deepOrangeAccent,
          centerTitle: true,
        ),
        drawer: Drawer(
          child: DrawerData(),
        ),
        body: GetBuilder<AdminUserController>(
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Users List",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  controller.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Expanded(
                          child: ListView.builder(
                            itemCount: controller.userList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.deepOrangeAccent,
                                    child: Icon(Icons.person, color: Colors.white),
                                  ),
                                  title: Text(
                                    controller.userList[index]['name'].toString(),
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
