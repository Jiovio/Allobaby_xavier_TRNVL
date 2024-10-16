import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:localstorage/localstorage.dart';

class Storage {


  static getDefaultHospital(){

    final hospital = localStorage.getItem("defaultHospital");

    return hospital;
  }

  static getUserID() {
    final id = localStorage.getItem("user");

    if(id!=null){
      return json.decode(id)["id"];
    }
    return id;
  }

  static checkHospAndSend(Widget to){
    final hosp = getDefaultHospital();
    if(hosp==null){
      Get.snackbar("Please Choose your Desired Hospital !", 
      "You have'nt chosen your Hospital Yet");
    }else{

      Get.to(to,transition: Transition.rightToLeft);

    }
  }

}