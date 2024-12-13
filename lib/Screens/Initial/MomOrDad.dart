
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/SignupController.dart';
import 'package:allobaby/Screens/Initial/ParentsDetails.dart';
import 'package:allobaby/Screens/Initial/PregnancyStatus.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


// ignore: must_be_immutable
class MomOrDad extends StatelessWidget {

  Signupcontroller controller = Get.put(Signupcontroller());


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
                  "Are you my mom or dad?".tr,
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

                      GetBuilder(
                        init: Signupcontroller(),
                        builder: (controller)=>
                                            OutlinedButton(
                          style: OutlinedButton.styleFrom(
                          side:   controller.data["parentType"] == "Dad"
                                ? BorderSide(color: PrimaryColor, width: 1.5)
                                : null,
                            padding: EdgeInsets.all(14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            controller.updateData("parentType", "Dad");

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
                                  color: 
                                  controller.data["parentType"] == "Dad"
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
                                "Dad".tr,
                                style: TextStyle(
                                    color: 
                                        controller.data["parentType"] == "Dad"
                                            ? PrimaryColor
                                            : Black),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )),
                      
                      ),

                      
                      Spacer(),

                      GetBuilder
                      (
                        init: Signupcontroller(),
                        builder: (controller)=>
                                            OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: controller.data["parentType"] == "Mom" 
                            // initialDetailsController.parentType == "Mom"
                                ? BorderSide(color: PrimaryColor, width: 1.5)
                                : null,
                            padding: EdgeInsets.all(14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            controller.updateData("parentType", "Mom");
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
                                  color: 
                                   controller.data["parentType"] =="Mom"
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
                                "Mom".tr,
                                style: TextStyle(
                                    color: controller.data["parentType"] == "Mom"
                                        // initialDetailsController.parentType == "Mom"
                                            ? PrimaryColor
                                            : Black),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )),
                      
                      ),

                      
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
             
                              Get.to(() => Pregnancystatus(),
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
                          child: Text(("Continue".tr).toUpperCase()),
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
