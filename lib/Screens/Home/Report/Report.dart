


import 'package:allobaby/API/Requests/Userapi.dart';
import 'package:allobaby/API/authAPI.dart';
import 'package:allobaby/API/local/Storage.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Screens/Home/Prescription/addprescription.dart';
import 'package:allobaby/Screens/Home/Report/AddReport.dart';
import 'package:allobaby/features/Report/ViewReport.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';

class Report extends StatefulWidget {
   Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
     Future<List<dynamic>> getReports()  async {

      final id = await Storage.getUserID();

      List<dynamic> d = await getRequest("/report?user_id=${id.toString()}") ;

      print("Report $d");


      return d;
  }

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
                      Text("SCAN AND ADD REPORT".tr)
                    ],
                  ))),
  
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: getReports(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No reports found'));
                } else {
                  List<dynamic> reports = snapshot.data!;

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: reports.length,
                    itemBuilder: (context, index) {
                      var report = reports[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Black700, width: 1),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () async { 
                              print(report);
                              
                            await Get.to(
                              () => 
                              ViewReport(reportDetails: report),
                              transition: Transition.rightToLeft,
                            );


                            setState(() {
                              
                            });
                            
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CachedNetworkImage(
                                      imageUrl:  report['imageurl'] ?? "",
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, error, stackTrace) =>
                                          Container(
                                            height: 80,
                                            width: 80,
                                            color: Colors.grey[300],
                                            child: Icon(Icons.error),
                                          ),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          report['report_type'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          report['description']=="" ? "No description available".tr : report["description"],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}