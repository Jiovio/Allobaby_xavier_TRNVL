import 'package:allobaby/Config/Color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showToast(String desc,bool success){
    Get.snackbar(!success?"Failed !": "Success !",
      desc,
      snackPosition: SnackPosition.BOTTOM,
      icon:!success? const Icon(Icons.error,color: White,) : const Icon(Icons.check, color: White,),
      backgroundColor: success?Colors.green:Colors.red,
      colorText: White,
      
      );
}