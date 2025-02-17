
import 'dart:async';

import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/SignupController.dart';
import 'package:allobaby/Screens/Initial/InitialDetails.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../main.dart';


// ignore: must_be_immutable
class AddressDetails extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          
          child: 
          GetBuilder(
            init: Signupcontroller(),
            builder:(controller) => 
          Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Address Information".tr,
                    style: TextStyle(
                        color: PrimaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controller.doorNo,
                    decoration: InputDecoration(
                        labelText: "Door No".tr, border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Door No'.tr;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                     controller: controller.streetName,
                    decoration: InputDecoration(
                        labelText: "Street Name".tr, border: OutlineInputBorder()),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Street Name'.tr;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                        controller: controller.pincode,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        decoration: InputDecoration(
                            suffix:
                            controller.pincodeSearching
                                    ? SizedBox(
                                        height: 15,
                                        width: 15,
                                        child: CircularProgressIndicator())
                                    : SizedBox(),
                            labelText: "Pincode".tr,
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Pincode'.tr;
                          }
                          return null;
                        },
                        onChanged: (value) {
                          
                          if(controller.pincode.text.length==6){
                            controller.searchPincode();
                          }
                        },
                      ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Visibility(
                        visible: true,
                            // initialDetailsController.areaNameVisibility.value,
                        child: Container(
                          height: 60.0,
                          child: DropdownSearch<String>(
                            // searchBoxController: TextEditingController(),



                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                              labelText: "Search Area".tr,
                              border: OutlineInputBorder()
                            )
                            ),


                            // isFilteredOnline: true,
                            
                            selectedItem: controller.selectedArea,
                            
                            validator: (v) =>
                                v == null ? "Select Area Name".tr : null,
                            // mode: Mode.BOTTOM_SHEET,
                            popupProps: PopupProps.bottomSheet(
                              showSearchBox: true,
                              searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(label: Text("Search".tr),
                                  border: OutlineInputBorder())
                              )


                            ),
                            // showSelectedItem: true,
                            items: controller.areas,
                            // label: "Area Name",
                            onChanged: (value) {
                              // initialDetailsController.areaName = value!;
                              controller.selectedArea = value!;
                            },
                          ),
                        ),
                      ),
                  SizedBox(
                    height: 22.0,
                  ),




                                          Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: OutlinedButton(
                          onPressed: () => Get.to(() => InitialDetails(),
                              transition: Transition.rightToLeft),
                          style: ElevatedButton.styleFrom(
                              side: BorderSide(color: PrimaryColor),
                              minimumSize: Size(100, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              )),
                          child: Text(("Skip").toUpperCase()),
                        ),
                      ),
                      Spacer(),
                      Flexible(
                        child: 
                        GetBuilder(
                          init: Signupcontroller(),
                          builder:(controller) => 
                        ElevatedButton(
                          onPressed: () {
                        if (_formKey.currentState!.validate()) {


                          Get.to(() => InitialDetails(),
                              transition: Transition.rightToLeft);



                        }
                            
                        
                      },
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(100, 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40))),
                          child: Text(("Continue".tr).toUpperCase()),
                        )),
                      ),
                    ]),
                        
//                   Center(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                         }
//  Get.to(() => InitialDetails(),
//                               transition: Transition.rightToLeft);
                        
//                       },
//                       style: ElevatedButton.styleFrom(
//                           minimumSize: Size(100, 50),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(40))),
//                       child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(("Continue".tr).toUpperCase()),
//                             SizedBox(
//                               width: 18.0,
//                             ),
//                             Icon(Icons.arrow_forward)
//                           ]),
//                     ),
//                   )
                
                
                
                ],
              ))),
        ),
      ),
    );
  }
}
