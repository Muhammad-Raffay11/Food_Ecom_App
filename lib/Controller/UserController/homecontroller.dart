// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var dishLoading = true;
  var isLoading = true;
  var SelectDish = [];
  var CategoryList = [];

  CollectionReference categoryInst = FirebaseFirestore.instance.collection('Category');
  CollectionReference DishInst = FirebaseFirestore.instance.collection("Dishes");

  setData() {
    SelectDish.clear();
    update();
  }

  setDishLoading(val) {
    dishLoading = val;
    update();
  }

  getCategoryList() async {
    try {
      CategoryList.clear();
      await categoryInst.where("status", isEqualTo: true).get().then((QuerySnapshot data) {
        data.docs.forEach((element) {
          CategoryList.add(element.data());
        });
      });
      print(CategoryList);
      update();
    } catch (e) {
      print('Error fetching categories: $e');
      Get.snackbar("Error", "Failed to fetch categories. Please try again.");
    }
  }

  getDishByIdCategory(key) async {
    try {
      setDishLoading(true);
      await DishInst.where("CategoryKey", isEqualTo: key).get().then((QuerySnapshot data) {
        final allDishData = data.docs.map((doc) => doc.data()).toList();
        SelectDish = allDishData;
        setDishLoading(false);
        update();
      });
    } catch (e) {
      print('Error fetching dishes: $e');
      Get.snackbar("Error", "Failed to fetch dishes. Please try again.");
    }
  }
}