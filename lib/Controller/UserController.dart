
import 'package:allobaby/intl/TranslationService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';

class Usercontroller extends GetxController{


  @override
  void onInit() {
    super.onInit();
      final loc = localStorage.getItem("lang");
  if(loc!=null){
    locale = loc;
  }
    
  }

  String locale = "English";

   TextEditingController  name = TextEditingController();

String gender = "Male";
   TextEditingController  age = TextEditingController();

String yearOfExperience = "";
TextEditingController title  = TextEditingController();
TextEditingController address = TextEditingController();
TextEditingController pincode = TextEditingController();




}