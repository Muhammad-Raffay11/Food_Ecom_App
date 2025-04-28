// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {

var text;
var color;
var fontFamily;
var fontSize;
var fontBold;

 TextWidget({super.key,this.text,this.color,this.fontFamily,this.fontSize,this.fontBold=false});

  @override
  Widget build(BuildContext context) {
    return  Text(text,
    style: TextStyle(
              fontSize: fontSize,
              fontFamily: fontFamily,
              color: color, 
            ),
            );
  }
}