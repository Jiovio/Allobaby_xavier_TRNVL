import 'package:allobaby/API/Requests/CacheAPI.dart';
import 'package:allobaby/API/Requests/Userapi.dart';
import 'package:allobaby/API/local/Storage.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/AppointmentController.dart';
import 'package:allobaby/Controller/MainController.dart';
import 'package:allobaby/Screens/AI/allobotModal.dart';
import 'package:allobaby/Screens/Main/BottomSheet/BottomQuestion.dart';
import 'package:allobaby/Screens/Service/Appointment.dart';
import 'package:allobaby/Screens/Service/MyAppointment.dart';
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
      _buildAppointmentsDates(controller, context),
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

Widget _buildAppointmentsDates(Maincontroller controller, BuildContext context) {
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
          

        GestureDetector(
          
          onTap: () {
            showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(12.0)),
                        ),
                        context: context,
                        builder: (BuildContext context) => Container(
                              height: Get.height / 2,
                              child:  
                              bottomQuestionSheet(context, 0),
                              // Text("Hi")
        
        
                            ));
          },
          
          child: 
        
        Obx(() => Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: controller.todayScreeningCompleted.value ? Colors.green.shade50 : Colors.red.shade50,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                controller.todayScreeningCompleted.value 
                    ? Icons.check_circle 
                    : Icons.warning_rounded,
                color: controller.todayScreeningCompleted.value 
                    ? Colors.green.shade700 
                    : Colors.red.shade700,
                size: 24,
              ),
              SizedBox(width: 12),
              Text(
                controller.todayScreeningCompleted.value
                    ? "Daily Screening Completed"
                    : "Daily Screening Not Completed",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: controller.todayScreeningCompleted.value 
                      ? Colors.green.shade700 
                      : Colors.red.shade700,
                ),
              ),
            ],
          ),
        )),),

        SizedBox(height: 20,),


        Container(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Upcoming Appointments",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      SizedBox(height: 15,),
      FutureBuilder(
        future: Userapi.getpendingappointmentsfordisplay(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          
          if (!snapshot.hasData || snapshot.data == null || snapshot.data!.length == 0) {
            return emptyAppointments();
          }
          
          final data = snapshot.data!;
          
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.length,
              separatorBuilder: (context, index) => Divider(height: 1),
              itemBuilder: (context, index) {
                // Format date from 2025-02-20 to 20-02-2025
                final originalDate = data[index]["appointment_date"];
                final formattedDate = formatDate(originalDate);
                
                return ListTile(
  

                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                    child: Icon(
                      Icons.calendar_today,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  title: Text(
                    formattedDate,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 16, color: Colors.grey),
                          SizedBox(width: 4),
                          Text("${data[index]["start_time"]} to ${data[index]["end_time"]}"),
                        ],
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () {
                    Get.to(()=> MyAppointment());
                  },
                );
              },
            ),
          );
        },
      ),
    ],
  ),
)




        ],
      ),
    ),
  );
}


emptyAppointments() {
  return           Container(
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
          );
}

String formatDate(String inputDate) {
  try {
    final parts = inputDate.split('-');
    if (parts.length == 3) {
      return "${parts[2]}-${parts[1]}-${parts[0]}";
    }
  } catch (e) {
    print("Error formatting date: $e");
  }
  return inputDate; // Return original if formatting fails
}