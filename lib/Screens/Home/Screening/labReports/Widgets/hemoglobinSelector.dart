
import 'package:allobaby/Controller/Reports/hemoglobinController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

Row HemoglobinSelector() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      GetBuilder<Hemoglobincontroller>(builder:(controller) => 
            NumberPicker(
                value: controller.hemoGlobinValue,
                                // value: 15,
                minValue: 0,
                maxValue: 20,
                onChanged: (value) {
                  controller.hemoGlobinValue=value;
                  controller.update();
                  // c.bloodPressureHChange(value);
                },
              ),
      )


    ],
  );
}