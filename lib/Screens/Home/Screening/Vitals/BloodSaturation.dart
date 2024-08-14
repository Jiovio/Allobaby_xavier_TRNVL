
import 'package:flutter/cupertino.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:get/get.dart';

Wrap BloodSaturation() {
  return Wrap(
    crossAxisAlignment: WrapCrossAlignment.start,
    children: [
      Text("At rest"),
      Row(
        children: [
              DecimalNumberPicker(
                    // value: c.bloodSaturationBW,
                                        value: 50,
                    minValue: 40,
                    itemHeight: 32,
                    maxValue: 100,
                    decimalPlaces: 1,
                    onChanged: (value) {
                      // c.bloodSaturationBWChange(value);
                    },
                  ),
          Flexible(child: Text("%"))
        ],
      ),
      Text("After Walk"),
      Row(
        children: [
          DecimalNumberPicker(
                    // value: c.bloodSaturationAW,
                                        value: 55,
                    minValue: 40,
                    maxValue: 100,
                    itemHeight: 32,
                    decimalPlaces: 1,
                    onChanged: (value) {
                      // c.bloodSaturationAWChange(value);
                    },
                  ),
          Flexible(child: Text("%"))
        ],
      ),
    ],
  );
}
