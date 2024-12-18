
import 'package:allobaby/API/authAPI.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Config/OurFirebase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:permission_handler/permission_handler.dart';

class Consultation extends StatelessWidget {

  dynamic data;
  Consultation({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(
          "View Appointment",
          style: TextStyle(color: Black),
        ),

        
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              margin: EdgeInsets.only(bottom: 8),
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dr. ${data["doctor"]["name"]}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Text(
                        "Date : ${data["appointment_date"]}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Time : ${data["start_time"]}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Status : ${data["status"]}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Diagnosis Desc : ${data["reason"]}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                    ],
                  )),
            ),
            
            

                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    margin: EdgeInsets.only(bottom: 8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      splashColor: PrimaryColor,
                      onTap: () async {
                       await Permission.microphone.request();
                       await Permission.camera.request();

                        
                        if (await Permission.camera.isGranted &&
                        await Permission.microphone.isGranted
                            ) {
                              print("Call Triggered");
                              print(data);
                              String myid = localStorage.getItem("uid")!;
                              await OurFirebase.createCall((data["doctor"]["uid"]).toString(),myid,"Patient");
                            }
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/General/avatar.png",
                                scale: 4,
                              ),
                              SizedBox(
                                width: 18,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Connect with Doctor".tr,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Video Consultation".tr,
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}