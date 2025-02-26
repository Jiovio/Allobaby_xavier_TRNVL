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
import 'package:allobaby/features/selfscreening/report/report_selfscreening.dart';
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

        actions: [
          TextButton.icon(onPressed: (){
                  final d = widget.data.params;

                        Get.to(()=> MedicalReportPage(
                      reportData: d,
                      patientId: "Vijay",
                      doctorDetails: {
                        "name": "Dr. Jane Smith",
                        "specialization": "General Medicine",
                        "license": "MED12345"
                      },

                      date : widget.data.created!
    )
            );

    //         Get.to(()=> const MedicalReportPage(
    //                   reportData: {
    //                     "symptoms": ["Body pain", "Burning Stomach", "Cold cough"],
    //                     "vitals": {
    //                       "bloodPressureH": 121,
    //                       "bloodPressureL": 87,
    //                       "temperature": 34.4,
    //                       "temperatureMetric": "C",
    //                       "bloodSaturationBW": 93.0,
    //                       "bloodSaturationAW": 88.0,
    //                       "heartRateBW": 68,
    //                       "heartRateAW": 81,
    //                       "bmiHeight": 144,
    //                       "bmiWeight": 56.0,
    //                       "respiratoryRate": 26,
    //                       "hB": 11.4,
    //                       "bloodGlucoseBF": 155.4,
    //                       "bloodGlucoseAF": 155.4
    //                     },
    //                     "hemoglobinValue": 14,
    //                     "alphaminePresent": "No",
    //                     "sugarPresent": "Yes",
    //                     "glucose": 72.4,
    //                     "kickCount": 8,
    //                     "heartRate": 67,
    //                     "fetalPresentation": "Cephalic",
    //                     "fetalMovement": "Present",
    //                     "placenta": "Fundal"
    //                   },
    //                   patientId: "PT12345",
    //                   doctorDetails: {
    //                     "name": "Dr. Jane Smith",
    //                     "specialization": "General Medicine",
    //                     "license": "MED12345"
    //                   },
    // )
    //         );

          },
          label: Text("Report"),
          icon: Icon(Icons.share),
          )
        ],
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
            () async {
              controller.hemoglobinId !=null ?
            await Get.to(()=> ScreeningReportLoader(id: sc.hemoglobinId!)):
            await Get.to(() => Scaffold(appBar: AppBar(), body: Hemoglobin())) ;
              

              widget.data.hemoglobinId = controller.hemoglobinId;
          
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
        () async  {

          controller.urineTestId !=null ?
        await Get.to(()=> ScreeningReportLoader(id: controller.urineTestId!)):          
        await  Get.to(() => Scaffold(appBar: AppBar(), body: Urine()));


          widget.data.urineTestId = controller.urineTestId;
          },
        controller.urineTestId != null,
      );}),

      GetBuilder<Selfscreeningcontroller>(
        builder: (controller) {
        return buildScreeningTile(
        "Glucose Test",
        "assets/labReports/glucose.png",
        () async { 
                 controller.glucoseTestId !=null ?
         await Get.to(()=> ScreeningReportLoader(id: controller.glucoseTestId!)):    
          
         await Get.to(() =>Scaffold(appBar: AppBar(), body:  Glucose()));
         
         widget.data.glucoseId = controller.glucoseTestId;
         
         },
        controller.glucoseTestId != null,
      );}),

      GetBuilder<Selfscreeningcontroller>(
        builder: (controller) {
      return buildScreeningTile(
        "Fetal Monitoring",
        "assets/labReports/fetalmon.png",
        () async { 
          controller.fetalmonitoringId !=null ?
          await Get.to(()=> ScreeningReportLoader(id: controller.fetalmonitoringId!)):   
          
          await Get.to(() => Scaffold(appBar: AppBar(), body: Fetalmonitoring()));
          
          widget.data.fetalTestId = controller.fetalmonitoringId;
          
          },
        controller.fetalmonitoringId != null,
      );}),

      GetBuilder<Selfscreeningcontroller>(
        builder: (controller) {
      return buildScreeningTile(
        "Ultrasound Test",
        "assets/labReports/ultrasound.png",
        () async { 
                    controller.ultrasoundId !=null ?
          await Get.to(()=> ScreeningReportLoader(id: controller.ultrasoundId!)):   
          await Get.to(() => Scaffold(appBar: AppBar(), body: Ultrasound()));
          
          widget.data.ultrasoundId = controller.ultrasoundId;
          
          },
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