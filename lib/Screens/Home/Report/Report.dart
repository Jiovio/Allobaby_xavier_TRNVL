import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Screens/Home/Report/AddReport.dart';
import 'package:allobaby/Screens/Home/Report/ViewReport.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Report extends StatelessWidget {
  const Report({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Report")),
      body: Column(

        children: [
          Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 20),
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.only(
                          left: 20, right: 40, top: 14, bottom: 14)),
                  onPressed: () => Get.to(() => AddReport(),
                      transition: Transition.rightToLeft),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.camera),
                      Text("Scan and Add new Report".toUpperCase())
                    ],
                  ))),
SizedBox(height: 10,),

                Card(
                elevation: 1,
                shape: Border(left: BorderSide(color: PrimaryColor, width: 4)),
                child: InkWell(
                    highlightColor: accentColor.withOpacity(0.1),
                    splashColor: accentColor.withOpacity(0.8),
                    onTap: () 
                    => Get.to(
                        () => ViewReport(),
                        transition: Transition.rightToLeft),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 40, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Image.memory(
                          //   base64Decode(reportController
                          //       .reportDetailsList[index].reportImg),
                          //   height: 100,
                          //   width: 100,
                          // ),

                          Image.network(
"https://media.istockphoto.com/id/1341785038/photo/business-graphs-charts-and-magnifying-glass-on-table-financial-development-banking-account.jpg?s=612x612&w=0&k=20&c=w7AFU8dx6N2z1P_ZAME8IxYpjK9iaDrWGQ7Ue1T1MpM=",
                            height: 100,
                            width: 100,
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Report Type",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text("This is a temporary Text"
                                // reportController
                                //   .reportDetailsList[index].reportDate
                                //   .split(" ")[0]
                                  
                                  )
                            ],
                          )
                        ],
                      ),
                    )),
              ),
            

          //                   Expanded(
          //     child: Obx(
          //   () => ListView.separated(
          //     padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          //     separatorBuilder: (BuildContext context, int index) => SizedBox(
          //       height: 10,
          //     ),
          //     itemCount: reportController.reportDetailsList.length,
          //     itemBuilder: (BuildContext context, int index) => Card(
          //       elevation: 1,
          //       shape: Border(left: BorderSide(color: PrimaryColor, width: 4)),
          //       child: InkWell(
          //           highlightColor: accentColor.withOpacity(0.1),
          //           splashColor: accentColor.withOpacity(0.8),
          //           onTap: () => Get.to(
          //               () => ViewReport(
          //                   reportDetails:
          //                       reportController.reportDetailsList[index]),
          //               transition: Transition.rightToLeft),
          //           child: Padding(
          //             padding:
          //                 const EdgeInsets.only(top: 20, right: 40, bottom: 20),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceAround,
          //               children: [
          //                 Image.memory(
          //                   base64Decode(reportController
          //                       .reportDetailsList[index].reportImg),
          //                   height: 100,
          //                   width: 100,
          //                 ),
          //                 Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text(
          //                       reportController
          //                           .reportDetailsList[index].reportType,
          //                       style: TextStyle(
          //                           fontSize: 20, fontWeight: FontWeight.w500),
          //                     ),
          //                     SizedBox(
          //                       height: 8,
          //                     ),
          //                     Text(reportController
          //                         .reportDetailsList[index].reportDate
          //                         .split(" ")[0])
          //                   ],
          //                 )
          //               ],
          //             ),
          //           )),
          //     ),
          //   ),
          // ))


        ],

      ),

    );
  }
}