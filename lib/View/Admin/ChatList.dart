// ignore_for_file: prefer_const_constructors, unused_import, file_names

import 'package:ecom_app/Controller/userController/AdminChatController.dart';
import 'package:ecom_app/View/Admin/AdminMessege.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatsScreenAdmin extends StatefulWidget {
  const ChatsScreenAdmin({super.key});

  @override
  State<ChatsScreenAdmin> createState() => _ChatsScreenAdminState();
}

class _ChatsScreenAdminState extends State<ChatsScreenAdmin> {
  var chatcontroller = Get.put(AdminControllerChat());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatcontroller.getAllChatsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background for modern look
      appBar: AppBar(
        centerTitle: false,
        elevation: 3,
        backgroundColor: const Color(0xFF00BF6D),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text("Chats", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Obx(() {
            return Expanded(
              child: ListView.builder(
                itemCount: chatcontroller.UserChatList.length,
                itemBuilder: (context, index) {
                  var documentSnapshot = chatcontroller.UserChatList[index];
                  var chatData = documentSnapshot.data() as Map<String, dynamic>; // ✅ FIXED!

                  // ✅ Safe handling of missing fields
                  String senderName = chatData["SenderName"] ?? "Unknown User";
                  String senderProfile = chatData["SenderProfile"] ??
                      "https://i.postimg.cc/g25VYN7X/user-1.png"; // Default profile
                  String senderId = chatData["SenderId"] ?? "";

                  return GestureDetector(
                    onTap: () async {
                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                      var myId = prefs.getString("uid");
                      await chatcontroller.createConservation(senderId);

                      Get.to(MessageScreenAdmin(
                        RecieverId: senderId,
                        senderId: myId,
                      ));
                    },
                    child: ChatCard(
                      senderName: senderName,
                      senderProfile: senderProfile,
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

// 🎨 Modern Chat Card UI
class ChatCard extends StatelessWidget {
  final String senderName;
  final String senderProfile;

  const ChatCard({super.key, required this.senderName, required this.senderProfile});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(senderProfile),
        ),
        title: Text(
          senderName,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "Tap to chat",
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey[600]),
      ),
    );
  }
}
