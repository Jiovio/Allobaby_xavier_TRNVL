
import 'package:allobaby/Config/Color.dart';
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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Address Information",
                    style: TextStyle(
                        color: PrimaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    // controller: initialDetailsController.doorNo,
                    decoration: InputDecoration(
                        labelText: "Door No", border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Door No';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    // controller: initialDetailsController.streetName,
                    decoration: InputDecoration(
                        labelText: "Street Name", border: OutlineInputBorder()),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Street Name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                        // controller: initialDetailsController.pinCode,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            suffix:true
                            // initialDetailsController.isLoadingAreaName.value
                                    ? SizedBox(
                                        height: 15,
                                        width: 15,
                                        child: CircularProgressIndicator())
                                    : SizedBox(),
                            labelText: "Pincode",
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Pincode';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          // initialDetailsController.areaList.clear();
                          // initialDetailsController.areaList.add("Fetching....");
                          // initialDetailsController.getAreaName();
                          // if (value.length > 0 && value.trim() != "") {
                          //   initialDetailsController.isLoadingAreaName.value =
                          //       true;
                          // } else {
                          //   initialDetailsController.isLoadingAreaName.value =
                          //       false;
                          //   initialDetailsController.areaNameVisibility.value =
                          //       false;
                          // }
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
                            // searchBoxDecoration: InputDecoration(
                            //   labelText: "Search Area",
                            // ),
                            // isFilteredOnline: true,
                            // showSearchBox: true,
                            validator: (v) =>
                                v == null ? "Select Area Name" : null,
                            // mode: Mode.BOTTOM_SHEET,
                            // showSelectedItem: true,
                            items: [],
                            // label: "Area Name",
                            onChanged: (value) {
                              // initialDetailsController.areaName = value!;
                            },
                          ),
                        ),
                      ),
                  SizedBox(
                    height: 22.0,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          //   final OTPCode = otpCode.text;
                          //   final registerId = mobileVerificationController
                          //       .mobileVerificationModel.value.registerid;
                          //   final mobileNo = mobileVerificationController
                          //       .mobileNoController.text
                          //       .trim();
                          //   final type = mobileVerificationController
                          //       .mobileVerificationModel.value.type;
                          //
                          //   otpVerificationController.otpVerification(
                          //       mobileNo, registerId, OTPCode, type);

                          // Get.to(() => InitialDetails(),
                          //     transition: Transition.rightToLeft);
                        }
 Get.to(() => InitialDetails(),
                              transition: Transition.rightToLeft);
                        
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(100, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40))),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(("Continue").toUpperCase()),
                            SizedBox(
                              width: 18.0,
                            ),
                            Icon(Icons.arrow_forward)
                          ]),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
