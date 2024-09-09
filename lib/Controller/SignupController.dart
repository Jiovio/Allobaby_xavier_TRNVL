
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Signupcontroller extends GetxController{


  Map<String,dynamic> data = {
    "parentType":"Dad",
    "pregnancyStatus":"",
    "avgLengthOfCycles":28
  };

  String phone = "1234567890";

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

  TextEditingController lmpDate = TextEditingController();

  TextEditingController eddate = TextEditingController();
  TextEditingController averageCycleLength = TextEditingController();
  TextEditingController dateofdelivery = TextEditingController();

  TextEditingController doorNo = TextEditingController();
  TextEditingController streetName = TextEditingController();
  TextEditingController pincode = TextEditingController();

  bool pincodeSearching = false;




  List<String> areas = [];

  String selectedArea = "";

  TextEditingController name = TextEditingController();
  TextEditingController emailID = TextEditingController();
  String gender = "";
  TextEditingController age = TextEditingController();
  String bloodGroup = "";


 Future searchPincode() async {

  selectedArea="";
  areas=[];

  pincodeSearching= true;

  update();

  Uri url = Uri.parse("https://api.postalpincode.in/pincode/${pincode.text}");

  final req = await http.get(url);


  if(jsonDecode(req.body)[0]["Status"]=="Error"){

    print(jsonDecode(req.body));


    pincodeSearching=false;
    Get.snackbar("Invalid Pincode","Please Enter Valid PinCode",snackPosition: SnackPosition.BOTTOM);
    update(); 
    return;

  }


  if(req.statusCode==200){


    jsonDecode(req.body)[0]["PostOffice"].forEach((val)=>{
      areas.add(val["Name"])
    });

    selectedArea = areas[0];
    

    pincodeSearching=false;

    update();


  }else{


  }

  }




}