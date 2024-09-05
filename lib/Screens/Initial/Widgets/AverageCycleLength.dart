

import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/SignupController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

Widget averageCycleLength() {
  return 
  GetBuilder<Signupcontroller>(
    init: Signupcontroller(),
    builder:(controller) => 
  AlertDialog(
                        title: Text("Average Length of Cycles"),
                        content: Container(
                          
                          color: White,
                          child: Wrap(
                            
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: [
                        
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Text("Select"),
                                  NumberPicker(minValue: 28, maxValue: 44, 
                                  
                                  value: controller.data["avgLengthOfCycles"], 
                                  onChanged:(value) {

                                    controller.updateData("avgLengthOfCycles", value);
                                    
                                  },),
                                ],
                              )
                            ],
                          ),
                        ),
  ));
}