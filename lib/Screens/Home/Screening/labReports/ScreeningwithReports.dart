
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Screens/Home/Screening/Controllers/SelfScreeningController.dart';
import 'package:allobaby/Screens/Home/Screening/SelfScreening.dart';
import 'package:allobaby/Screens/Home/Screening/SymptomsScreen.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/Vitals.dart';
import 'package:allobaby/Screens/Home/Screening/labReports/Tests/FetalMonitoring.dart';
import 'package:allobaby/Screens/Home/Screening/labReports/Tests/Glucose.dart';
import 'package:allobaby/Screens/Home/Screening/labReports/Tests/Hemoglobin.dart';
import 'package:allobaby/Screens/Home/Screening/labReports/Tests/UltraSound.dart';
import 'package:allobaby/Screens/Home/Screening/labReports/Tests/Urine.dart';
import 'package:allobaby/db/dbHelper.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ScreeningWithReports extends StatefulWidget {
   ScreeningWithReports({super.key});

  @override
  State<ScreeningWithReports> createState() => _ScreeningWithReportsState();
}

class _ScreeningWithReportsState extends State<ScreeningWithReports> {

  List<LabreportOptions> ls = [
  LabreportOptions("Symptoms",SelfScreening(initPage: 0,),"hemoglobin.png"),
  LabreportOptions("Vital Test",SelfScreening(initPage: 1,),"hemoglobin.png"),
  LabreportOptions("Hemoglobin Test",SelfScreening(initPage: 2,),"hemoglobin.png"),
  LabreportOptions("Urine Test",SelfScreening(initPage: 3,),"urinetest.png"),
  LabreportOptions("Glucose Test",SelfScreening(initPage: 4,),"glucose.png"),
  LabreportOptions("Fetal Monitoring",SelfScreening(initPage: 5,),"fetalmon.png"),
  LabreportOptions("UltraSound Test",SelfScreening(initPage: 6,),"ultrasound.png")
  ];

  Selfscreeningcontroller sc = Get.put(Selfscreeningcontroller());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Self Screening"),
      ),
      
      floatingActionButton: FloatingActionButton(onPressed: getReports,
      
      ),

      body: SingleChildScrollView(
        child: Container(
          
          padding: EdgeInsets.only(top: 40, left: 20, right: 20),
          width: double.infinity,
          child: Column(children: [
            Image.asset(
              "assets/reportsicon.png",
              scale: 1,
              width: 100,
              height: 100,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Let's begin the test",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
        
      
        
        
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: ls.length,
              shrinkWrap: true,
              itemBuilder:(context, index) {
                String title = ls[index].x;
                Widget sc = ls[index].screen;
                String img = ls[index].img;

                return Column(
                  children: [
                    Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: Black)),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(8.0),
                        highlightColor: accentColor.withOpacity(0.1),
                        splashColor: accentColor.withOpacity(0.8),
                        onTap: () => 
                        Get.to(sc ,
                            transition: Transition.rightToLeft),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: ListTile(
                            leading: Image.asset(
                              "assets/labReports/$img",
                              scale: 12,
                            ),
                            title: Text(
                              title,
                              style: TextStyle(fontSize: 18),
                            ),
                            trailing:
                                Icon(Icons.arrow_forward_ios_rounded, color: Black),
                          ),
                        ))),
                        
                        SizedBox(
              height: 20,
            ),
                  ],
                );
           
              }),    
          ]),
        ),
      ),
    );
  }

  Widget ScreeningItem (String title, Widget sc,String img) {
    return Column(
      children: [
                          Card(
                            
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Black)),
                  child: InkWell(
                      borderRadius: BorderRadius.circular(8.0),
                      highlightColor: accentColor.withOpacity(0.1),
                      splashColor: accentColor.withOpacity(0.8),
                      onTap: () => 
                      Get.to(sc ,
                          transition: Transition.rightToLeft),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: ListTile(
                          leading: Image.asset(
                            "assets/labReports/$img",
                            scale: 12,
                          ),
                          title: Text(
                            title,
                            style: TextStyle(fontSize: 18),
                          ),
                          trailing:
                              Icon(Icons.arrow_forward_ios_rounded, color: Black),
                        ),
                      ))),
                      
                      SizedBox(
            height: 20,
          ),
      ],
    );
  }

}

class LabreportOptions {

  LabreportOptions(this.x, this.screen,this.img);
  String x; 
  Widget screen;
  String img;
}