import 'dart:convert';

import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Screens/Initial/LastCycleUI.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../main.dart';

import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ParentDetails extends StatelessWidget {
  late DateTime startDate;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Enter your spouse mobile number.",
                  style: TextStyle(
                      color: PrimaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 40,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        // enabled: true,
                        // controller: initialDetailsController.partnerName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Spouse Name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "Spouse Name",
                            border: OutlineInputBorder()),
                        // keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Spouse Mobile Number';
                          }
                          return null;
                        },
                        // enabled: false,
                        // controller:initialDetailsController.partnerMobileNumber,
                        maxLength: 10,
                        decoration: InputDecoration(
                            labelText: "Spouse Mobile Number",
                            border: OutlineInputBorder()),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Flexible(
                      //   child: OutlinedButton(
                      //     onPressed: () => Get.to(() => LastCycleUI(),
                      //         transition: Transition.rightToLeft),
                      //     style: ElevatedButton.styleFrom(
                      //         side: BorderSide(color: PrimaryColor),
                      //         minimumSize: Size(100, 40),
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(40),
                      //         )),
                      //     child: Text(("Skip").toUpperCase()),
                      //   ),
                      // ),
                      Spacer(),
                      Flexible(
                        child: ElevatedButton(
                          onPressed: () async {
                            // if (_formKey.currentState!.validate()) {
                  

                            //   var res = await http.get(Uri.parse(
                            //       'https://www.fast2sms.com/dev/bulkV2?authorization=nJN90tufZ8eamKz5PqwCWBLYo73kyGIihFcgpSMARr4Q2vdxEVlGfVmwrZq5USX79s8K6PA3nIijcLHB&route=dlt&sender_id=SAVMOM&message=142759&variables_values=&flash=0&numbers=${initialDetailsController.partnerMobileNumber.text}'));
                            //   var data = jsonDecode(res.body);
                            //   if (data['return'] == true) {
                            //     Get.snackbar("Message",
                            //         "Sent SMS to Spouse is Successfull",
                            //         icon: Icon(
                            //           Icons.clear,
                            //           color: White,
                            //         ),
                            //         snackPosition: SnackPosition.BOTTOM,
                            //         animationDuration:
                            //             Duration(milliseconds: 500),
                            //         margin: EdgeInsets.all(0),
                            //         duration: Duration(milliseconds: 1500),
                            //         borderRadius: 4.0,
                            //         backgroundColor: Colors.red,
                            //         colorText: White);
                                Get.to(() => LastCycleUI(),
                                    transition: Transition.rightToLeft);
                            //   } else {
                            //     Get.snackbar("Message",
                            //         "SMS to Spouse is UnSuccessfull",
                            //         icon: Icon(
                            //           Icons.clear,
                            //           color: White,
                            //         ),
                            //         snackPosition: SnackPosition.BOTTOM,
                            //         animationDuration:
                            //             Duration(milliseconds: 500),
                            //         margin: EdgeInsets.all(0),
                            //         duration: Duration(milliseconds: 1500),
                            //         borderRadius: 4.0,
                            //         backgroundColor: Colors.red,
                            //         colorText: White);
                            //   }
                            // } else {
                            //   Get.snackbar(
                            //       "Message", "Please Enter Spouse Details",
                            //       icon: Icon(
                            //         Icons.clear,
                            //         color: White,
                            //       ),
                            //       snackPosition: SnackPosition.BOTTOM,
                            //       animationDuration:
                            //           Duration(milliseconds: 500),
                            //       margin: EdgeInsets.all(0),
                            //       duration: Duration(milliseconds: 1500),
                            //       borderRadius: 4.0,
                            //       backgroundColor: Colors.red,
                            //       colorText: White);
                            // }
                        
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(100, 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40))),
                          child: Text(("Continue").toUpperCase()),
                        ),
                      ),
                    ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
