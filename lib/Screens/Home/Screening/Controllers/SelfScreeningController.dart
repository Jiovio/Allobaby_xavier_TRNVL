import 'dart:convert';

import 'package:allobaby/API/Requests/SelfScreeningAPI.dart';
import 'package:allobaby/API/Requests/Userapi.dart';
import 'package:allobaby/API/local/Storage.dart';
import 'package:allobaby/Components/snackbar.dart';
import 'package:allobaby/db/dbHelper.dart';
import 'package:allobaby/features/selfscreening/model/self_screening_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Selfscreeningcontroller extends GetxController {

  int? appointmentid;

  int? screeningId;

  bool symptomsUploaded = false;
  bool vitalsUploaded = false;



  int? hemoglobinId;

  int? urineTestId;
  int? glucoseTestId;
  int? fetalmonitoringId;
  int? ultrasoundId;


  void reset() {

  bool symptomsUploaded = false;
  bool vitalsUploaded = false;

  screeningId = null;

  symptomsUploaded = false;
  vitalsUploaded = false;
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


  void setSelfScreeningData(SelfScreeningModel item){


    print(item.params.containsKey("symptoms"));
    symptomsUploaded = (item.params.containsKey("symptoms"));
    vitalsUploaded = (item.params.containsKey("vitals"));

    screeningId = item.id;
    hemoglobinId = item.hemoglobinId;
    urineTestId = item.urineTestId;
    glucoseTestId = item.glucoseId;
    fetalmonitoringId = item.fetalTestId;
    ultrasoundId = item.ultrasoundId;

    if(item.params.containsKey("symptoms")){

            symptomsMap= {
          'Normal' : false,
          'Body pain' : false,
          'Burning Stomach' : false,
          'Cold cough' : false,
          'Dizziness' : false,
          'Headache' : false,
          'Vomiting' : false,
          'Other' : false
    };

      item.params["symptoms"].forEach((v){
        symptomsMap[v] = true;
      });

    }else{
      symptomsMap= {
          'Normal' : true,
          'Body pain' : false,
          'Burning Stomach' : false,
          'Cold cough' : false,
          'Dizziness' : false,
          'Headache' : false,
          'Vomiting' : false,
          'Other' : false
    };
    }

        if(item.params.containsKey("vitals")){

          vitalsData = item.params["vitals"];

          healthData = {...healthData, ...vitalsData};

    }else{
      vitalsData = {};
    }

      update();
    
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
    'hB': 12.0,
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


  List<String> getSelectedSymptoms(){

       List<String> details = [];

    symptomsMap.forEach((k,v){
      if(v){
        details.add(k);
      }
    });

    return details;
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
        "appointmentID": appointmentid,
      "params":{
        "symptoms" : details
      },
    });


    if(req.success){

      screeningId = req.id;

      symptomsUploaded = true;

      update();

    }

    // if(req==false){
    //   showToast("Failed to Add Symptoms", false);
    //   return;
    // }
    
    // if(req.success){
    //   screeningId = req.id;
    // }

    // symptomId = 0;
      showToast("Added Symptoms Successfully", true);

    



  }


    void submitVitals () async {

      Map<String,dynamic> data = {
      "details":vitalsData,
      "description":symptomDesc.text
    };

    print(data);

    await Userapi.addScreeningData(null,vitalsData,null);



          final req = await SelfscreeningApi.create({
        "id" : screeningId,
        "appointmentID": appointmentid,
        "params":{
          "vitals" : vitalsData
        },
    });


    if(req.success){

      screeningId = req.id;

      vitalsUploaded = true;

      update();

    }

  }


}