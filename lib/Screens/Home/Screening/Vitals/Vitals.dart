import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Screens/Home/Screening/Controllers/SelfScreeningController.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/BMI.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/BloodGlucose.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/BloodPressure.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/BloodSaturation.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/HeartRate.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/HeartRateVariability.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/RespiratoryRate.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/Temperature.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VitalsScreen extends StatelessWidget {
   VitalsScreen({super.key});

  @override
  Widget build(BuildContext context) {

        List<vitals> vitalsList = [
      vitals(
          title: 'Blood Pressure',
          image: 'assets/Vitals/blood-pressure-gauge.png',
          value: GetBuilder<Selfscreeningcontroller>(
              builder: (controller) => Text(
                  controller.healthData["bloodPressureH"].toString() +
                      "/" +
                      controller.healthData["bloodPressureL"].toString() +
                      "mmHg")),
          vitalsWidget: BloodPressure()),
      vitals(
          title: 'Temperature',
          image: 'assets/Vitals/thermometer.png',
          value: GetBuilder<Selfscreeningcontroller>(
              builder: (controller) => Text(
                  "${controller.healthData["temperature"].toString()} °${controller.healthData["temperatureMetric"].toString()}"
                  )
                  ),
          vitalsWidget: Temperature()),
      vitals(
          title: 'Blood Saturation',
          image: 'assets/Vitals/blood.png',
          value: GetBuilder<Selfscreeningcontroller>(
              builder: (controller) => Text(
                  "${controller.healthData["bloodSaturationBW"].toString()}" +
                      " / " +
                      "${controller.healthData["bloodSaturationAW"].toString()} %")),
          vitalsWidget: BloodSaturation()),
      vitals(
          title: 'Heart Rate',
          image: 'assets/Vitals/cardiogram.png',
          value: GetBuilder<Selfscreeningcontroller>(
              builder: (controller) => Text(
                  "${controller.healthData["heartRateBW"].toString()} bpm" +
                      " / " +
                      "${controller.healthData["heartRateAW"].toString()} bpm")),
          vitalsWidget: HeartRate()),
      vitals(
          title: 'Blood Glucose',
          image: 'assets/Vitals/glucose-meter.png',
          value: GetBuilder<Selfscreeningcontroller>(
              builder: (controller) => Text(
                  "${controller.healthData["bloodGlucoseBF"].toString()} f " +
                      " / " +
                      "${controller.healthData["bloodGlucoseAF"].toString()} pp")),
          vitalsWidget: BloodGlucose()),
      vitals(
          title: 'BMI',
          image: 'assets/Vitals/bmi.png',
          value: GetBuilder<Selfscreeningcontroller>(
              builder: (controller) => Text(
                  " (${controller.healthData["bmiHeight"].toString()} H" +
                      " - " +
                      "${controller.healthData["bmiWeight"].toString()} W)")),
          vitalsWidget: BMI()),
      vitals(
          title: 'Respiratory Rate',
          image: 'assets/Vitals/peak-flow-meter.png',
          value: GetBuilder<Selfscreeningcontroller>(
              builder: (controller) =>
                  Text(controller.healthData["respiratoryRate"].toString())),
          vitalsWidget: RespiratoryRate()),
      vitals(
          title: 'HRV',
          image: 'assets/Vitals/computer.png',
          value: GetBuilder<Selfscreeningcontroller>(
              builder: (controller) => Text("${controller.healthData["hrv"].toString()} ms")),
          vitalsWidget: HeartRateVariability())
    ];

    return  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Vitals",
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