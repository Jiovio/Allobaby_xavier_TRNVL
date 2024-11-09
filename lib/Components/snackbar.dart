import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showToast(String title,String desc){
    Get.snackbar(title,
      desc,
      snackPosition: SnackPosition.BOTTOM,
      icon: Icon(Icons.error),
      );
}