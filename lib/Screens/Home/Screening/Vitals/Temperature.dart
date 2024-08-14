import 'package:allobaby/Config/Color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

Wrap Temperature() {
  return Wrap(
    children: [
         Wrap(children: [
          Row(
            children: [
              Text("°C"),
              ValueBuilder<bool?>(
                // initialValue: c.iValue.value ? false : true,
                initialValue: false,

                builder: (isChecked, updateFn) => Switch(
                  activeColor: PrimaryColor,
                  value: isChecked!,
                  onChanged: (newValue) {
                    // c.iValue.value = !c.iValue.value.obs();
                    // c.update();
                    // updateFn(newValue);
                  },
                ),
              ),
              Text("F"),
            ],
          ),
          DecimalNumberPicker(
            // value: c.iValue.value ? c.celsius : c.temperature,
            value: 30,

            // minValue: c.iValue.value ? 20 : 68,
            // maxValue: c.iValue.value ? 44 : 110,
                        minValue:20 ,
            maxValue: 44 ,
            decimalPlaces: 1,
            onChanged: (value) {
              // c.iValue.value
              //     ? c.celsiusChange(value)
              //     : c.temperatureChange(value);
            },
          ),
        ]
      ),
    ],
  );
}
