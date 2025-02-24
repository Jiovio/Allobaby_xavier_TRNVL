import 'dart:convert';

import 'package:allobaby/API/Requests/SelfScreeningAPI.dart';
import 'package:allobaby/API/Requests/Userapi.dart';
import 'package:allobaby/API/local/Storage.dart';
import 'package:allobaby/Components/snackbar.dart';
import 'package:allobaby/db/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Selfscreeningcontroller extends GetxController {



  int? screeningId;

  int? symptomId;
  int? vitalsId;
  int? hemoglobinId;

  int? urineTestId;
  int? glucoseTestId;
  int? fetalmonitoringId;
  int? ultrasoundId;


  void reset() {

  screeningId = null;

  symptomId = null;
  vitalsId = null;
  hemoglobinId = null;

  urineTestId = null;
  glucoseTestId = null;
  fetalmonitoringId = null;
  ultrasoundId = null;

  }

  @override
  void onInit () async {
    super.onInit();


    var d = await getTodayData("symptoms");

    if(d!=null){
      symptomsMap = json.decode(d["data"]) as Map<String,dynamic>;
    }


    var vitals = await getTodayData("vitals");

    if(vitals!=null){
      healthData = {...healthData,...json.decode(vitals["data"])};
      vitalsData = json.decode(vitals["data"]);

    }

  }


    List symptomsSelected = [];
      List symptomsSelectedItems = [];
    
        Map<String,dynamic> symptomsMap = {
          'Normal' : true,
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


  Map<String, dynamic> vitalsData = {

  };

  void updateVitals(String key, dynamic value){

      vitalsData[key] = value;

    insertOrUpdateDaily(json.encode(vitalsData), "vitals");

    if(healthData.containsKey(key)){
      healthData[key] = value;
      update();
    }
  }


  void submitSymptoms () async {

    var details = [];

    symptomsMap.forEach((k,v){
      if(v){
        details.add(k);
      }
    });

        Map<String,dynamic> data = {
      "details":details,
      "description":symptomDesc.text,
    };

     final addreq =  await Userapi.addScreeningData(null,null,data);


    if(addreq ==false){
      showToast("Failed to Add Symptoms", false);
      return;
    }


      final req = await SelfscreeningApi.create({
        "id" : screeningId,
      "params":{
        "symptoms" : details
      },
      "symptomsId":symptomDesc.text,
    });

    if(req==false){
      showToast("Failed to Add Symptoms", false);
      return;
    }
    
    if(req["created"]){
      screeningId = req["id"];
    }

    symptomId = 0;
      showToast("Added Symptoms Successfully", true);

    



  }


    void submitVitals () async {

      Map<String,dynamic> data = {
      "details":vitalsData,
      "description":symptomDesc.text
    };

    print(data);

    await Userapi.addScreeningData(null,vitalsData,null);

  }


}