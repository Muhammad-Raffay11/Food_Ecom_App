// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
    shrinkWrap: true,
    childAspectRatio: 0.72,
    children: [
    for(int i=1;i<5;i++)
    Container(
      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 8,horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(245, 19, 19, 19),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ]
      ),

      child: Column(
        children: [
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, 'ItemPage');
            },
            child: Container(
              margin: EdgeInsets.all(5),
              child: Image.asset('images/assets/beef burger without background.png',
              width: 120,
              height: 120,
              fit: BoxFit.cover,),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 3),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text('Beef Burger',style: 
            TextStyle(fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white),
            ),
          ),
          ),

          Container(
            alignment: Alignment.centerLeft,
            child: Text('Hot Burger',style: 
            TextStyle(fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.white),
            ),
          ),

          Padding(padding: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text('Rs:350',style: 
            TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),),

            Icon(Icons.shopping_cart,
            size: 26,
            color: Colors.white,),

          ],
          ),
          ),


        ],
      ),

    ),
    ],
    );
  }
}