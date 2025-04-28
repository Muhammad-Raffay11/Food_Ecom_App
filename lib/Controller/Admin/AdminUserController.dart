// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminUserController extends GetxController{

var isLoading = false;

var userList = [];

setLoading(val){
isLoading = val;
update();
}

getAllusers() async {
  setLoading(true);
  CollectionReference users = 
  FirebaseFirestore.instance.collection('users');
 await users.get() .then((QuerySnapshot data) {

      data.docs.forEach((doc) {
        userList.add(doc.data());
      });

  setLoading(false);
  update();

});

}
}