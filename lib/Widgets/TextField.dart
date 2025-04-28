// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, must_be_immutable, prefer_if_null_operators

import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  var width;
  var placeholder;
  var hintText;
   var passwordField;
   var suffixIcon;
  TextEditingController controller;
    final void Function() ?onPress;
    var show;

 TextFieldWidget({super.key,required this.controller,this.hintText,this.placeholder,this.width,
 this.passwordField,this.onPress,this.show,this.suffixIcon, required String hintTextdaat
 });

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
                margin: EdgeInsets.all(8.0),
                width: width,
                child: TextField(
                  obscureText:passwordField==true?show:false ,
                  controller: controller,
                  decoration: InputDecoration(
                    suffixIcon:
                    suffixIcon != null &&
                    passwordField == true? 
                    GestureDetector(
                      onTap: (){
                        onPress!();
                      },
                      child:suffixIcon) :suffixIcon == null?null:suffixIcon,
                    hintText: hintText,
                    helperText: placeholder,
                    border:OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.green
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
               
                    focusedBorder:OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Color.fromARGB(255, 3, 99, 35),
                      ),
                      borderRadius: BorderRadius.circular(5)
                    ),
               
                  ),
                ),
                ),
    );
  }
  }
