// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminHomeController extends GetxController {
  var isLoading = false;
  var userCount = 0;
  var Category = 0;
  var Dishes = 0;
  var PendingOrder = 0;
  var completeOrder = 0;
  var CancelOrder = 0;
  var acceptedOrder = 0;

  setLoading(val) {
    isLoading = val;
    update();
  }

  getDashboardData() async {
    setLoading(true);
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.get().then((QuerySnapshot data) {
      print(data.docs.length);
      userCount = data.docs.length;
    });


     CollectionReference CategoryRef = FirebaseFirestore.instance.collection('Category');
    await CategoryRef.get().then((QuerySnapshot data) {
      Category = data.docs.length;
    });

      CollectionReference DishesRef = FirebaseFirestore.instance.collection('Dishes');
    await DishesRef.get().then((QuerySnapshot data) {
      Dishes = data.docs.length;
    });



      CollectionReference AllOrderRef = FirebaseFirestore.instance.collection('allOrder');
    await AllOrderRef.get().then((QuerySnapshot data) {
      
      Dishes = data.docs.length;
      for(var i=0;i<data.docs.length;i++){
        log(data.docs[i]["status"].toString());
        if(data.docs[i]["status"]=="accepted"){
          acceptedOrder +=1;
        
        }
        else if(data.docs[i]["status"]=="pending"){
          PendingOrder +=1;
        
        }
         else if(data.docs[i]["status"]=="cancel"){
          CancelOrder +=1;
        
        }
         else if(data.docs[i]["status"]=="complete"){
          completeOrder +=1;
        
        }
      }

    });
    setLoading(false);




    update();

    
  }
}