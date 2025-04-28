// ignore_for_file: avoid_print, non_constant_identifier_names, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/Helper/Global.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminControllerChat extends GetxController {
  RxList UserChatList = [].obs;

  getAllChatsList() async {
    try {
      UserChatList.clear();
      var data = await FirebaseFirestore.instance
          .collection("conversations")
          .where("RecieverId", isEqualTo: "DiTxqAal0RfLihvn9I16J5VjlXG3")
          .get();
      var userChat = data.docs;
      for (var i = 0; i < userChat.length; i++) {
        UserChatList.add(userChat[i]);
      }
    } catch (e) {
      print('Error fetching chats: $e');
      Get.snackbar("Error", "Failed to fetch chats. Please try again.");
    }
  }

  createConservation(senderIdUser) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var data = await FirebaseFirestore.instance.collection("conversations").get();
      var p = data.docs;
      var con_id = "";

      var senderId = prefs.getString("uid");
      var email = prefs.getString("email");
      var name = prefs.getString("name");

      for (var i = 0; i < p.length; i++) {
        if (p[i]["SenderId"] == senderIdUser && p[i]["RecieverId"] == senderId) {
          con_id = p[i]["conservation_id"];
        }
      }

      conservation_id = con_id;
    } catch (e) {
      print('Error creating conversation: $e');
      Get.snackbar("Error", "Failed to create conversation. Please try again.");
    }
  }
}