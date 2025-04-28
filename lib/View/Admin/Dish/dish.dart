// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecom_app/Controller/Admin/AdminDishController.dart';
import 'package:ecom_app/View/Admin/drawerData.dart';
import 'package:ecom_app/Widgets/TextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class AdminDishPage extends StatefulWidget {
  const AdminDishPage({super.key});

  @override
  State<AdminDishPage> createState() => _AdminDishPageState();
}

class _AdminDishPageState extends State<AdminDishPage> {
  final dishController = Get.put(AdminDishController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getCategory());
  }

  getCategory() async {
    await dishController.getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dish Management", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
      ),
      drawer: Drawer(child: DrawerData()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => dishController.addDish(),
        backgroundColor: Colors.black,
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: GetBuilder<AdminDishController>(
        builder: (controller) {
          return controller.isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => showImagePickerModal(context),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: controller.image == null
                              ? NetworkImage("https://static.vecteezy.com/system/resources/previews/007/567/154/original/select-image-icon-vector.jpg")
                              : FileImage(controller.image!) as ImageProvider,
                          child: Icon(Icons.camera_alt, color: Colors.black45, size: 30),
                        ),
                      ),
                      SizedBox(height: 15),
                      buildDropdown(),
                      SizedBox(height: 15),
                      TextFieldWidget(
                        hintText: "Enter Dish Name",
                        width: MediaQuery.of(context).size.width * 0.9,
                        controller: controller.dishName, hintTextdaat: '',
                      ),
                      SizedBox(height: 15),
                      TextFieldWidget(
                        hintText: "Enter Dish Price",
                        width: MediaQuery.of(context).size.width * 0.9,
                        controller: controller.dishPrice, hintTextdaat: '',
                      ),
                      SizedBox(height: 20),
                      controller.allDish.isEmpty
                          ? Center(child: Text("No dishes found", style: TextStyle(fontSize: 16)))
                          : buildDishList(),
                    ],
                  ),
                );
        },
      ),
    );
  }

  Widget buildDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: Text("Select Category"),
          isExpanded: true,
          value: dishController.dropdownvalue.isNotEmpty ? dishController.dropdownvalue : null,
          items: dishController.allDish.map((item) {
            return DropdownMenuItem(value: item, child: Text(item["name"]));
          }).toList(),
          onChanged: (newValue) => dishController.setDropdownValue(newValue),
        ),
      ),
    );
  }

  Widget buildDishList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: dishController.SelectDish.length,
      itemBuilder: (context, index) {
        final dish = dishController.SelectDish[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(dish["DishImage"] ?? ""),
            ),
            title: Text(dish["DishName"], style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Rs: ${dish["DishPrice"]}", style: TextStyle(color: Colors.grey[700])),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () => dishController.deleteDish(index),
            ),
          ),
        );
      },
    );
  }

  void showImagePickerModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 180,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.deepPurple),
                title: Text("Select Picture from Camera"),
                onTap: () => dishController.setImage(ImageSource.camera),
              ),
              ListTile(
                leading: Icon(Icons.photo, color: Colors.deepPurple),
                title: Text("Select Picture from Gallery"),
                onTap: () => dishController.setImage(ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );
  }
}
