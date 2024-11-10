
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Config/OurFirebase.dart';
import 'package:allobaby/Screens/Main/BottomSheet/Baby.dart';
import 'package:allobaby/Screens/Main/BottomSheet/Baby/BabycryFailed.dart';
import 'package:allobaby/Screens/Main/BottomSheet/widgets/Loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Babycrycontroller extends GetxController {

   late dynamic data;

 late String reason ;

 late String recommendations;

 List<Widget> t = [];

 List<dynamic> stepsToComfortTheBaby = [];

 File? audio;


Future<void> babydetect(audioFile) async {

  String prompt = """
The input is an audio .. tell me do you hear a baby cry.
if you hear a baby cry , predict why the baby is crying and how to comfort the baby
arrange the reasons based on the most likely reason for baby cry
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

if(data["babyCryDetected"]==true){

  final _random = new Random();
  int next(int min, int max) => min + _random.nextInt(max - min);

  int random = next(0, data["reasons"].length-1);

  print(random);

  print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");

  reason = data["reasons"][random];

  print(reason);
  recommendations = json.encode(data["stepsToComfortTheBaby"]);

    stepsToComfortTheBaby = data["stepsToComfortTheBaby"];

  print("*******************************************************");

  print(stepsToComfortTheBaby);

  Get.to(Baby());

  OurFirebase.uploadAudioToStorage("audio",audioFile);

  audio = audioFile;

}else {

  Get.to(Babycryfailed());

}
}


}