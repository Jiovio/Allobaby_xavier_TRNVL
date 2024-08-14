import 'package:allobaby/Config/Color.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

Wrap BloodGlucose() {
  return Wrap(
    crossAxisAlignment: WrapCrossAlignment.start,
    children: [
      Column(
        children: [
             Column(
              children: [
                Row(
                  children: [
                    Text("mg/dL"),
                    ValueBuilder<bool?>(
                      initialValue: true,
                      // initialValue: c.iBloodGlucoseValue.value ? false : true,

                      builder: (isChecked, updateFn) => Switch(
                        activeColor: PrimaryColor,
                        value: isChecked!,
                        onChanged: (newValue) {
                          // c.iBloodGlucoseValue.value =
                          //     !c.iBloodGlucoseValue.value.obs();
                          // c.update();
                          // updateFn(newValue);
                        },
                      ),
                    ),
                    // Text("mmol/L"),
                  ],
                ),
                Text("Fasting"),
                Row(
                  children: [
                    DecimalNumberPicker(
                      value: 50,
                      // value: c.bloodGlucoseBF,

                      minValue: 20,
                      maxValue: 700,
                      decimalPlaces: 1,
                      onChanged: (value) {
                        // c.bloodGlucoseBFChange(value);
                      },
                    ),
                    Flexible(
                        // child: Text(c.iBloodGlucoseValue.value ? "mg/dl" : ""))
                        child: Text("mg/dl"))

                  ],
                ),
                Text("pp"),
                Row(
                  children: [
                    DecimalNumberPicker(
                      // value: c.bloodGlucoseAF,
                      value: 30,

                      minValue: 20,
                      maxValue: 700,
                      decimalPlaces: 1,
                      onChanged: (value) {
                        // c.bloodGlucoseAFChange(value);
                      },
                    ),
                    Flexible(
                        child: Text("mg/dl"))
                        // child: Text(c.iBloodGlucoseValue.value ? "mg/dl" : ""))

                  ],
                )
              ],
            )
          ,
        ],
      ),
    ],
  );
}
