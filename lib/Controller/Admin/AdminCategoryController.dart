// ignore_for_file: file_names, unused_import, avoid_print, unused_local_variable, avoid_function_literals_in_foreach_calls, non_constant_identifier_names, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/View/Admin/Categories/category.dart';
import 'package:ecom_app/Widgets/Messege.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

class AdminCategoryController extends GetxController {
  var isLoading = true;
  var CategoryList = [];
  var filepath = "";
  final ImagePicker _picker = ImagePicker();
  File? image; // Corrected variable type to File?
  String? CatdownloadUrl; // Define the variable to avoid undefined name error

  CollectionReference categoryInst =
      FirebaseFirestore.instance.collection('Category');

  getCategoryList() async {
    CategoryList.clear();
    await categoryInst.get().then((QuerySnapshot data) {
      data.docs.forEach((element) {
        CategoryList.add(element.data());
      });
    });
    print(CategoryList);
    update();
  }

  setImage(source) async {
    final XFile? file = await _picker.pickImage(source: source);
    if (file != null) {
      print(file.path);
      image = File(file.path);
      filepath = file.path;
    }
    update();
  }

  updateCategoryStatus(index, status, name) async {
    if (status == true) {
      await categoryInst.doc(CategoryList[index]['catkey']).update({
        'status': !CategoryList[index]['status']
      });
      CategoryList[index]['status'] = !CategoryList[index]['status'];
    } else {
      var filename = filepath.split("/").last;

      final storageRef = FirebaseStorage.instance.ref();
      final imagesRef = storageRef.child("dish/${filename}");
      await imagesRef.putFile(image!);
      CatdownloadUrl = await imagesRef.getDownloadURL();
      print(CatdownloadUrl);

      print(name.toString());
      await categoryInst.doc(CategoryList[index]['catkey']).update({
        'name': name,
        'CatImage': CatdownloadUrl, // Include the image URL in the update
      });
      getCategoryList();
    }

    update();
  }

  deleteCategory(index) async {
    print(CategoryList[index]['catkey']);
    await categoryInst.doc(CategoryList[index]['catkey']).delete();
    CategoryList.removeAt(index);
    update();
  }

  addCategory(String name) async {
    if (name.isEmpty) {
      ErrorMessege('Error', 'Please enter Category name');
    } else {
      var key = FirebaseDatabase.instance.ref('category').push().key;
         var filename = filepath.split("/").last;

      final storageRef = FirebaseStorage.instance.ref();
      final imagesRef = storageRef.child("dish/${filename}");
      await imagesRef.putFile(image!);
      CatdownloadUrl = await imagesRef.getDownloadURL();
      print(CatdownloadUrl);
      var categoryOb = {
        "name": name,
        "status": true,
        "catkey": key,
        "CatImage": CatdownloadUrl // Use the defined CatdownloadUrl here
      };
      await categoryInst.doc(key).set(categoryOb);
      ErrorMessege('Success', 'Added New Category');
      getCategoryList();
    }
  }
}
