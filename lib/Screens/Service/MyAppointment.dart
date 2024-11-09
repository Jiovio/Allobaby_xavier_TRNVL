import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Config/OurFirebase.dart';
import 'package:allobaby/Screens/Home/Checkup/CheckUpReport.dart';
import 'package:allobaby/Screens/Service/Appointment.dart';
import 'package:allobaby/Screens/Service/Appointments/AIAppointmentPage.dart';
import 'package:allobaby/Screens/Service/Appointments/CurrentAppointment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppointment extends StatelessWidget {
  const MyAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    DefaultTabController(
        length: 2,
        child:
    Scaffold(
              appBar: AppBar(
            elevation: 0,
            title: Text(
              " Appointments".tr,
              style: TextStyle(color: Black),
            ),


            bottom: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.date_range),text: "My Appointments",),
            Tab(icon: Icon(Icons.data_exploration_rounded),text: "AI Recommendation"),
          ],
        ),
            
            ),


            body: 
            const TabBarView(
            children: [
              Currentappointment(),
              AIAppointmentPage(),
            ])

    ));
  }
}