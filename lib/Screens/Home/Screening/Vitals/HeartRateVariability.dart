
import 'package:allobaby/Screens/Home/Screening/Controllers/SelfScreeningController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

Widget HeartRateVariability() {
  return GetBuilder<Selfscreeningcontroller>(
      builder: (c) => 
        NumberPicker(
            // value: 10,
            value: c.healthData["hrv"],

            minValue: 5,
            maxValue: 20,
            onChanged: (value) {
              // c.hrvChange(value);
              c.updateVitals("hrv", value);
            },
          ));
          
          // );
}
