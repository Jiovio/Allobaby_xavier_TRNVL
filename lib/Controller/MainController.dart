import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class Maincontroller extends GetxController {

  bool voice = true;

  int currpage = 0;
  void pageChanged(int i){
    currpage=i;
    update();
  }

  // Bottom Sheet


TextEditingController bedtime = TextEditingController();
TextEditingController waketime = TextEditingController();

    Map<String,dynamic> bottomSheetData = {
    "feeling":"",
    "exercises":[],
    "glassOfWater":0,
    "tabletsTaken":[],
    "bedTime": "",
    "wakeUpTime":"",
    "sleepDuration":0,
    "symptoms":[]
  };




  void setBottomSheetData(key,value){
    if(bottomSheetData.containsKey(key)){
      bottomSheetData[key] = value;
      update();
    }
  }
  void setbottomSheetDataArray(key,val){

    List<dynamic> ls = bottomSheetData[key];

    if(!ls.contains(val))
    ls.add(val);
    else
    ls.remove(val);

    bottomSheetData[key] = ls;
    update();
  }

  // Plan Controller
RxInt planType = 0.obs;
RxString plan = "".obs;
int planPrice = 0;



bool rec = false;

void toggleerec () {
  rec= !rec;
  update();
}





}




