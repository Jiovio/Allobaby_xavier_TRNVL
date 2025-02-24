
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:allobaby/API/Requests/BabyCryAPI.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Config/OurFirebase.dart';
import 'package:allobaby/Screens/Main/BottomSheet/Baby.dart';
import 'package:allobaby/Screens/Main/BottomSheet/Baby/BabycryFailed.dart';
import 'package:allobaby/Screens/Main/BottomSheet/widgets/Loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Babycrycontroller extends GetxController {

   dynamic data;

  String reason = "" ;

  String recommendations = "";

 List<Widget> t = [];

 List<dynamic> stepsToComfortTheBaby = [];

 File? audio;

 final validBabyStrings = ["Hungry Cry","Sleepy Cry","Pain Cry","Discomfort Cry",
"Colic Cry","Attention Cry"];


Future<void> babydetect(audioFile) async {

  String prompt = """
The input is an audio .. tell me do you hear a baby cry.
if you hear a baby cry , predict why the baby is crying and how to comfort the baby
arrange the reasons based on the most likely reason for baby cry.
if it is a empty audio return babyCryDetected as false
respond in schema of 
{
babyCryDetected:bool,
reason:any one of ${validBabyStrings.toString()},
stepsToComfortTheBaby : [string]
}
""";


  // Get.to(()=>Baby());

  // audio = audioFile;

  // return;


Get.to(()=>Loading());


var res = await OurFirebase.audioAI(audioFile, prompt);

print(res);



data = json.decode(res);

if(data["babyCryDetected"]==true){

  print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");

  // reason = data["reasons"][random];
  reason = data["reason"];


  print(reason);
  recommendations = json.encode(data["stepsToComfortTheBaby"]);

    stepsToComfortTheBaby = data["stepsToComfortTheBaby"];

  print("*******************************************************");

  print(stepsToComfortTheBaby);

  Get.to(()=>Baby());

  audio = audioFile;

 String url = await OurFirebase.uploadAudioToStorage("audio",audioFile);

//  final req = await Babycryapi.addBabyCry(reason, url);


}else {
  Get.back();
  Get.off(()=> const Babycryfailed());

}
}


}