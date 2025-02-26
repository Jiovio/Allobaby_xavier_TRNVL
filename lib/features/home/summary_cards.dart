import 'package:allobaby/API/Requests/CacheAPI.dart';
import 'package:allobaby/API/local/Storage.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/AppointmentController.dart';
import 'package:allobaby/Controller/MainController.dart';
import 'package:allobaby/Screens/Service/Appointment.dart';
import 'package:allobaby/features/home/summary/summaryfunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';


class HomePageSummary extends StatefulWidget {
   HomePageSummary({super.key});

  @override
  State<HomePageSummary> createState() => _HomePageSummaryState();
}

class _HomePageSummaryState extends State<HomePageSummary> {
  final Maincontroller controller = Get.find<Maincontroller>();


  String summary = "No summary available";

  bool loading = true;
  

  void fetchSummary() async {

    String cachekey = "${Storage.getUserUID().toString()}-${DateFormat("dd-MM-yyyy").format(DateTime.now())}-homepagesummary-${controller.pregnancyStatus.text}";

    final req = await Cacheapi.get(cachekey);

    print(req.detail);

    if(req.networkError){
      // network error
    }else{
      if(req.success){
        if(req.item!=null){
          print(req.item);
          summary = req.item["summary"];
        }else{

            summary = await  generateHomePageSummary(controller.pregnancyStatus.text, 
            controller.lmpDate.text, 
            controller.edDate.text, 
            controller.deliveryDate.text,
            controller.averageLengthOfCycles.text,
            controller.cdaysPassed,
            controller
            );

            await Cacheapi.create(cachekey, {"summary": summary});
        }
      }else{
        print(req.detail);
      }

    }



    setState(() {
      loading = false;
    });
  }


  @override
  void initState(){
    super.initState();

    fetchSummary();
  }
  @override
  Widget build(BuildContext context) {
    return   
  
    
    Column(
    children: [
      const SizedBox(height: 14),
       _buildStatusCard(controller.pregnancyStatus.text,true),
      Skeletonizer(
        enabled: loading,
        child: _buildSummaryCard(summary)),
      const SizedBox(height: 14),
      // _buildAppointmentsDates(),
    ],
      );
  }
}



Widget _buildStatusCard(String preg, bool isPregnant) {
  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [PrimaryColor, PrimaryColor.withOpacity(0.85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: PrimaryColor.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: White.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isPregnant ? Icons.child_care : Icons.child_friendly,
              size: 28,
              color: White,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pregnancy Status'.tr,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: White,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  // decoration: BoxDecoration(
                  //   color: White.withOpacity(0.15),
                  //   borderRadius: BorderRadius.circular(14),
                  // ),
                  child: Text(
                    preg.tr,
                    style: const TextStyle(
                      fontSize: 14, 
                      color: White,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: PrimaryColor.withOpacity(0.1), width: 1),
    ),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: PrimaryColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.summarize, color: PrimaryColor, size: 20),
              ),
              const SizedBox(width: 10),
              Text(
                'Summary'.tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: PrimaryColor,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.04),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              summary,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildAppointmentsDates() {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: PrimaryColor.withOpacity(0.1), width: 1),
    ),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: PrimaryColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.calendar_month, color: PrimaryColor, size: 20),
              ),
              const SizedBox(width: 10),
              Text(
                'Upcoming Actions'.tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: PrimaryColor,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
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

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.04),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.grey.shade500,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Text(
                  'No appointments scheduled'.tr,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          // ...dates.entries.map((entry) {
          //   return Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.only(top: 12, bottom: 6, left: 2),
          //         child: Text(
          //           entry.key,
          //           style: TextStyle(
          //             fontSize: 15,
          //             fontWeight: FontWeight.bold,
          //             color: PrimaryColor,
          //           ),
          //         ),
          //       ),

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
          //                 margin: const EdgeInsets.only(bottom: 8),
          //                 shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(10),
          //                   side: BorderSide(
          //                     color: date.compareTo(DateTime.now()) < 1 ? Colors.grey.withOpacity(0.2) : Colors.green.withOpacity(0.7),
          //                     width: 1,
          //                   ),
          //                 ),
          //                 child: 
                          
          //                 InkWell(
          //                   borderRadius: BorderRadius.circular(10),
          //                   highlightColor: Colors.green.withOpacity(0.05),
          //                   splashColor: Colors.green.withOpacity(0.1),
          //                   onTap: () => {},
          //                   child: Padding(
          //                     padding: const EdgeInsets.symmetric(
          //                         vertical: 10, horizontal: 12),
          //                     child: Row(
          //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         Container(
          //                           padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          //                           decoration: BoxDecoration(
          //                             color: Colors.green.withOpacity(0.08),
          //                             borderRadius: BorderRadius.circular(8),
          //                           ),
          //                           child: Column(
          //                             children: <Widget>[
          //                               Text(
          //                                 DateFormat('MMM').format(date),
          //                                 style: TextStyle(
          //                                   color: Colors.green.shade700,
          //                                   fontSize: 12,
          //                                   fontWeight: FontWeight.w500,
          //                                 ),
          //                               ),
          //                               const SizedBox(height: 2),
          //                               Text(
          //                                 DateFormat('d').format(date),
          //                                 style: TextStyle(
          //                                   color: Colors.green.shade700,
          //                                   fontSize: 18,
          //                                   fontWeight: FontWeight.w700,
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                         ),
                                  
          //                     const SizedBox(width: 12),           
                  
          //                     if(date.compareTo(DateTime.now())<1) 
          //                       Container(
          //                         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          //                         decoration: BoxDecoration(
          //                           color: Colors.grey.withOpacity(0.08),
          //                           borderRadius: BorderRadius.circular(6),
          //                         ),
          //                         child: Text(
          //                           "Date Passed",
          //                           style: TextStyle(
          //                             fontSize: 13,
          //                             color: Colors.grey.shade600,
          //                             fontWeight: FontWeight.w500,
          //                           ),
          //                         ),
          //                       ) 
          //                     else
          //                     Expanded(
          //                       child: Center(
          //                         child: ElevatedButton(
          //                           onPressed: () {
          //                             controller.selDate = date;
          //                             controller.dateController.text = DateFormat('dd-MM-yyyy').format(date as DateTime);
          //                             Get.to(Appointment());
          //                           },
          //                           style: ElevatedButton.styleFrom(
          //                             backgroundColor: PrimaryColor,
          //                             foregroundColor: White,
          //                             shape: RoundedRectangleBorder(
          //                               borderRadius: BorderRadius.circular(8),
          //                             ),
          //                             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //                             elevation: 1,
          //                             minimumSize: const Size(10, 34),
          //                           ),
          //                           child: Text(
          //                             "Book Appointment".tr,
          //                             style: const TextStyle(
          //                               fontSize: 13,
          //                               fontWeight: FontWeight.w600,
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                     ),
                                
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               );
          //           }).toList(),
          //         ),
          //       ),
          //       const SizedBox(height: 8),
          //     ],
          //   );
          // }).toList(),
        ],
      ),
    ),
  );
}