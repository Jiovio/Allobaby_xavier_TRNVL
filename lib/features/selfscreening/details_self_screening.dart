

import 'package:allobaby/Screens/Home/Screening/Controllers/SelfScreeningController.dart';
import 'package:allobaby/Screens/Home/Screening/SymptomsScreen.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/Vitals.dart';
import 'package:allobaby/Screens/Home/Screening/labReports/Tests/FetalMonitoring.dart';
import 'package:allobaby/Screens/Home/Screening/labReports/Tests/Glucose.dart';
import 'package:allobaby/Screens/Home/Screening/labReports/Tests/Hemoglobin.dart';
import 'package:allobaby/Screens/Home/Screening/labReports/Tests/UltraSound.dart';
import 'package:allobaby/Screens/Home/Screening/labReports/Tests/Urine.dart';
import 'package:allobaby/features/selfscreening/model/self_screening_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelfScreeningDetails extends StatefulWidget {
  final SelfScreeningModel data;
  const SelfScreeningDetails({super.key, required this.data});

  @override
  State<SelfScreeningDetails> createState() => _SelfScreeningDetailsState();
}

class _SelfScreeningDetailsState extends State<SelfScreeningDetails> {


Selfscreeningcontroller sc = Get.put(Selfscreeningcontroller());


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Self Screening Detail")),

      body: SingleChildScrollView(
        child: Column(children: [


            ListTile(
              onTap: () => Get.to(()=> Scaffold(
                appBar: AppBar(),
                body: SymptomsScreen(),)),
            leading: Image.asset("assets/labReports/symptoms.png", width: 35,),
            title: const Text("Symptoms"),
            subtitle: const Text("20-02-2025"),
            trailing: Icon(sc.symptomId == null ? Icons.cancel : Icons.check),
          ),



          ListTile(
            leading: Image.asset("assets/labReports/vitals.png", width: 35,),
            title: const Text("Vital Test"),
            subtitle: const Text("20-02-2025"),
            trailing: Icon(sc.vitalsId == null ? Icons.cancel : Icons.check),
            onTap: () => Get.to(()=> VitalsScreen()),

          ),

          ListTile(
            leading: Image.asset("assets/labReports/hemoglobin.png", width: 35,),
            title: const Text("Hemoglobin Test"),
            subtitle: const Text("20-02-2025"),
            trailing: Icon(sc.hemoglobinId == null ? Icons.cancel : Icons.check),
            onTap: () => Get.to(()=>Hemoglobin()),

          ),

          ListTile(
            leading: Image.asset("assets/labReports/urinetest.png", width: 35,),
            title: const Text("Urine Test"),
            subtitle: const Text("20-02-2025"),
            trailing: Icon(sc.urineTestId == null ? Icons.cancel : Icons.check),
            
            onTap: () => Get.to(()=>Urine()),


          ),

          ListTile(
            leading: Image.asset("assets/labReports/glucose.png", width: 35,),
            title: const Text("Glucose Test"),
            subtitle: const Text("20-02-2025"),
            trailing: Icon(sc.glucoseTestId == null ? Icons.cancel : Icons.check),

onTap: () => Get.to(()=> Glucose()),
          ),

          ListTile(
            leading: Image.asset("assets/labReports/fetalmon.png", width: 35,),
            title: const Text("Fetal Monitoring"),
            subtitle: const Text("20-02-2025"),
            trailing: Icon(sc.fetalmonitoringId == null ? Icons.cancel : Icons.check),
onTap: () => Get.to(()=> Fetalmonitoring()),


          ),

          ListTile(
            leading: Image.asset("assets/labReports/ultrasound.png", width: 35,),
            title: const Text("Ultrasound Test"),
            subtitle: const Text("20-02-2025"),
            trailing: Icon(sc.ultrasoundId == null ? Icons.cancel : Icons.check),
            
            onTap: () => Get.to(()=> Ultrasound()),

          ),

     

        ],),
      )
    );
  }
}

class LabreportOptions {

  LabreportOptions(this.x, this.screen,this.img);
  String x; 
  Widget screen;
  String img;

}