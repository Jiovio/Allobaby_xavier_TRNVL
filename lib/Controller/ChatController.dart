import 'dart:convert';

import 'package:allobaby/API/Requests/HospitalAPI.dart';
import 'package:allobaby/API/local/Storage.dart';
import 'package:allobaby/Controller/MainController.dart';
import 'package:allobaby/Screens/Chat/Chat.dart';
import 'package:allobaby/Screens/Chat/chatfunc.dart';
import 'package:allobaby/db/dbHelper.dart';
import 'package:allobaby/utils/backgroundservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';

class Chatcontroller extends GetxController {

  List<dynamic> messages = [];


    checkHospAndSend(String type) async {

    Maincontroller controller = Get.put(Maincontroller());

  //  await Backgroundservice.processDataList();



    final hosp = Storage.getDefaultHospital();

    if(hosp==null){
      Get.snackbar("Please Choose your Desired Hospital !", 
      "You have'nt chosen your Hospital Yet");
    }else{
      var defaulthosp ;

      final local = localStorage.getItem("defaultChat");

      print(local);

      // return;

      if(local!=null){
        defaulthosp = json.decode(local);
      }else{
        defaulthosp = await Hospitalapi.getDefaultChatAgent(hosp);

      }

      print(defaulthosp);

      String uid = Storage.getUserUID().toString();

      print(uid);
      
      switch (type) {
        case "doctor":
        String docid = (defaulthosp["doctor"]["uid"]).toString();
        String id = getChatID(uid, docid);
        String docName = defaulthosp["doctor"]["name"].toString();
        print(id);
        Get.to(Chat(title: docName, chatId: id, p2: docid,p1:uid,
                    p1Name: controller.name.text,p2Name: docName, type: "doctor",));
  
          break;

        case "healthworker":
        String docid = (defaulthosp["healthworker"]["uid"]).toString();
        String id = getChatID(uid, docid);
        String docName = defaulthosp["doctor"]["name"].toString();
        Get.to(Chat(title: docName, chatId: id, p2: docid,p1:uid,
                    p1Name: controller.name.text,p2Name: docName, type: "healthworker"));
          break;




        default:
      }

      print(defaulthosp);

      // Get.to(to,transition: Transition.rightToLeft);

    }
  }

}