

import 'package:allobaby/API/Requests/ReportAPI.dart';
import 'package:allobaby/API/Requests/SelfScreeningAPI.dart';
import 'package:allobaby/features/Report/ViewReport.dart';
import 'package:flutter/material.dart';

class ScreeningReportLoader extends StatelessWidget {
  final int id;
  const ScreeningReportLoader({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(future: SelfscreeningApi.getAppointmentSelfScreeningData(id), 
      builder:(context, snapshot) {
        
        if(snapshot.hasData){
      
          final data = snapshot.data!;

          print(data);
      
      
          if(data.success){
      
            return ViewReport(reportDetails: data.item);
      
          }else{
      
      
            Text("Report Not Found !");
      
          }
      
        }
      
      
        return const Center(child: CircularProgressIndicator(),);
      
      
      },),
    );
  }
}