import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Screens/Home/Screening/Controllers/SelfScreeningController.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/BMI.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/BloodGlucose.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/BloodPressure.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/BloodSaturation.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/HBSelector.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/HeartRate.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/HeartRateVariability.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/RespiratoryRate.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/Temperature.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VitalsScreen extends StatelessWidget {
   VitalsScreen({super.key});


   Selfscreeningcontroller controller = Get.put(Selfscreeningcontroller());

  @override
  Widget build(BuildContext context) {

        List<vitals> vitalsList = [
      vitals(
          title: 'Blood Pressure'.tr,
          image: 'assets/Vitals/blood-pressure-gauge.png',
          value: GetBuilder<Selfscreeningcontroller>(
              builder: (controller) => Text(
                  (controller.vitalsData["bloodPressureH"] ?? "_").toString() +
                      "/" +
                      (controller.vitalsData["bloodPressureL"]??"_").toString() +
                      "mmHg")),
          vitalsWidget: BloodPressure()),
      vitals(
          title: 'Temperature'.tr,
          image: 'assets/Vitals/thermometer.png',
          value: GetBuilder<Selfscreeningcontroller>(
              builder: (controller) => Text(
                  "${(controller.vitalsData["temperature"]??"_").toString()} °${controller.vitalsData["temperatureMetric"].toString()}"
                  )
                  ),
          vitalsWidget: Temperature()),
      vitals(
          title: 'Blood Saturation'.tr,
          image: 'assets/Vitals/blood.png',
          value: GetBuilder<Selfscreeningcontroller>(
              builder: (controller) => Text(
                  (controller.vitalsData["bloodSaturationBW"]??"_").toString() +
                      " / " +
                      "${(controller.vitalsData["bloodSaturationAW"]??"_").toString()} %")),
          vitalsWidget: BloodSaturation()),
      vitals(
          title: 'Heart Rate'.tr,
          image: 'assets/Vitals/cardiogram.png',
          value: GetBuilder<Selfscreeningcontroller>(
              builder: (controller) => Text(
                  "${(controller.vitalsData["heartRateBW"]??"_").toString()} bpm" +
                      " / " +
                      "${(controller.vitalsData["heartRateAW"]??"_").toString()} bpm")),
          vitalsWidget: HeartRate()),

      vitals(
          title: 'BMI'.tr,
          image: 'assets/Vitals/bmi.png',
          value: GetBuilder<Selfscreeningcontroller>(
              builder: (controller) => Text(
                  " (${(controller.vitalsData["bmiHeight"]??"_").toString()} H" +
                      " - " +
                      "${(controller.vitalsData["bmiWeight"]??"_").toString()} W)")),
          vitalsWidget: BMI()),
      vitals(
          title: 'Respiratory Rate'.tr,
          image: 'assets/Vitals/peak-flow-meter.png',
          value: GetBuilder<Selfscreeningcontroller>(
              builder: (controller) =>
                  Text((controller.vitalsData["respiratoryRate"]??"_").toString())),
          vitalsWidget: RespiratoryRate()),
      vitals(
          title: 'HB'.tr,
          image: 'assets/Vitals/computer.png',
          value: GetBuilder<Selfscreeningcontroller>(
              builder: (controller) => Text("${(controller.vitalsData["hB"]??"_").toString()} ms")),
          vitalsWidget: HBSelector()),

                vitals(
          title: 'Blood Glucose'.tr,
          image: 'assets/Vitals/glucose-meter.png',
          value: GetBuilder<Selfscreeningcontroller>(
              builder: (controller) => Text(
                  "${(controller.vitalsData["bloodGlucoseBF"]??"_").toString()} f " +
                      " / " +
                      "${(controller.vitalsData["bloodGlucoseAF"]??"_").toString()} pp")),
          vitalsWidget: BloodGlucose()),
    ];

    return  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Vitals".tr,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 10.0,
                children: List.generate(
                    vitalsList.length,
                    (index) => Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: InkWell(
                            borderRadius: BorderRadius.circular(8.0),
                            highlightColor: accentColor.withOpacity(0.1),
                            splashColor: accentColor.withOpacity(0.8),
                            onTap: () => showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text(vitalsList[index].title),
                                      content: vitalsList[index].vitalsWidget,
                                    )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  vitalsList[index].image,
                                  scale: 6,
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  vitalsList[index].title,
                                  // "hi",
                                  style: TextStyle(
                                      color: PrimaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                vitalsList[index].value,
                              ],
                            )))),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(onPressed: (){
                    controller.submitVitals();
                  
                  }, child: Text("Save")),
                ),
              )
            
            ],
          ),
        ),
      );
}
}

class vitals {
  String title;
  String image;
  Widget value;
  Widget vitalsWidget;
  vitals(
      {required this.title,
      required this.image,
      required this.vitalsWidget,
      required this.value
      });
}