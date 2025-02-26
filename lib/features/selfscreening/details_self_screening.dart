import 'package:allobaby/API/authAPI.dart';
import 'package:allobaby/Screens/Home/Screening/Controllers/SelfScreeningController.dart';
import 'package:allobaby/Screens/Home/Screening/SymptomsScreen.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/Vitals.dart';
import 'package:allobaby/Screens/Home/Screening/labReports/Tests/FetalMonitoring.dart';
import 'package:allobaby/Screens/Home/Screening/labReports/Tests/Glucose.dart';
import 'package:allobaby/Screens/Home/Screening/labReports/Tests/Hemoglobin.dart';
import 'package:allobaby/Screens/Home/Screening/labReports/Tests/UltraSound.dart';
import 'package:allobaby/Screens/Home/Screening/labReports/Tests/Urine.dart';
import 'package:allobaby/features/selfscreening/model/self_screening_model.dart';
import 'package:allobaby/features/selfscreening/screening_report_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelfScreeningDetails extends StatefulWidget {
   SelfScreeningModel data;
   SelfScreeningDetails({super.key, required this.data});

  @override
  State<SelfScreeningDetails> createState() => _SelfScreeningDetailsState();
}

class _SelfScreeningDetailsState extends State<SelfScreeningDetails> {
  Selfscreeningcontroller sc = Get.put(Selfscreeningcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Self Screening Detail",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 16),
              // Header Section with Summary
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(0.2), 
                  ),
                  
                ),
                
                child: Row(
                  children: [
                    Icon(
                      Icons.medical_services_rounded,
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Medical Screenings',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Track your pregnancy health tests',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
          
              ...buildScreeningTiles(),
            ],
          ),
        ),
      ),
    );
  }

  // List<Widget> buildScreeningTiles() {
  //   return [
  //     buildScreeningTile(
  //       "Symptoms",
  //       "assets/labReports/symptoms.png",
  //       () => Get.to(() => Scaffold(
  //         appBar: AppBar(),
  //         body: SymptomsScreen(),
  //       )),
  //       sc.symptomsUploaded,
  //     ),
  //     buildScreeningTile(
  //       "Vital Test",
  //       "assets/labReports/vitals.png",
  //       () => Get.to(() => 
  //       Scaffold(appBar: AppBar(), body: VitalsScreen())),
  //       sc.vitalsUploaded,
  //     ),
  //     buildScreeningTile(
  //       "Hemoglobin Test",
  //       "assets/labReports/hemoglobin.png",
  //       () => Get.to(() => Scaffold(appBar: AppBar(), body: Hemoglobin())),
  //       sc.hemoglobinId != null,
  //     ),
  //     buildScreeningTile(
  //       "Urine Test",
  //       "assets/labReports/urinetest.png",
  //       () => Get.to(() => Scaffold(appBar: AppBar(), body: Urine())),
  //       sc.urineTestId != null,
  //     ),
  //     buildScreeningTile(
  //       "Glucose Test",
  //       "assets/labReports/glucose.png",
  //       () => Get.to(() =>Scaffold(appBar: AppBar(), body:  Glucose())),
  //       sc.glucoseTestId != null,
  //     ),
  //     buildScreeningTile(
  //       "Fetal Monitoring",
  //       "assets/labReports/fetalmon.png",
  //       () => Get.to(() => Scaffold(appBar: AppBar(), body: Fetalmonitoring())),
  //       sc.fetalmonitoringId != null,
  //     ),
  //     buildScreeningTile(
  //       "Ultrasound Test",
  //       "assets/labReports/ultrasound.png",
  //       () => Get.to(() => Scaffold(appBar: AppBar(), body: Ultrasound())),
  //       sc.ultrasoundId != null,
  //     ),
  //   ];
  // }


  


    List<Widget> buildScreeningTiles() {
    return [
              GetBuilder<Selfscreeningcontroller>(
        builder: (controller) {
      return buildScreeningTile(
        "Symptoms",
        "assets/labReports/symptoms.png",
        () async 
        {
        await Get.to(() => Scaffold(
          appBar: AppBar(),
          body: SymptomsScreen(),
        )
        );

              if(controller.symptomsUploaded){

          widget.data.params = {...widget.data.params , "symptoms" : controller.getSelectedSymptoms()};

          controller.update();
        }
        
        
        },
        controller.symptomsUploaded,
      );}),
            GetBuilder<Selfscreeningcontroller>(
        builder: (controller) {
      return buildScreeningTile(
        "Vital Test",
        "assets/labReports/vitals.png",
        () async 
        {     
       await  Get.to(() => 
        Scaffold(appBar: AppBar(), body: VitalsScreen())
        );

        if(controller.vitalsUploaded){

          widget.data.params = {...widget.data.params , "vitals" : controller.vitalsData};

          controller.update();
        }
},


        controller.vitalsUploaded,
      );}),


      GetBuilder<Selfscreeningcontroller>(
        builder: (controller) {
          return buildScreeningTile(
            "Hemoglobin Test",
            "assets/labReports/hemoglobin.png",
            () {
              controller.hemoglobinId !=null ?
              Get.to(()=> ScreeningReportLoader(id: sc.hemoglobinId!)):
              Get.to(() => Scaffold(appBar: AppBar(), body: Hemoglobin())) ;
              
          
            },
            sc.hemoglobinId != null,
          );
        }
      ),
      GetBuilder<Selfscreeningcontroller>(
        builder: (controller) {
      return buildScreeningTile(
        "Urine Test",
        "assets/labReports/urinetest.png",
        () {

          controller.urineTestId !=null ?
          Get.to(()=> ScreeningReportLoader(id: controller.urineTestId!)):          
          Get.to(() => Scaffold(appBar: AppBar(), body: Urine()));
          },
        controller.urineTestId != null,
      );}),

      GetBuilder<Selfscreeningcontroller>(
        builder: (controller) {
        return buildScreeningTile(
        "Glucose Test",
        "assets/labReports/glucose.png",
        () { 
                 controller.glucoseTestId !=null ?
          Get.to(()=> ScreeningReportLoader(id: controller.glucoseTestId!)):    
          
          Get.to(() =>Scaffold(appBar: AppBar(), body:  Glucose()));},
        controller.glucoseTestId != null,
      );}),

      GetBuilder<Selfscreeningcontroller>(
        builder: (controller) {
      return buildScreeningTile(
        "Fetal Monitoring",
        "assets/labReports/fetalmon.png",
        () { 
          controller.fetalmonitoringId !=null ?
          Get.to(()=> ScreeningReportLoader(id: controller.fetalmonitoringId!)):   
          
          Get.to(() => Scaffold(appBar: AppBar(), body: Fetalmonitoring()));},
        controller.fetalmonitoringId != null,
      );}),

      GetBuilder<Selfscreeningcontroller>(
        builder: (controller) {
      return buildScreeningTile(
        "Ultrasound Test",
        "assets/labReports/ultrasound.png",
        () { 
                    controller.ultrasoundId !=null ?
          Get.to(()=> ScreeningReportLoader(id: controller.ultrasoundId!)):   
          Get.to(() => Scaffold(appBar: AppBar(), body: Ultrasound()));},
        controller.ultrasoundId != null,
      );})
    ];
  }

  Widget buildScreeningTile(String title, String imagePath, VoidCallback onTap, bool isCompleted) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.asset(
            imagePath,
            width: 30,
            height: 30,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
   
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isCompleted ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                isCompleted ? "Completed" : "Pending",
                style: TextStyle(
                  color: isCompleted ? Colors.green : Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        trailing: Icon(
          isCompleted ? Icons.check_circle : Icons.arrow_forward_ios,
          color: isCompleted ? Colors.green : Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

wrapWithScaffold(widget){
  return Scaffold(
    appBar: AppBar(),
    body: widget,
  );
}

class LabreportOptions {
  LabreportOptions(this.x, this.screen, this.img);
  String x;
  Widget screen;
  String img;
}