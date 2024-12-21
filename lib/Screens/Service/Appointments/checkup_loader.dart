

import 'package:allobaby/API/Requests/ReportAPI.dart';
import 'package:allobaby/Screens/Home/Checkup/CheckUpReport.dart';
import 'package:flutter/material.dart';

class Checkupreportloader extends StatelessWidget {
  int id;
  String status;
  Checkupreportloader({super.key, required this.id, required this.status});

  @override
  Widget build(BuildContext context) {
    return 

    Scaffold(
      body: 
      status=="Cancelled"?
    Center(child: Text("Appointment is Cancelled.")) :
    // status!="Completed"?
    // Center(child: Text("Waiting for Doctor Input...")) :
    FutureBuilder(future: 
    Reportapi.getAppointmentForReport(id.toString()), 
    builder:(context, snapshot) {

      if(snapshot.hasData){
      final data = snapshot.data;
      print("--------------------------------------------------------");
      print(data);



      return CheckUpReport(data: data);
      // return Scaffold();

      }
      return CircularProgressIndicator();
      
      
          },));
  }
}