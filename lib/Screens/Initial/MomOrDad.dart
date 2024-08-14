
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Screens/Initial/ParentsDetails.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


// ignore: must_be_immutable
class MomOrDad extends StatelessWidget {


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
                  "Are you my mom or dad?",
                  style: TextStyle(
                      color: PrimaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                    children: [
                      Spacer(),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: true
                            // initialDetailsController.parentType == "Dad"
                                ? BorderSide(color: PrimaryColor, width: 1.5)
                                : null,
                            padding: EdgeInsets.all(14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            // initialDetailsController.parentType = "Dad";
                            // initialDetailsController.update();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: true
                                  // initialDetailsController.parentType =="Dad"
                                      ? PrimaryColor
                                      : Colors.grey,
                                ),
                                child: Image.asset(
                                  "assets/Gender/male.png",
                                  height: Get.height / 6,
                                  width: Get.width / 3,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Dad",
                                style: TextStyle(
                                    color: true
                                        // initialDetailsController.parentType == "Dad"
                                            ? PrimaryColor
                                            : Black),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )),
                      Spacer(),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: true 
                            // initialDetailsController.parentType == "Mom"
                                ? BorderSide(color: PrimaryColor, width: 1.5)
                                : null,
                            padding: EdgeInsets.all(14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            // initialDetailsController.parentType = "Mom";
                            // initialDetailsController.update();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: true
                                  //  initialDetailsController.parentType =="Mom"
                                      ? PrimaryColor
                                      : Colors.grey,
                                ),
                                child: Image.asset(
                                  "assets/Gender/female.png",
                                  height: Get.height / 6,
                                  width: Get.width / 3,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Mom",
                                style: TextStyle(
                                    color: true
                                        // initialDetailsController.parentType == "Mom"
                                            ? PrimaryColor
                                            : Black),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )),
                      Spacer(),
                    ],
                  )
                ,
                SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Flexible(
                      //   child: OutlinedButton(
                      //     onPressed: () => Get.to(() => AddressDetails(),
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
                          onPressed: () {
                            // if (_formKey.currentState!.validate()) {
                            // data.write(
                            //     'Qstartdate',
                            //     initialDetailsController
                            //         .quarantineStartDate.text);
                            // data.write(
                            //     'Qenddate',
                            //     initialDetailsController
                            //         .quarantineDueDate.text);
                            // initialDetailsController.quarantineStatus =
                            //     "In Progress";
                            // if (initialDetailsController.parentType == "Dad" ||
                            //     initialDetailsController.parentType == "Mom") {
                              Get.to(() => ParentDetails(),
                                  transition: Transition.rightToLeft);
                            // } else {
                            //   Get.snackbar(
                            //       "Message", "Please Select Parent Type",
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
