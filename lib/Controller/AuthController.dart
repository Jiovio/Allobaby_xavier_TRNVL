import 'package:allobaby/API/apiroutes.dart';
import 'package:allobaby/Screens/mobileverification/otpverification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Authcontroller extends GetxController {
TextEditingController phone = TextEditingController();
String countryCode = "91";



  onSuccessLogin() {
    print(Apiroutes().getUrl("/login"));
    Get.offAll(()=>Otpverification(),
    transition: Transition.rightToLeft);
  }
}

