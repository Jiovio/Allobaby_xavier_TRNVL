

import 'package:allobaby/API/Requests/ReportAPI.dart';
import 'package:allobaby/API/Requests/SelfScreeningAPI.dart';
import 'package:allobaby/features/Report/ViewReport.dart';
import 'package:allobaby/features/selfscreening/model/self_screening_model.dart';
import 'package:flutter/material.dart';

class ScreeningReportLoader extends StatelessWidget {
  final int? id;
   bool appointment = false;

   ScreeningReportLoader({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      FutureBuilder(future: 
      Reportapi.getReportData(id!), 
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