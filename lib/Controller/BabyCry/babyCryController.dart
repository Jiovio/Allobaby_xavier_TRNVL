
import 'dart:convert';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Config/OurFirebase.dart';
import 'package:allobaby/Screens/Main/BottomSheet/Baby.dart';
import 'package:allobaby/Screens/Main/BottomSheet/widgets/Loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Babycrycontroller extends GetxController {

   late dynamic data;

 late String reason ;

 late String recommendations;

 List<Widget> t = [];


Future<void> babydetect(audioFile) async {




  String prompt = """
The input is an audio .. tell me do you hear a baby cry.
if you hear a baby cry , predict why the baby is crying and how to comfort the baby

respond in schema of 
{
babyCryDetected:bool,
reasons:[string],
stepsToComfortTheBaby : [string]
}
""";

Get.to(Loading());




var res = await OurFirebase.audioAI(audioFile, prompt);

print(res);

data = json.decode(res);

if(data["babyCryDetected"]){

  reason = data["reasons"][0];
  recommendations = json.encode(data["stepsToComfortTheBaby"]);

  Get.to(Baby());


  

  data["stepsToComfortTheBaby"].forEach((element) {
    t.add(Text(element));
  },);


}
}


}