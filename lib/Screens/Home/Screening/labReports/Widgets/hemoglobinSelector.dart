
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

Row HemoglobinSelector() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      NumberPicker(
                // value: c.bloodPressureH,
                                value: 15,
                minValue: 0,
                maxValue: 20,
                onChanged: (value) {
                  // c.bloodPressureHChange(value);
                },
              ),

    ],
  );
}
