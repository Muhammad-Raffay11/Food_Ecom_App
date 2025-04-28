// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:ecom_app/Helper/TestUserDashboard/TestUserWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestUser extends StatefulWidget {
  const TestUser({super.key});

  @override
  State<TestUser> createState() => _TestUserState();
}

class _TestUserState extends State<TestUser> {

 @override
  void initState() {
   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor:
         const Color.fromARGB(255, 14, 14, 14),
        body: SafeArea(child: Padding(padding: EdgeInsets.only(top: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){},
                child: Icon(Icons.sort_rounded,
                color: Colors.white,
                size: 30,),
              ),
                InkWell(
                onTap: (){},
                child: Icon(Icons.search_sharp,
                color: Colors.white,
                size: 30,),
              )
            ],
          ),
          ),
      
          SizedBox(height: 30),
          Padding(padding:
           EdgeInsetsDirectional.symmetric(horizontal: 15),
           child: Text('Hot & FastFood',style: TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.bold
           ),),
           ),
           
           SizedBox(height: 3),
      
          Padding(padding:
           EdgeInsetsDirectional.symmetric(horizontal: 15),
           child: Text('Deliver on Time',style: TextStyle(
            fontSize: 18,
            color: Colors.white,
           ),),
           ),
      
           SizedBox(height: 15,),

           TabBar(
            isScrollable: true,
            // indicator: BoxDecoration(),
            labelStyle: TextStyle(fontSize: 20),
            labelPadding: EdgeInsets.symmetric(horizontal:20),
            tabs: [
              Tab(text: 'Burger'),
              Tab(text: 'Pizza'),
              Tab(text: 'Rolls'),
              Tab(text: 'Sandwich'),
            ],
           ),

           Flexible(
            flex: 1,
            child: TabBarView(children:[
            TestWidget(),
            TestWidget(),
            TestWidget(),
            TestWidget(),
           ]),
           ),
      
      
        ],
        ),
        ),
        ),
      ),
    );
  }
}