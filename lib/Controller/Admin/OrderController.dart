// ignore_for_file: non_constant_identifier_names, unused_local_variable, file_names, invalid_use_of_protected_member, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

// GetBuilder,obx

class AdminOrderController extends GetxController {
  RxBool isLoading = true.obs;
  RxList OrderType = [].obs;
  setLoading(val) {
    isLoading.value = val;
  }

  UpdateOrder(key, type, reason,index) async {
    CollectionReference AllOrderRef =
        FirebaseFirestore.instance.collection('allOrder');
    await AllOrderRef.doc(key).update({"status": type, "reason": reason});
    CollectionReference AllUserOrderRef =
        FirebaseFirestore.instance.collection('userOrder');
    await AllUserOrderRef.doc(key).update({"status": type,"reason": reason});
    var newdata = OrderType.value;
    newdata.removeAt(index);
    OrderType.value=newdata;
    update();

    

  }

 InProgressOrder(key, type, reason,index) async {
 CollectionReference AllOrderRef =
        FirebaseFirestore.instance.collection('allOrder');
    await AllOrderRef.doc(key).update({"status": type, "reason": reason});
    CollectionReference AllUserOrderRef =
        FirebaseFirestore.instance.collection('userOrder');
    await AllUserOrderRef.doc(key).update({"status": type,"reason": reason});
    var newdata = OrderType.value;
    newdata.removeAt(index);
    OrderType.value=newdata;
    update();
  }

  getAllOrders(type) async {
    CollectionReference AllOrderRef =
        FirebaseFirestore.instance.collection('allOrder');
    setLoading(true);
    await AllOrderRef.get().then((QuerySnapshot data) {
      var orderdata = [];
      data.docs.forEach((doc) {
        var newdata = doc.data() as Map;
        if (newdata["status"] == type) {
          orderdata.add(doc.data());
        }
      });
      OrderType.value = orderdata;
      setLoading(false);
    });
  }
}