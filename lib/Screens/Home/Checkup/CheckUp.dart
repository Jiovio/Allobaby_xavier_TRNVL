import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Screens/Home/Checkup/CheckUpReport.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckUp extends StatelessWidget {
  const CheckUp({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title:const Text("Checkup")),

      body: 
      true?
     const Center(
        child: Text("No Checkup Found"),
      )
      :
      ListView.separated(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 10,
            ),
            itemCount: 0,
            itemBuilder: (BuildContext context, int index) => Card(
              elevation: 2,
              shape: Border(left: BorderSide(color: PrimaryColor, width: 4)),
              child: InkWell(
                  highlightColor: accentColor.withOpacity(0.1),
                  splashColor: accentColor.withOpacity(0.8),
                  onTap: () => { 
                    Get.to(
        () => CheckUpReport(),
        transition: Transition.rightToLeft)
                   },
                  // serviceController.getCaseReport(
                  //     serviceController.caseHistory[index]["id"],
                  //     patientDetails),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 10, right: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 40,
                          child: Column(
                            children: <Widget>[
                              Text(
                                // DateFormat.d()
                                //     .format(DateTime.parse(serviceController
                                //         .caseHistory[index]["checkup_date"]))
                                //     .toString(),
                                "1",
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.grey
                                        : PrimaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                  // DateFormat.MMMM()
                                  //     .format(DateTime.parse(serviceController
                                  //         .caseHistory[index]["checkup_date"]))
                                  //     .toString().substring(0,3),
                                  "Jul",
                                  style: TextStyle(
                                      color: Get.isDarkMode
                                          ? Colors.grey
                                          : PrimaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 28.0,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Checkup Details",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 6.0),
                              Text(

                                "Checkup need to be done",
                                // serviceController.caseHistory[index]
                                //             ["checkup_status"] ==
                                //         0
                                //     ? "Checkup need to be done"
                                //     : serviceController.caseHistory[index]
                                //                 ["checkup_status"] ==
                                //             1
                                //         ? "Waiting for Doctor FeedBack"
                                //         : "Checkup Completed",
                                style: TextStyle(
                                  color: Black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
    );
  }
}