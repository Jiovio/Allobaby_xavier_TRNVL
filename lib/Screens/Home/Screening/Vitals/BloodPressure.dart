
import 'package:allobaby/Screens/Home/Screening/Controllers/SelfScreeningController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

Row BloodPressure() {
  
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      GetBuilder<Selfscreeningcontroller>(
              builder: (c) =>
      NumberPicker(
                value: c.healthData["bloodPressureH"],
                minValue: 0,
                    maxValue: 300,
                onChanged: (value) {
                  c.updateVitals("bloodPressureH",value);
                },
              )
      ),

      Text("/"),
      GetBuilder<Selfscreeningcontroller>(
              builder: (c) =>
      NumberPicker(
                value: c.healthData["bloodPressureL"],
                minValue: 70,
                maxValue: 220,
                onChanged: (value) {
                c.updateVitals("bloodPressureL",value);

                },
              )),
    ],
  );
}
