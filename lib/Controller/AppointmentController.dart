
  import 'dart:convert';

import 'package:allobaby/API/Requests/HospitalAPI.dart';
import 'package:allobaby/API/local/Storage.dart';
import 'package:allobaby/Controller/MainController.dart';
import 'package:allobaby/Screens/Service/MyAppointment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:intl/intl.dart';

class AppointmentController extends GetxController {

  TextEditingController symptoms = TextEditingController();
  // 

      Hospital? hospital;
  Hospital? doctor;


  


  List<Hospital> hospitals = [];


 List<Hospital> doctors = [];

 DateTime? selDate;

 List<TimeSlot> timeslots = [];

 int? timeslotInd;


TextEditingController dateController = TextEditingController();


TextEditingController descController = TextEditingController();



final formKey = GlobalKey<FormState>();



  @override
  void onInit() {
    super.onInit();


    dynamic h = localStorage.getItem("defaultHospital");

    print(h);

    if(h!=null){

      h = json.decode(h);
      hospital = Hospital(id: h["id"], name: h["name"]);
    }

    fetchHospitals();
  }

  void fetchHospitals() async {

    List<dynamic> data = await Hospitalapi.getHospitalList();

    List<Hospital> l = [];

    data.forEach((v)=>{
      l.add(Hospital(id: v["id"], name: v["name"]))
    });

      hospitals = [...l];


      update();
 


    if(hospital!=null) fetchDoctors();

  }

  void fetchDoctors()async{
List<dynamic> data = await Hospitalapi.getDoctors(hospital!.id);

    List<Hospital> l = [];

    data.forEach((v)=>{
      l.add(Hospital(id: v["id"], name: v["name"]))
    });

      doctors = [...l];

      update();


  }



  void fetchTimeSlots(date) async {

    if(doctor!=null){
    List<dynamic> d = await Hospitalapi.getDoctorAppointmentsbyDate(doctor?.id, date);

    List<TimeSlot> l = [];

    d.forEach((element) {
      l.add(
        TimeSlot(id: element["id"], start: element["available_from"].substring(0,5), end: element["available_to"].substring(0,5))
      );
    },);

    timeslots = [...l];


  update();



  }
  }


  void addAppointment() async {

    final id = Storage.getUserID();

    final mainc = Get.put(Maincontroller());

    final symptoms = mainc.bottomSheetData["symptoms"];

    print(symptoms);
  

    var data = {
    "doctor_id": doctor!.id ,
    "patient_id":  id,
    "appointment_date": selDate!.toIso8601String(),
    "start_time": timeslots[timeslotInd as int ].start,
    "end_time": timeslots[timeslotInd as int ].end,
    "reason" : descController.text,
    "symptoms":symptoms
    };


    print(data);
    
    try {

          final dreq = await Hospitalapi.createAppointment(data);

        Get.to(MyAppointment());
      
    } catch (e) {

      Get.snackbar("Failed to add Appointment", "Network Error", snackPosition: SnackPosition.BOTTOM);
      
    }




  }


}


    class Hospital {
    int id;
    String name;

    Hospital( {required this.id, required this.name});
  }

  class TimeSlot {
    int id;
    String start;
    String end;

    bool selected = false;

    TimeSlot({required this.id, required this.start, required this.end});


  }