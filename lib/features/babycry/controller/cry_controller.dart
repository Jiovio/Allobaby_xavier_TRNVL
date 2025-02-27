
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:allobaby/API/Requests/BabyCryAPI.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Config/OurFirebase.dart';
import 'package:allobaby/Screens/Main/BottomSheet/Baby.dart';
import 'package:allobaby/Screens/Main/BottomSheet/Baby/BabycryFailed.dart';
import 'package:allobaby/Screens/Main/BottomSheet/widgets/Loading.dart';
import 'package:allobaby/features/babycry/data/crydata.dart';
import 'package:allobaby/features/babycry/prediction/baby_prediction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CryController extends GetxController {

   dynamic data;

  String reason = "" ;

  String recommendations = "";

 List<Widget> t = [];

 List<dynamic> stepsToComfortTheBaby = [];

 File? audio;

 int? cryid;


 void uploadDatatoServer(File audioFile, bool detected, String reasonCry) async {

  String url = await OurFirebase.uploadAudioToStorage("audio",audioFile);



 final req = await Babycryapi.addBabyCry(reasonCry, url, detected);

 if(req==false){
  return;
 }

  cryid = req["id"];

 }


 Future<bool> saveAudio () async {


  return true;

 }

 

 void detect(String pred, String audioPath) {

  Get.to(()=>const Loading());


  Map<String,dynamic> data = Data().crydata[pred];


  Timer.periodic(Duration(seconds: 3), (t){
    t.cancel();

      Get.to(()=>
    BabyPrediction(data: data, audioPath: audioPath, pred : pred)
  );

  });





 }


// Future<void> babydetect(audioFile) async {

//   String prompt = """
// The input is an audio .. tell me do you hear a baby cry.
// if you hear a baby cry , predict why the baby is crying and how to comfort the baby
// arrange the reasons based on the most likely reason for baby cry.
// if it is a empty audio return babyCryDetected as false
// respond in schema of 
// {
// babyCryDetected:bool,
// reasons:[string],
// stepsToComfortTheBaby : [string]
// }
// """;


//   // Get.to(()=>Baby());

//   // audio = audioFile;

//   // return;


// Get.to(()=>const Loading());


// var res = await OurFirebase.audioAI(audioFile, prompt);

// print(res);

// data = json.decode(res);

// if(data["babyCryDetected"]==true){

//   final _random = new Random();
//   int next(int min, int max) => min + _random.nextInt(max - min);

//   int random = next(0, data["reasons"].length-1);

//   print(random);

//   print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");

//   reason = data["reasons"][random];

//   print(reason);
//   recommendations = json.encode(data["stepsToComfortTheBaby"]);

//     stepsToComfortTheBaby = data["stepsToComfortTheBaby"];

//   print("*******************************************************");

//   print(stepsToComfortTheBaby);

//   audio = audioFile;

//   update();

//   Get.to(()=>Baby());

//   OurFirebase.uploadAudioToStorage("audio",audioFile);


// }else {
//   Get.back();
//   Get.to(()=> const Babycryfailed());

// }
// }


}