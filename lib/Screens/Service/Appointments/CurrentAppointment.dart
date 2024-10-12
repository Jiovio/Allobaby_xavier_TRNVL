import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Screens/Home/Checkup/CheckUpReport.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Currentappointment extends StatelessWidget {
  const Currentappointment({super.key});

  @override
  Widget build(BuildContext context) {
    return 
            SingleChildScrollView(
              
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Current Appointment".tr,
                      style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.bold),
                    )),
                // controller.upcomingAppointmentList.length == 0
                false
                    ? Center(
                        child: Text("No Upcoming Appointments".tr),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height / 2.5,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                1,
                            itemBuilder: (BuildContext context, index) =>
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  margin: EdgeInsets.only(
                                      left: 10, top: 10, right: 4),
                                  decoration: BoxDecoration(
                                    color: PrimaryColor.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: InkWell(
                                      borderRadius: BorderRadius.circular(14),
                                      highlightColor:
                                          accentColor.withOpacity(0.3),
                                      splashColor: accentColor.withOpacity(0.5),
                                      onTap: () {
                                        
                                        // Get.to(()=>Consultation(),
                                        // transition: Transition.rightToLeft);

                                          //  Get.to(
                                          // () => Consultation(
                                          //       appointment: controller
                                          //               .upcomingAppointmentList[
                                          //           index],
                                          //       patientDetails: patientDetails,
                                          //     ),
                                          // transition: Transition.rightToLeft),

                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20.0, right: 20.0, left: 20.0),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Dr. Palaniappan",
                                                style: TextStyle(
                                                    color: White,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Divider(
                                                color: White,
                                                thickness: 2,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Date".tr,
                                                    style: TextStyle(
                                                        color: White,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    " : 14-07-24",
                                                    style: TextStyle(
                                                        color: White,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Time".tr,
                                                    style: TextStyle(
                                                        color: White,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    " : 4 PM",
                                                    style: TextStyle(
                                                        color: White,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Status".tr,
                                                    style: TextStyle(
                                                        color: White,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    " : Booked",
                                                    style: TextStyle(
                                                        color: White,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Diagnosis Desc".tr,
                                                    style: TextStyle(
                                                        color: White,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    // " : ${controller.upcomingAppointmentList[index].diagnosisDesc.toUpperCase()}",
                                                    "4 PM",
                                                    style: TextStyle(
                                                        color: White,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 14,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // ElevatedButton(
                                                  //     style: ElevatedButton
                                                  //         .styleFrom(
                                                  //             backgroundColor: White,
                                                  //             elevation: 0),
                                                  //     onPressed: () {}, 
                                                  //     // Get.to(
                                                  //     //     () => Consultation(
                                                  //     //           appointment:
                                                  //     //               controller
                                                  //     //                       .upcomingAppointmentList[
                                                  //     //                   index],
                                                  //     //           patientDetails:
                                                  //     //               patientDetails,
                                                  //     //         ),
                                                  //     //     transition: Transition
                                                  //     //         .rightToLeft),
                                                  //     child: Text(
                                                  //       "View Appointment".tr,
                                                  //       style: TextStyle(
                                                  //           color:
                                                  //               Colors.black),
                                                  //     )),
                                                  
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor: White,
                                                              elevation: 0
                                                              ),
                                                      onPressed: () {
                                                        showDialog<void>(
                                                          context: context,
                                                          barrierDismissible:
                                                              true, // user must tap button!
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  'Cancel Appointment'
                                                                      .tr),
                                                              content:
                                                                  SingleChildScrollView(
                                                                child: Text(
                                                                    'Are you sure to cancel the appointment?'
                                                                        .tr),
                                                              ),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  child: Text(
                                                                      'No'.tr),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                                TextButton(
                                                                  child: Text(
                                                                      'Yes'.tr),
                                                                  onPressed:
                                                                      () {
                                                                    // FirebaseConst
                                                                    //     .baseAppointmentCollection
                                                                    //     .doc(controller
                                                                    //         .upcomingAppointmentList[
                                                                    //             index]
                                                                    //         .appointmentId)
                                                                    //     .update({
                                                                    //   "appointmentStatus":
                                                                    //       "CANCELED"
                                                                    // }).then((value) {
                                                                    //   appointmentController
                                                                    //       .getAppointmentList(
                                                                    //           patientDetails.id);
                                                                    //   Get.back();
                                                                    // });
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Text(
                                                        "Cancel Appointment".tr,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ))
                                                ],
                                              )
                                            
                                            
                                            
                                            ]),
                                      )),
                                )),
                      ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      " My Appointments ".tr,
                      style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),
                    )),
                ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(10),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) => Card(
                      elevation: 1,
                      shape: Border(
                          left: BorderSide(
                              color: Colors.green,
                              // controller.completedAppointmentList[index]
                              //             .appointmentStatus ==
                              //         "COMPLETED"
                              //     ? Colors.green
                              //     : Colors.redAccent,
                              width: 4)),
                      child: InkWell(
                          highlightColor: accentColor.withOpacity(0.1),
                          splashColor: accentColor.withOpacity(0.8),
                          onTap: () =>
                          Get.to(CheckUpReport()),
                              // appointmentController.getSymptomsAndVitals(
                              //     controller.completedAppointmentList[index],
                              //     index),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 10, right: 20, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: <Widget>[
                                    Text(
                                      // DateFormat('dd')
                                      //     .format(DateTime.parse(controller
                                      //         .completedAppointmentList[index]
                                      //         .appointmentDate))
                                      //     .toString(),
                                      "14-07-24",
                                      style: TextStyle(
                                          color: true ? Colors.green
                                              : Colors.redAccent,

                                          // controller
                                          //             .completedAppointmentList[
                                          //                 index]
                                          //             .appointmentStatus ==
                                          //         "COMPLETED"
                                          //     ? Colors.green
                                          //     : Colors.redAccent,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text( "15-07-24",
                                        // DateFormat.MMM()
                                        //     .format(DateTime.parse(controller
                                        //         .completedAppointmentList[index]
                                        //         .appointmentDate))
                                        //     .toString(),
                                        style: TextStyle(
                                            color: Colors.green,
                                            // controller
                                            //             .completedAppointmentList[
                                            //                 index]
                                            //             .appointmentStatus ==
                                            //         "COMPLETED"
                                            //     ? Colors.green
                                            //     : Colors.redAccent,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                  ],
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Appointment Status".tr,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(height: 6.0),
                                      Text(
                                        "Booked",
                                        // controller
                                        //     .completedAppointmentList[index]
                                        //     .appointmentStatus
                                        //     .tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                          // controller.completedAppointmentList[
                                          //                 index]
                                          //             .appointmentStatus ==
                                          //         "COMPLETED"
                                          //     ? Colors.green
                                          //     : Colors.redAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ))),
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                    height: 10,
                  ),
                  itemCount: 1,
                  // controller.completedAppointmentList.length,
                )
              ],
            ),
          
        


              );

  }
}