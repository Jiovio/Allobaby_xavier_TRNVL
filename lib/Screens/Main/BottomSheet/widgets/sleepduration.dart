// import 'package:Allobaby/Config/Color.dart';
// import 'package:Allobaby/Screens/MainScreen/Controller/BottomSheetController.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/MainController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

sleepDuration(BuildContext context, 
// BottomSheetController controller
) {

    return GetBuilder<Maincontroller>(
      init: Maincontroller(),
      builder: (controller) => 
    Padding(
      padding: EdgeInsets.fromLTRB(20.0, 10, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Sleep Duration",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          Column(
            children: [
              Text(
                "${controller.bottomSheetData["sleepDuration"]} Hrs",
                // controller.sleepDuration.value,
                style: TextStyle(
                    fontSize: 20,
                    color: PrimaryColor,
                    fontWeight: FontWeight.bold),
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     OutlinedButton(
              //         style: OutlinedButton.styleFrom(
              //             side: controller.sleepType == "Night Sleep"
              //                 ? BorderSide(color: PrimaryColor, width: 1.5)
              //                 : null,
              //             padding: EdgeInsets.all(14),
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(8.0),
              //             ),
              //             textStyle: TextStyle(
              //                 fontSize: 18, fontWeight: FontWeight.w500)),
              //         onPressed: () {
              //           controller.sleepType = "Night Sleep";
              //           controller.update();
              //         },
              //         child: Center(child: Text("Night Sleep"))),
              //     OutlinedButton(
              //         style: OutlinedButton.styleFrom(
              //             side: controller.sleepType == "Day Sleep"
              //                 ? BorderSide(color: PrimaryColor, width: 1.5)
              //                 : null,
              //             padding: EdgeInsets.all(14),
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(8.0),
              //             ),
              //             textStyle: TextStyle(
              //                 fontSize: 18, fontWeight: FontWeight.w500)),
              //         onPressed: () {
              //           controller.sleepType = "Day Sleep";
              //           controller.update();
              //         },
              //         child: Center(child: Text("Day Sleep"))),
              //   ],
              // ),

              // Row(
              //   children: [
              //     Flexible(
              //       child: TextFormField(
              //         readOnly: true,
              //         controller: startDate,
              //         onTap: () {
              //           showDatePicker(
              //             context: context,
              //             initialDate: DateTime.now(),
              //             firstDate: DateTime.now().subtract(Duration(days: 1)),
              //             lastDate: DateTime.now(),
              //           ).then((selectedDate) {
              //             final localization = MaterialLocalizations.of(context);
              //             startDate.text =
              //                 localization.formatShortDate(selectedDate!);
              //             print(startDate.text);
              //           });
              //         },
              //         decoration: InputDecoration(
              //             labelText: "Start Date", border: OutlineInputBorder()),
              //         keyboardType: TextInputType.number,
              //         validator: (value) {
              //           if (value == null || value.isEmpty) {
              //             return 'Please enter Date of Birth';
              //           }
              //           return null;
              //         },
              //       ),
              //     ),
              //     SizedBox(
              //       width: 12,
              //     ),
              //     Flexible(
              //       child: TextFormField(
              //         readOnly: true,
              //         controller: endDate,
              //         onTap: () {
              //           // showDatePicker(
              //           //   context: context,
              //           //   initialDate: DateTime.now(),
              //           //   firstDate: DateTime.now().subtract(Duration(days: 1)),
              //           //   lastDate: DateTime.now(),
              //           // ).then((selectedDate) {
              //           //   final localization = MaterialLocalizations.of(context);
              //           //   endDate.text =
              //           //       localization.formatShortDate(selectedDate!);
              //           //   print(endDate.text);
              //           // });
              //         },
              //         decoration: InputDecoration(
              //             labelText: "End Date", border: OutlineInputBorder()),
              //         keyboardType: TextInputType.number,
              //         validator: (value) {
              //           if (value == null || value.isEmpty) {
              //             return 'Please enter Date of Birth';
              //           }
              //           return null;
              //         },
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      readOnly: true,
                      controller: controller.bedtime,
                      onTap: () {
                        showTimePicker(
                                context: context, initialTime: TimeOfDay.now())
                            .then((selectedTime) {
                          print(selectedTime);
                          final localization =
                              MaterialLocalizations.of(context);


                          var i = localization.formatTimeOfDay(selectedTime!);
                          controller.setBottomSheetData("bedTime", i);
                          controller.bedtime.text = i;
                          controller.update();
                          print(i);
                          
                          
                          // controller.SleepDurationHrs();
                        });
         
                      },
                      decoration: InputDecoration(
                          labelText: "Bed Time", border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Date of Birth';
                        }
                        return "Hi";
                      },
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Flexible(
                    child: TextFormField(
                      readOnly: true,
                      controller: controller.waketime,
                      onTap: () {
                     
                        showTimePicker(
                                context: context, initialTime: TimeOfDay.now())
                            .then((selectedTime) {
                          final localization =
                              MaterialLocalizations.of(context);
                          controller.waketime.text =
                              localization.formatTimeOfDay(selectedTime!);

                              controller.setBottomSheetData("wakeUpTime", localization.formatTimeOfDay(selectedTime!));
                          controller.setBottomSheetData("sleepDuration",calculateHoursBetween(controller.bedtime.text, controller.waketime.text));
                   
                        });
                      },
                      decoration: InputDecoration(
                          labelText: "Wake Up Time",
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Date of Birth';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 34,
          ),
        ],
      ),
    )
    );
  
  }



int calculateHoursBetween(String startTimeString, String endTimeString) {
  // Parse strings into DateTime objects
   DateFormat formatter = DateFormat('h:mm a');
   DateTime startTime = formatter.parse(startTimeString);
   DateTime endTime = formatter.parse(endTimeString);

  // Handle cases where endTime is earlier than startTime (next day)
  if (endTime.isBefore(startTime)) {
    endTime = endTime.add(Duration(days: 1));
  }

  // Calculate the difference in hours
  final difference = endTime.difference(startTime);
  return difference.inHours;
}