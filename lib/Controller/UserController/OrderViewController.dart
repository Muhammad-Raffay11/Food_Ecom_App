// ignore_for_file: avoid_print, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/Helper/Global.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class viewAllController extends GetxController {
  var isLoading = false;
  var orders = [];

  setLoading(val) {
    isLoading = val;
  }

  getOrders(status) async {
    try {
      orders.clear();
      update();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      uid == "" ? prefs.getString("uid") : uid;

      CollectionReference userOrderInst = FirebaseFirestore.instance.collection("userOrder");
      userOrderInst
          .where("userUid", isEqualTo: uid)
          .where("status", isEqualTo: status)
          .get()
          .then((QuerySnapshot data) {
        final allOrders = data.docs.map((doc) => doc.data()).toList();
        orders = allOrders;
        update();
      });
    } catch (e) {
      print('Error fetching orders: $e');
      Get.snackbar("Error", "Failed to fetch orders. Please try again.");
    }
  }
}