
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

Wrap BMI() {
  return Wrap(
    crossAxisAlignment: WrapCrossAlignment.start,
    children: [
      Text("Select Height"),
      Row(
        children: [

               NumberPicker(
                    // value: c.bmiHeight,
                                        value: 55,
                    minValue: 50,
                    maxValue: 230,
                    onChanged: (value) {
                      // c.bmiHeightChange(value);
                    },
                  ),
          Text("cm")
        ],
      ),
      Text("Select Weight"),
      Row(
        children: [
DecimalNumberPicker(
                    // value: c.bmiWeight,
                                        value: 15,
                    minValue: 1,
                    maxValue: 200,
                    decimalPlaces: 1,
                    onChanged: (value) {
                      // c.bmiWeightChange(value);
                     
                    },
                  ),
          Flexible(child: Text("kg"))
        ],
      ),
    ],
  );
}
