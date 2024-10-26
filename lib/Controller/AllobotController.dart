import 'package:allobaby/Config/OurFirebase.dart';
import 'package:allobaby/Screens/AI/Allobot.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Allobotcontroller extends GetxController {

  var ai = OurFirebase.textai;

  List<Map<String,dynamic>> convs = [];


  TextEditingController input = TextEditingController();

  bool aithinking = false;

  Future<void> converseWithAI([bool init=false]) async {

    String prompt = "you are a medical maternal AI named allobot , you can give advise .. respond in md . prompt = ${input.text}";
        convs.add({"user":true,"msg":input.text});
       if(init){
   Get.to(Allobot());

       }
       aithinking=true;
    update();
   var d =  await ai.generateContent([Content.text(prompt)]);
   convs.add({"user":false,"msg":d.text});

   input.text = "";
   aithinking=false;

   update();
   




  }
}