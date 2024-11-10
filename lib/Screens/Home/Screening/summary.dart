import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Screens/Home/Checkup/CheckUpReport.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget summary() {

          List<vitals> vitalsList = [
      vitals(
        title: 'Blood Pressure',
        image: 'assets/blood-pressure-gauge.png',
        value: "66",
      ),
      vitals(
        title: 'Temperature',
        image: 'assets/thermometer.png',
        value: "40",
      ),
      vitals(
        title: 'Blood Saturation',
        image: 'assets/blood.png',
        value: "96",
      ),
      vitals(
        title: 'Heart Rate',
        image: 'assets/cardiogram.png',
        value: "10",
      ),
      vitals(
        title: 'Blood Glucose',
        image: 'assets/glucose-meter.png',
        value: "10",
      ),
      vitals(
        title: 'BMI',
        image: 'assets/bmi.png',
        value: "10 H" +
            " - " +
            "10 W",
      ),
      vitals(
        title: 'Respiratory Rate',
        image: 'assets/peak-flow-meter.png',
        value: "100",
      ),
      vitals(
        title: 'HRV',
        image: 'assets/computer.png',
        value: "10",
      )
    ];
    


  return 

  SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        
        children: [

              
              SizedBox(
                // width: double.infinity,
                child: Text(
                      "Summary Report",
                      style: TextStyle(
                          color: Get.isDarkMode ? Colors.grey : PrimaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
              ),
              SizedBox(
                height: 18,
              ),


              SizedBox(
                width: double.infinity,
                child: Text(
                  "Symptoms",
                  style: TextStyle(
                      color: Get.isDarkMode ? Colors.grey : PrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),

                Wrap(
                spacing: 12.0,
                children: List.generate(
                    1, (index) {
                  return Chip(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Get.isDarkMode ? Colors.grey : PrimaryColor,
                            width: 1.5),
                        borderRadius: BorderRadius.circular(4.0)),
                    label: Text("Symptoms"),
                    labelStyle: TextStyle(
                        color: Get.isDarkMode ? White : Black,
                        fontWeight: FontWeight.w600),
                  );
                }),
              ),
              SizedBox(
                height: 18,
              ),

              
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Vitals",
                  style: TextStyle(
                      color: Get.isDarkMode ? Colors.grey : PrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
                  GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 2.0,
                      mainAxisSpacing: 8.0,
                      children: List.generate(vitalsList.length, (index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  vitalsList[index].value,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: PrimaryColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  vitalsList[index].title,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        );
                      }))
                
        ],
      ),
    ),
  );

}