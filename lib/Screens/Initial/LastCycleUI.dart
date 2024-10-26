import 'package:allobaby/Components/textfield.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/SignupController.dart';
import 'package:allobaby/Screens/Initial/AddressDetails.dart';
import 'package:allobaby/Screens/Initial/Widgets/AverageCycleLength.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import '../../../main.dart';


// ignore: must_be_immutable
class LastCycleUI extends StatelessWidget {


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
             const   SizedBox(
                  height: 40,
                ),
               const Text(
                  "Select Last cycle Date",
                  style: TextStyle(
                      color: PrimaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
             const SizedBox(
                  height: 40,
                ),
                
                GetBuilder(
                  init: Signupcontroller(),
                  builder:(controller) => 
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      
                      if(controller.data["pregnancyStatus"]!=controller.pregnancyStatusList[2])
                      ...[
                      TextFormField(
                        readOnly: true,
                        controller: controller.lmpDate,
                        onTap: () {
                          controller.eddate.text="";
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now().subtract(const Duration(days: 305)),
                            lastDate: DateTime.now(),
                          ).then((selectedDate) {
                      
                            // print(selectedDate);

                            // controller.lmpDate.text = selectedDate!.toLocal().toString();
                            controller.lmpDate.text = DateFormat('dd-MM-yyyy').format(selectedDate!.toLocal());

                            DateTime eddate = selectedDate.add(Duration(days: 280));

                            controller.eddate.text = DateFormat('dd-MM-yyyy').format(eddate.toLocal());

                            controller.update();

                      
                          });
                        },
                        decoration: InputDecoration(
                            labelText: "LMP Date", border: OutlineInputBorder()),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter LMP Date';
                          }
                          return null;
                        },
                      ),
                SizedBox(
                  height: 20,
                ),

                      ],


                if(controller.data["pregnancyStatus"]=="Iam pregnant" && controller.eddate.text!="")
                Column(
                  children: [
                TextField(
                  enabled: false,
                  controller: controller.eddate,
                  decoration: InputDecoration(
                      labelText: "ED Date", border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 20,
                ),
                  ],
                ),


                    if(controller.data["pregnancyStatus"]==controller.pregnancyStatusList[0])

                    ...[TextFormField(
                    readOnly: true,
                    controller: controller.averageCycleLength,
                    onTap: () {
                    showDialog(context: context, builder:(context) {
                      
                    return averageCycleLength();
                    },);
                    },
                    decoration: InputDecoration(
                        labelText: "Average Length of Cycles", border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter LMP Date';
                      }
                      return null;
                    },
                  ),

                                  SizedBox(
                  height: 20,
                )],


                     if(controller.data["pregnancyStatus"]==controller.pregnancyStatusList[2])
                        ...[TextFormField(
                        readOnly: true,
                        controller: controller.dateofdelivery,
                        onTap: () {
                          controller.eddate.text="";
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now().subtract(const Duration(days: 305)),
                            lastDate: DateTime.now(),
                          ).then((selectedDate) {
                      
                            // print(selectedDate);

                            // controller.lmpDate.text = selectedDate!.toLocal().toString();
                            controller.dateofdelivery.text = DateFormat('dd-MM-yyyy').format(selectedDate!.toLocal());

                      
                          });
                        },
                        decoration: InputDecoration(
                            labelText: "Date of delivery", border: OutlineInputBorder()),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Delivery Date';
                          }
                          return null;
                        },
                      ),
                                                        SizedBox(
                  height: 20,
                )]
                        



                    ],
                  ),
                )),

                // Container(
                //   height: 60.0,
                //   child: DropdownSearch<String>(
                //     validator: (v) =>
                //         v == null ? "Select Family members" : null,
                //     // mode: Mode.MENU,
                //     // showSelectedItem: true,
                //     items: List<String>.generate(10, (i) => (i + 1).toString()),
                //     // label: "No of family members",
                //     onChanged: (value) {
                //       // initialDetailsController.noOfFamilyMember = value!;
                //     },
                //   ),
                // ),
                






                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
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
                      //     child:
                      //     Text(("Skip").toUpperCase()),
                      //   ),
                      // ),
                      SizedBox(
                        width: 4,
                      ),
                      Flexible(
                        child: ElevatedButton(
                          onPressed: () {
                            // if (_formKey.currentState!.validate()) {
                            //   data.write(
                            //       'Qstartdate',
                            //       initialDetailsController
                            //           .quarantineStartDate.text);
                            //   data.write(
                            //       'Qenddate',
                            //       initialDetailsController
                            //           .quarantineDueDate.text);
                            //   initialDetailsController.quarantineStatus =
                            //       "In Progress";
                              Get.to(() => AddressDetails(),
                                  transition: Transition.rightToLeft);
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
