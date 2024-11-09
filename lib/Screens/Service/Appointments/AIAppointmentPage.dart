import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Config/OurFirebase.dart';
import 'package:allobaby/Controller/AppointmentController.dart';
import 'package:allobaby/Screens/Service/Appointment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';

class AIAppointmentPage extends StatefulWidget {
  const AIAppointmentPage({Key? key}) : super(key: key);

  @override
  State<AIAppointmentPage> createState() => _AIAppointmentPageState();
}

class _AIAppointmentPageState extends State<AIAppointmentPage> {

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

                        floatingActionButton: IconButton(icon:Icon(Icons.replay_circle_filled,size: 70,),
            onPressed: () async {
              setState(() {
                loading = true;
              });
          await OurFirebase.getAIAppointments(true);

            setState(() {
              loading = false;
            });
            },),



      body: 
      loading ?
      const Center(child: CircularProgressIndicator(),)
      : 
      FutureBuilder<Map<String, dynamic>>(
        future: OurFirebase.getAIAppointments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: PrimaryColor),
                  const SizedBox(height: 16),
                  Text(
                    'Analyzing your health data...',
                    style: TextStyle(
                      color: PrimaryColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${snapshot.error}\nPlease try again later.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      (context as Element).markNeedsBuild();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text('No data available'),
            );
          }

          final appointments = snapshot.data!;
          
          // Safely handle the dates map
          Map<String, List<String>> parsedDates = {};
          if (appointments['dates'] is Map) {
            final datesMap = appointments['dates'] as Map<String, dynamic>;
            datesMap.forEach((key, value) {
              if (value is List) {
                parsedDates[key] = value.map((e) => e.toString()).toList();
              }
            });
          }

          return RefreshIndicator(
            onRefresh: () async {
              (context as Element).markNeedsBuild();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatusCard(appointments['is_pregnant'] ?? false),
                    const SizedBox(height: 20),
                    _buildSummaryCard(appointments['summary']?.toString() ?? 'No summary available'),
                    const SizedBox(height: 20),
                    _buildAppointmentsDates(parsedDates),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusCard(bool isPregnant) {
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
                 const Text(
                    'Pregnancy Status',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: White,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isPregnant ? 'Pregnant' : 'Not Pregnant',
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
                  'Summary',
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

  Widget _buildAppointmentsDates(Map<String, List<String>> dates) {
    if (dates.isEmpty) {
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
                    'Upcoming Appointments',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: PrimaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('No appointments scheduled'),
            ],
          ),
        ),
      );
    }

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
                  'Upcoming Appointments',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: PrimaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...dates.entries.map((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.key,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: PrimaryColor,
                    ),
                  ),



                  const SizedBox(height: 8),
                  GetBuilder<AppointmentController>(
                    init: AppointmentController(),

                    builder: (controller) =>  Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: entry.value.map((dateStr) {
                        DateTime? date;
                        try {
                          date = DateTime.parse(dateStr);
                        } catch (e) {
                          print('Error parsing date: $dateStr');
                          return const SizedBox.shrink();
                        }
                        
                        return 
                        Card(
                            elevation: 1,
                            shape: const Border(
                              left: BorderSide(
                                color: true
                                    ? Colors.green
                                    : Colors.redAccent,
                                width: 4,
                              ),
                            ),
                            child: 
                            
                            
                            InkWell(
                              highlightColor: Colors.green.withOpacity(0.1),
                              splashColor: Colors.green.withOpacity(0.8),
                              onTap: () => {},
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 20, bottom: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: <Widget>[
                                        // Text(
                                        //   DateFormat('dd-MM-yyyy')
                                        //       .format(DateTime.parse(
                                        //           appointment['appointment_date']))
                                        //       .toString(),
                                        //   style: TextStyle(
                                        //     color: Colors.green,
                                        //     fontSize: 18,
                                        //     fontWeight: FontWeight.w700,
                                        //   ),
                                        // ),
                                        Text(
                                          DateFormat('MMM d').format(date),
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Flexible(
                                    //   child: Column(
                                    //     crossAxisAlignment: CrossAxisAlignment.start,
                                    //     children: <Widget>[
                                    //       Text(
                                    //         "Appointment Status".tr,
                                    //         style: TextStyle(
                                    //           fontSize: 18,
                                    //         ),
                                    //       ),
                                    //       SizedBox(height: 6.0),
                                    //       Text(
                                    //         'status',
                                    //         style: TextStyle(
                                    //           fontWeight: FontWeight.bold,
                                    //           color:
                                    //               true
                                    //                   ? Colors.orange
                                    //                   : Colors.redAccent,
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                const SizedBox(width: 24),           
                    
                    
                                Expanded(
                                child: Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      controller.selDate = date;
                                      controller.dateController.text = DateFormat('dd-MM-yyyy').format(date as DateTime);
                                      Get.to(Appointment());
                                    },
                                    style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                    ),
                                    child: Text(
                    "Book Appointment",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                                    ),
                                  ),
                                ),
                              ),
                                  
                                  ],
                                ),
                              ),
                            ),
                          );
                        
                        
                        
                    
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

