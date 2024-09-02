
import 'package:allobaby/Controller/Reports/fetalMonitoringController.dart';
import 'package:allobaby/Controller/Reports/glucoseController.dart';
import 'package:allobaby/Controller/Reports/hemoglobinController.dart';
import 'package:allobaby/Controller/Reports/ultraSoundController.dart';
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


Row fetalHeartMonitoring() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      GetBuilder<Fetalmonitoringcontroller>(builder:(controller) => 
                    NumberPicker(
                  value: controller.heartRate,
                  minValue: 30,
                  itemHeight: 32,
                  maxValue: 150,
                  onChanged: (value) {
                    // print(value);
                    controller.heartRate = value;
                    controller.update();
                  },
                              )
      )


    ],
  );
}


Row ultraSoundHeartMonitoring() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      GetBuilder<Ultrasoundcontroller>(
        init: Ultrasoundcontroller(),
        builder:(controller) => 
                    NumberPicker(
                  value: controller.heartRate,
                  minValue: 30,
                  itemHeight: 32,
                  maxValue: 150,
                  onChanged: (value) {
                    controller.heartRate = value;
                    // controller.heartRate = value;
                    controller.update();
                  },
                              )
      )


    ],
  );
}

Wrap glucoseSelector() {
  return Wrap(
    crossAxisAlignment: WrapCrossAlignment.start,
    children: [
             Column(
              children: [
                // Row(
                //   children: [
                //     Text("mg/dL"),
                //     ValueBuilder<bool?>(
                //       initialValue: true,
                //       // initialValue: c.iBloodGlucoseValue.value ? false : true,

                //       builder: (isChecked, updateFn) => Switch(
                //         activeColor: PrimaryColor,
                //         value: isChecked!,
                //         onChanged: (newValue) {
                //           // c.iBloodGlucoseValue.value =
                //           //     !c.iBloodGlucoseValue.value.obs();
                //           // c.update();
                //           // updateFn(newValue);
                //         },
                //       ),
                //     ),
                //     Text("mmol/L"),
                //   ],
                // ),
                // Text("Fasting"),
                GetBuilder(
                  init: Glucosecontroller(),
                  builder:(controller) => 
                Row(
                  children: [
                    DecimalNumberPicker(
                      // value: 50,
                      value: controller.glucoseValue,

                      minValue: 20,
                      maxValue: 700,
                      decimalPlaces: 1,
                      onChanged: (value) {
                        controller.glucoseValue = value;
                        controller.update();
                      },
                    ),
                    Flexible(
                        // child: Text(c.iBloodGlucoseValue.value ? "mg/dl" : ""))
                        child: Text("mg/dl"))

                  ],
                )),
                // Text("pp"),
                // Row(
                //   children: [
                //     DecimalNumberPicker(
                //       // value: c.bloodGlucoseAF,
                //       value: 30,

                //       minValue: 20,
                //       maxValue: 700,
                //       decimalPlaces: 1,
                //       onChanged: (value) {
                //         // c.bloodGlucoseAFChange(value);
                //       },
                //     ),
                //     Flexible(
                //         child: Text("mg/dl"))
                //         // child: Text(c.iBloodGlucoseValue.value ? "mg/dl" : ""))

                //   ],
                // )
              ],
            )
          ,
 
    ],
  );
}

