import 'dart:convert';

import 'package:allobaby/API/local/Storage.dart';
import 'package:allobaby/db/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Selfscreeningcontroller extends GetxController {


  @override
  void onInit () async {
    super.onInit();


    var d = await getTodayData("symptoms");

    if(d!=null){
      symptomsMap = json.decode(d["data"]) as Map<String,dynamic>;
    }


    var vitals = await getTodayData("vitals");

    if(vitals!=null){
      healthData = json.decode(vitals["data"]);
    }

  }


    List symptomsSelected = [];
      List symptomsSelectedItems = [];
    
        Map<String,dynamic> symptomsMap = {
          'Normal' : false,
          'Body pain' : false,
          'Burning Stomach' : false,
          'Cold cough' : false,
          'Dizziness' : false,
          'Headache' : false,
          'Vomiting' : false,
          'Other' : false
    };

    TextEditingController symptomDesc = TextEditingController();

 void symptomSelect(String symptom) async {

  if(symptom =="Normal"){
    symptomsMap = {
          'Normal' : true,
          'Body pain' : false,
          'Burning Stomach' : false,
          'Cold cough' : false,
          'Dizziness' : false,
          'Headache' : false,
          'Vomiting' : false,
          'Other' : false
    };
  }else{
        if (symptomsMap.containsKey(symptom)) {
      symptomsMap[symptom] = !symptomsMap[symptom]!; 
      symptomsMap["Normal"] = false; 

      // symptomsMap[symptom] = true; 
      // createChatTable();
    }
  }

       await  insertOrUpdateDaily(json.encode(symptomsMap),"symptoms");

      update(); 


  }

  RxBool iBloodGlucoseValue = true.obs;

   Map<String, dynamic> healthData = {
    'bloodPressureH': 120,
    'bloodPressureL': 90,
    'bloodSaturationBW': 99.0,
    'bloodSaturationAW': 99.0,
    'temperature': 30.0,
    'heartRateBW': 72,
    'heartRateAW': 72,
    'bloodGlucoseBF': 150.0,
    'bloodGlucoseAF': 150.0,
    'bmiHeight': 150,
    'bmiWeight': 50.0,
    'respiratoryRate': 18,
    'hrv': 98,
    'hB': 10.0,
    'temperatureMetric':'C'
  }.obs;

  void updateVitals(String key, dynamic value){


    insertOrUpdateDaily(json.encode(healthData), "vitals");

    if(healthData.containsKey(key)){
      healthData[key] = value;
      update();
    }
  }


  void submitSymptoms () async {


    int phone = await Storage.getUserID();



        Map<String,dynamic> data = {
      "reportType":"Symptoms",
      "details":json.encode(symptomsMap),
      "description":symptomDesc.text,
      "phone":phone
    };

  //  int ins = await insertOrUpdateSymptom(json.encode(symptomsMap));

   Get.back();


  }


}