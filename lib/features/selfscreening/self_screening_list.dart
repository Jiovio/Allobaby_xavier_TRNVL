import 'package:allobaby/API/Requests/SelfScreeningAPI.dart';
import 'package:allobaby/Screens/Home/Screening/Controllers/SelfScreeningController.dart';
import 'package:allobaby/features/selfscreening/details_self_screening.dart';
import 'package:allobaby/features/selfscreening/model/self_screening_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SelfScreeningList extends StatefulWidget {
  const SelfScreeningList({super.key});

  @override
  State<SelfScreeningList> createState() => _SelfScreeningListState();
}

class _SelfScreeningListState extends State<SelfScreeningList> {



      bool loading = true;




    List<SelfScreeningModel> data = [
    ];


        Future<void> getData() async {

      final req = await SelfscreeningApi.getHistory(1, 10);

      data = [...data, ...SelfScreeningModel.fromJsonList(req.items)];

      print(data);

      loading = false;

      setState(() {
        
      });

    }

    Future<void> refreshData() async {

            final req = await SelfscreeningApi.getHistory(1, 10);

      data = SelfScreeningModel.fromJsonList(req.items);
    }


    @override
    void initState(){
      super.initState();

      getData();
    }

Selfscreeningcontroller controller = Get.find<Selfscreeningcontroller>();


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          "History",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),


        // actions: [

        //         Container(
        //           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        //           decoration: BoxDecoration(
        //             color: Theme.of(context).primaryColor.withOpacity(0.15),
        //             borderRadius: BorderRadius.circular(20),
        //             border: Border.all(
        //               color: Theme.of(context).primaryColor.withOpacity(0.3),
        //               width: 1.5,
        //             ),
        //           ),
        //           child: Row(
        //             children: [
        //               Icon(
        //                 Icons.date_range_rounded,
        //                 size: 16,
        //                 color: Theme.of(context).primaryColor,
        //               ),
        //               const SizedBox(width: 6),
        //               Text(
        //                 "Sort by date",
        //                 style: TextStyle(
        //                   color: Theme.of(context).primaryColor,
        //                   fontWeight: FontWeight.w600,
        //                   fontSize: 12,
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
              
        //   SizedBox(width: 20,)

        // ],
      
      
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,


        child: 
        
        loading ? const Center(child: CircularProgressIndicator(),) :
        
        
        data.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.medical_information_outlined,
                      size: 60,
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "No screenings available",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Your health records will appear here",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final item = data[index];
                  final createdDate = item.created;
                  final formattedDate = DateFormat('dd MMM yyyy').format(createdDate!);
                  final formattedTime = DateFormat('hh:mm a').format(createdDate);
                  
                  // Count completed tests
                  int completedTests = 0;
                  int totalTests = 7; // Total number of possible tests
                  
                  if (item.params.containsKey("symptoms")) completedTests++;
                  if (item.params.containsKey("vitals")) completedTests++;
                  if (item.hemoglobinId != null) completedTests++;
                  if (item.urineTestId != null) completedTests++;
                  if (item.glucoseId != null) completedTests++;
                  if (item.fetalTestId != null) completedTests++;
                  if (item.ultrasoundId != null) completedTests++;
                  
                  double progress = completedTests / totalTests;
            
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          blurRadius: 12,
                          spreadRadius: 1,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        width: 1.5,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () async {
                          controller.setSelfScreeningData(item);
                          
                         await  Get.to(() => SelfScreeningDetails(data: item));

                         setState(() {
                           
                         });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.medical_services_rounded,
                                      color: Theme.of(context).primaryColor,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Screening Record",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context).primaryColor,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today_rounded,
                                              size: 14,
                                              // color: Colors.grey[600],
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              formattedDate,
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Icon(
                                              Icons.access_time_rounded,
                                              size: 14,
                                              color: Colors.grey[600],
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              formattedTime,
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Text(
                                      "$completedTests/$totalTests",
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 8,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Container(
                                      height: 8,
                                      width: MediaQuery.of(context).size.width * progress * 0.8,
                                      decoration: BoxDecoration(
                                        color: getProgressColor(context, progress),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 18),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey[200]!,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    enhancedIcon("assets/labReports/symptoms.png", "Symptoms", item.params.containsKey("symptoms"), context),
                                    enhancedIcon("assets/labReports/vitals.png", "Vitals", item.params.containsKey("vitals"), context),
                                    enhancedIcon("assets/labReports/hemoglobin.png", "Hemoglobin", item.hemoglobinId!=null, context),
                                    enhancedIcon("assets/labReports/urinetest.png", "Urine", item.urineTestId!=null, context),
                                    enhancedIcon("assets/labReports/glucose.png", "Glucose", item.glucoseId!=null, context),
                                    enhancedIcon("assets/labReports/fetalmon.png", "Fetal", item.fetalTestId!=null, context),
                                    enhancedIcon("assets/labReports/ultrasound.png", "Ultrasound", item.ultrasoundId!=null, context),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Theme.of(context).primaryColor.withOpacity(0.3),
                                          blurRadius: 8,
                                          spreadRadius: 0,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.visibility_rounded,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          "View Details",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget enhancedIcon(String img, String label, bool id, BuildContext context) {
    final bool isCompleted = id;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isCompleted 
                    ? Theme.of(context).primaryColor.withOpacity(0.15)
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: isCompleted
                    ? Border.all(
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                        width: 1.5,
                      )
                    : null,
              ),
              child: Image.asset(
                img,
                height: 20,
                width: 20,
                // color: isCompleted ? Theme.of(context).primaryColor : Colors.grey,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.medical_services_outlined,
                  size: 20,
                  // color: isCompleted ? Theme.of(context).primaryColor : Colors.grey,
                ),
              ),
            ),
            if (isCompleted)
              Positioned(
                right: -2,
                top: -2,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.green,
                          blurRadius: 4,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: isCompleted ? FontWeight.w600 : FontWeight.normal,
            color: isCompleted ? Theme.of(context).primaryColor : Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Color getProgressColor(BuildContext context, double progress) {
    if (progress < 0.3) return Colors.redAccent;
    if (progress < 0.7) return Colors.orangeAccent;
    return Colors.greenAccent.shade700;
  }
}