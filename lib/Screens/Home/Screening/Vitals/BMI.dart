
import 'package:allobaby/Screens/Home/Screening/Controllers/SelfScreeningController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

GetBuilder BMI() {
  return 
  GetBuilder<Selfscreeningcontroller>(
    
    builder:(c) => 
  Wrap(
    crossAxisAlignment: WrapCrossAlignment.start,
    children: [
      Text("Select Height"),
      Row(
        children: [

               NumberPicker(
                    value: c.healthData["bmiHeight"],
                    minValue: 50,
                    maxValue: 230,
                    onChanged: (value) {
                      c.updateVitals("bmiHeight", value);
                    },
                  ),
          Text("cm")
        ],
      ),
      Text("Select Weight"),
      Row(
        children: [
DecimalNumberPicker(
                    value: c.healthData["bmiWeight"],

                    minValue: 1,
                    maxValue: 200,
                    decimalPlaces: 1,
                    onChanged: (value) {
                      c.updateVitals("bmiWeight", value);
                     
                    },
                  ),
          Flexible(child: Text("kg"))
        ],
      ),
    ],
  ));
}
