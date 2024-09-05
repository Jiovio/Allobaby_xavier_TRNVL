
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signupcontroller extends GetxController{


  Map<String,dynamic> data = {
    "parentType":"Dad",
    "pregnancyStatus":"Iam Trying To Conceive",
    "avgLengthOfCycles":30
  };

  List<String> pregnancyStatusList = ["Iam trying to Conceive","Iam Pregnant","I have a baby"];


  updateData(String key, dynamic value){

    if(data.containsKey(key)){

      data[key] = value;
      update();
    }else{
      print("Key not found");
    }
  }


  TextEditingController partnerName = TextEditingController();
  TextEditingController partnerMobile = TextEditingController();



}