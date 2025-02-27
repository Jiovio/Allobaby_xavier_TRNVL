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

    if(input.text=="" || input.text.isEmpty){
        return;
    }

    String prompt = "you are a medical maternal AI named allobot. only answer to health related prompts , you can give advise .. respond in md . prompt = ${input.text}";
        convs.add({"user":true,"msg":input.text});


       if(init){
//         Get.bottomSheet(
// Allobot()
//         );
   Get.to(()=>Allobot());

       }
       aithinking=true;
        input.text = "";
    update();
   var d =  await ai.generateContent([Content.text(prompt)]);
   convs.add({"user":false,"msg":d.text});
update();
   
   aithinking=false;

  }
}