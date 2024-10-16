import 'package:allobaby/API/Requests/HospitalAPI.dart';
import 'package:allobaby/API/local/Storage.dart';
import 'package:allobaby/Screens/Chat/Chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Chatcontroller extends GetxController {

  List<dynamic> messages = [];


    checkHospAndSend(String type) async {
    final hosp = Storage.getDefaultHospital();
    if(hosp==null){
      Get.snackbar("Please Choose your Desired Hospital !", 
      "You have'nt chosen your Hospital Yet");
    }else{
      final defaulthosp = await Hospitalapi.getDefaultChatAgent(hosp);
      switch (type) {
        case "doctor":
        String uid = Storage.getUserID().toString();
        String docid = defaulthosp["doctorid"].toString();
        String id = "P$uid-D$docid";
        String docName = defaulthosp["doctor"]["name"].toString();
        Get.to(Chat(title: docName, chatId: id, p2: "D$docid",p1:"P$uid"));
        print(id);
          break;
        default:
      }

      print(defaulthosp);

      // Get.to(to,transition: Transition.rightToLeft);

    }
  }

}