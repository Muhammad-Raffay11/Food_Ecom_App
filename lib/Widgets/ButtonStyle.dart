// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class ButtonStyleWidget extends StatelessWidget {


  var buttonLabel;
  final void Function() onPress;

   ButtonStyleWidget({super.key,this.buttonLabel,required this.onPress});

  @override
  Widget build(BuildContext context) {
    return     Container(
            width: MediaQuery.of(context).size.width*0.8,
            child:
             ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                elevation: 20,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),
                side: BorderSide(color: Colors.blue,width: 3),
                
                ),
              ),
              label: Text(buttonLabel),
              icon: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.account_box)),
              onPressed: (){
                onPress();
              },
               ),
           )
          ;
  }
}











class ButtonStyleWidget2 extends StatelessWidget {


  var buttonLabel;
  var width;

  final void Function() onPress;

   ButtonStyleWidget2({super.key,this.buttonLabel,required this.onPress,this.width, required TextStyle textStyle});

  @override
  Widget build(BuildContext context) {
    return     Container(
            width:width,
            child:
             ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 20,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),
                side: BorderSide(color: Colors.white,width: 3),
                
                ),
              ),
              child: Text(buttonLabel),
            
              onPressed: (){
                onPress();
              },
               ),
           )
          ;
  }
}
