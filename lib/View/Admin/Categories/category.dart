// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecom_app/Controller/Admin/AdminCategoryController.dart';
import 'package:ecom_app/View/Admin/DrawerData.dart';
import 'package:ecom_app/Widgets/ButtonStyle.dart';
import 'package:ecom_app/Widgets/TextField.dart';
import 'package:image_picker/image_picker.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final TextEditingController CategoryController = TextEditingController();
  final AdminCategoryController controller = Get.put(AdminCategoryController());
  var edittext = TextEditingController();
  var selectedindex;

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  void getAllCategories() {
    controller.getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Manage Categories', style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
        ),
        drawer: Drawer(child: DrawerData()),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            controller.addCategory(CategoryController.text);
          },
          child: Icon(Icons.add, color: Colors.white),
        ),
        body: GetBuilder<AdminCategoryController>(
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ButtonStyleWidget2(
                                    onPress: () {},
                                    buttonLabel: "Take Photo", 
                                    textStyle: TextStyle(color: Colors.black),
                                  ),
                                  ButtonStyleWidget2(
                                    onPress: () {
                                      Navigator.pop(context);
                                      controller.setImage(ImageSource.gallery);
                                    },
                                    buttonLabel: "Choose from Gallery", 
                                    textStyle: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: controller.image == null
                            ? NetworkImage("https://static.vecteezy.com/system/resources/previews/007/567/154/original/select-image-icon-vector.jpg")
                            : FileImage(controller.image!) as ImageProvider,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Add Category", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  TextFieldWidget(
                    passwordField: false,
                    hintTextdaat: "Enter Category Name",
                    controller: CategoryController,
                  ),
                  SizedBox(height: 20),
                  controller.CategoryList.isNotEmpty
                      ? Expanded(
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            elevation: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Text('Categories', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: controller.CategoryList.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          elevation: 3,
                                          child: ListTile(
                                            title: Text(controller.CategoryList[index]["name"],
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  icon: Icon(Icons.edit, color: Colors.blue),
                                                  onPressed: () {
                                                    edittext.text = controller.CategoryList[index]["name"].toString();
                                                    showDialog(
                                                      context: context,
                                                      builder: (_) => AlertDialog(
                                                        title: Text("Edit Category"),
                                                        content: TextField(controller: edittext),
                                                        actions: [
                                                          TextButton(
                                                            child: Text("Cancel"),
                                                            onPressed: () => Navigator.pop(context),
                                                          ),
                                                          TextButton(
                                                            child: Text("Update"),
                                                            onPressed: () {
                                                              controller.updateCategoryStatus(index, false, edittext.text);
                                                              Navigator.pop(context);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.delete, color: Colors.red),
                                                  onPressed: () {
                                                    controller.deleteCategory(index);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Center(child: Text("No Categories Available", style: TextStyle(fontSize: 16))),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
