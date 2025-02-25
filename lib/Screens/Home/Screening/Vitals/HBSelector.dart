import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Screens/Home/Screening/Controllers/SelfScreeningController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

Wrap HBSelector() {
  return Wrap(
    children: [
      GetBuilder<Selfscreeningcontroller>(builder:(c) => 
         Wrap(children: [
      
          DecimalNumberPicker(
            value: c.healthData["hB"] ,
            // value: 30,

            minValue: 5,
            maxValue:20,
            decimalPlaces: 1,
            onChanged: (value) {
              c.updateVitals("hB", value);
              // c.iValue.value
              //     ? c.celsiusChange(value)
              //     : c.temperatureChange(value);
            },
          ),
        ]
      )),
    ],
  );
}
