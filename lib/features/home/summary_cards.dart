



import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/AppointmentController.dart';
import 'package:allobaby/Screens/Service/Appointment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

summaryCards(String pregnancyStatus){

  return Column(children: [


                    _buildStatusCard(pregnancyStatus, pregnancyStatus== "I am pregnant"),
                    const SizedBox(height: 20),
                    _buildSummaryCard( 'No summary available'.tr),
                    const SizedBox(height: 20),
                    _buildAppointmentsDates(),



      ],);
}

  Widget _buildStatusCard(String preg, bool isPregnant) {
    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: PrimaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              isPregnant ? Icons.child_care : Icons.healing,
              size: 40,
              color: White,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pregnancy Status'.tr,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: White,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    // isPregnant ? 'Pregnant'.tr : 'Not Pregnant'.tr,
                    preg.tr,
                    style:const TextStyle(fontSize: 16, color: White),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String summary) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.summarize, color: PrimaryColor),
                const SizedBox(width: 8),
                Text(
                  'Summary'.tr,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: PrimaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              summary,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentsDates() {
    // if (dates.isEmpty) {
    //   return Card(
    //     elevation: 4,
    //     child: Padding(
    //       padding: const EdgeInsets.all(16),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Row(
    //             children: [
    //               Icon(Icons.calendar_month, color: PrimaryColor),
    //               const SizedBox(width: 8),
    //               Text(
    //                 'Upcoming Actions'.tr,
    //                 style: TextStyle(
    //                   fontSize: 18,
    //                   fontWeight: FontWeight.bold,
    //                   color: PrimaryColor,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           const SizedBox(height: 16),
    //           Text('No appointments scheduled'.tr),
    //         ],
    //       ),
    //     ),
    //   );
    // }

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_month, color: PrimaryColor),
                const SizedBox(width: 8),
                Text(
                  'Upcoming Actions'.tr,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: PrimaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),


            // ...dates.entries.map((entry) {
            //   return Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         entry.key,
            //         style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //           color: PrimaryColor,
            //         ),
            //       ),



            //       const SizedBox(height: 8),
            //       GetBuilder<AppointmentController>(
            //         init: AppointmentController(),

            //         builder: (controller) =>  Wrap(
            //           spacing: 8,
            //           runSpacing: 8,
            //           children: entry.value.map((dateStr) {
            //             DateTime? date;
            //             try {
            //               date = DateTime.parse(dateStr);
            //               print(date.compareTo(DateTime.now()));
            //             } catch (e) {
            //               print('Error parsing date: $dateStr');
            //               return const SizedBox.shrink();
            //             }
                        
            //             return 
            //             Card(
            //                 elevation: 1,
            //                 shape: const Border(
            //                   left: BorderSide(
            //                     color: true
            //                         ? Colors.green
            //                         : Colors.redAccent,
            //                     width: 4,
            //                   ),
            //                 ),
            //                 child: 
                            
                            
            //                 InkWell(
            //                   highlightColor: Colors.green.withOpacity(0.1),
            //                   splashColor: Colors.green.withOpacity(0.8),
            //                   onTap: () => {},
            //                   child: Padding(
            //                     padding: const EdgeInsets.only(
            //                         top: 20, left: 10, right: 20, bottom: 20),
            //                     child: Row(
            //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                       children: [
            //                         Column(
            //                           children: <Widget>[
            //                             // Text(
            //                             //   DateFormat('dd-MM-yyyy')
            //                             //       .format(DateTime.parse(
            //                             //           appointment['appointment_date']))
            //                             //       .toString(),
            //                             //   style: TextStyle(
            //                             //     color: Colors.green,
            //                             //     fontSize: 18,
            //                             //     fontWeight: FontWeight.w700,
            //                             //   ),
            //                             // ),
            //                             Text(
            //                               DateFormat('MMM d').format(date),
            //                               style: TextStyle(
            //                                 color: Colors.green,
            //                                 fontSize: 18,
            //                                 fontWeight: FontWeight.w700,
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                         // Flexible(
            //                         //   child: Column(
            //                         //     crossAxisAlignment: CrossAxisAlignment.start,
            //                         //     children: <Widget>[
            //                         //       Text(
            //                         //         "Appointment Status".tr,
            //                         //         style: TextStyle(
            //                         //           fontSize: 18,
            //                         //         ),
            //                         //       ),
            //                         //       SizedBox(height: 6.0),
            //                         //       Text(
            //                         //         'status',
            //                         //         style: TextStyle(
            //                         //           fontWeight: FontWeight.bold,
            //                         //           color:
            //                         //               true
            //                         //                   ? Colors.orange
            //                         //                   : Colors.redAccent,
            //                         //         ),
            //                         //       ),
            //                         //     ],
            //                         //   ),
            //                         // ),
            //                     const SizedBox(width: 24),           
                    
            //                     if(date.compareTo(DateTime.now())<1) Container(child: Text("Date Passed"),) else
            //                     Expanded(
            //                     child: Center(
            //                       child: ElevatedButton(
            //                         onPressed: () {
            //                           controller.selDate = date;
            //                           controller.dateController.text = DateFormat('dd-MM-yyyy').format(date as DateTime);
            //                           Get.to(Appointment());
            //                         },
            //                         style: ElevatedButton.styleFrom(
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(8),
            //         ),
            //         padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            //                         ),
            //                         child: Text(
            //         "Book Appointment".tr,
            //         style: const TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.w500,
            //         ),
            //                         ),
            //                       ),
            //                     ),
            //                   ),
                                  
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               );
                        
                        
                        
                    
            //           }).toList(),
            //         ),
            //       ),
            //       const SizedBox(height: 16),
            //     ],
            //   );
            // }).toList(),
          
          
          
          ],
        ),
      ),
    );
  }

