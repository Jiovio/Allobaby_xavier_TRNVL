import 'package:get/get.dart';

class Selfscreeningcontroller extends GetxController {


    List symptomsSelected = [];
      List symptomsSelectedItems = [];
    
        Map<String,bool> symptomsMap = {
          'Normal' : false,
'Body pain' : false,
'Burning Stomach' : false,
'Cold cough' : false,
 'Dizziness' : false,
 'Headache' : false,
 'Vomiting' : false,
 'Other' : false
    }.obs;

 void symptomSelect(String symptom) {
    if (symptomsMap.containsKey(symptom)) {
      symptomsMap[symptom] = !symptomsMap[symptom]!; 
      // symptomsMap[symptom] = true; 

      update(); 
    }
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

    if(healthData.containsKey(key)){
      healthData[key] = value;
      update();
    }
  }



}