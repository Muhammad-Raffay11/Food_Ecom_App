// ignore_for_file: non_constant_identifier_names, file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/Helper/Global.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatController extends GetxController {
  TextEditingController message = TextEditingController();

  SendMessage(receverId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var senderId = prefs.getString("uid");
    var messageid = FirebaseFirestore.instance.collection('message').doc().id;
    var obj = {
      "message": message.text,
      "SenderId": senderId,
      "recieverId": receverId,
      "message_key": messageid,
      "conversation_id": conservation_id,
      "status": true,
      "created_at": FieldValue.serverTimestamp(),
    };
    await FirebaseFirestore.instance
        .collection('message')
        .doc(messageid)
        .set(obj);
        message.clear();
  }



  createConservation(receverID) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var data =
        await FirebaseFirestore.instance.collection("conversations").get();
    var p = data.docs;
    var con_id = "";

    var senderId = prefs.getString("uid");
    var email = prefs.getString("email");
    var name = prefs.getString("name");

    for (var i = 0; i < p.length; i++) {
      if (p[i]["SenderId"] == senderId && p[i]["RecieverId"] == receverID) {
        con_id = p[i]["conservation_id"];
      }
    }
    if (con_id == "") {
      var id = FirebaseFirestore.instance.collection('conversations').doc().id;
      var obj = {
        "RecieverId": receverID,
        "RecieverName": "Admin",
        "SenderName": name,
        "Senderemail": email,
        "SenderId": senderId,
        "lastmessage": "",
        "conservation_id": id
      };
      conservation_id = id;

      await FirebaseFirestore.instance
          .collection('conversations')
          .doc(id)
          .set(obj);
    } else {
      conservation_id = con_id;
    }
    print(conservation_id);
  }
}