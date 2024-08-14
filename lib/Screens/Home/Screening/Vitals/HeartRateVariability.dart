
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

Widget HeartRateVariability() {
  // return GetBuilder<ServiceController>(
  //     builder: (c) => 
      return NumberPicker(
            value: 10,
            // value: c.hrv,

            minValue: 5,
            maxValue: 300,
            onChanged: (value) {
              // c.hrvChange(value);
            },
          );
          
          // );
}
