  // ignore_for_file: non_constant_identifier_names

  import 'package:flutter/material.dart';
import 'package:get/get.dart';

void ErrorMessege(err,messege) {
   Get.snackbar(err, messege,snackPosition: SnackPosition.BOTTOM,
  backgroundColor: Colors.white60,
  borderRadius: 30,
  borderColor:err=="error"?Colors.black: Colors.green,
  borderWidth: 2,
  );

  }