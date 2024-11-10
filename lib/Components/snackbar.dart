import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showToast(String desc,bool success){
    Get.snackbar(!success?"Failed !": "Success !",
      desc,
      snackPosition: SnackPosition.BOTTOM,
      icon:!success? Icon(Icons.error) : Icon(Icons.check),
      );
}