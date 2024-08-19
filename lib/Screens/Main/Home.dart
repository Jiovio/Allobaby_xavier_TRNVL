import 'package:allobaby/Components/appbar.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Screens/Home/Awareness/Awareness.dart';
import 'package:allobaby/Screens/Home/Checkup/CheckUp.dart';
import 'package:allobaby/Screens/Home/Prescription/Prescription.dart';
import 'package:allobaby/Screens/Home/Report/Report.dart';
import 'package:allobaby/Screens/Home/Screening/SelfScreening.dart';
import 'package:allobaby/Screens/Home/Screening/SymptomsScreen.dart';
import 'package:allobaby/Screens/Home/Screening/labReports/ScreeningwithReports.dart';
import 'package:allobaby/Screens/Home/Screening/labReports/Tests/Hemoglobin.dart';
import 'package:allobaby/Screens/Service/Appointment.dart';
import 'package:allobaby/Screens/Service/MyAppointment.dart';
import 'package:allobaby/Screens/Signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "AlloBaby", context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18)),
              ),

              child: Column(

                children: [
                  SizedBox(
                    height: 30,
                  ),


                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 20.0),
                    child: Row(
                      
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          // onTap: () => Get.to(() => HealthProfileDetails(),
                          //     transition: Transition.rightToLeft),
                          child: SizedBox(


                            child: SizedBox(
                              child: CircularPercentIndicator(
                                
                                      circularStrokeCap: CircularStrokeCap.round,
                                      linearGradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: <Color>[
                                          PrimaryColor.withOpacity(0.8),
                                          PrimaryColor,
                                        ],
                                      ),
                                      backgroundColor: accentColor.withOpacity(0.3),
                                      radius: 80.0,
                                      lineWidth: 12.0,
                                      percent: 1,
                              
                                      center: true
                                          ? Text(
                                              "Day ${(280 - 80)}",
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            )
                                          : Text(
                                              "Not yet started",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700),
                                            )
                                            ),
                            ),
                          ),
                        ),


                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(

                            child: Row(children: [
                                                                Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: Colors.green),
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 16,
                                      color: Black,
                                    ),
                                  ),

                                  SizedBox(width: 8,),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                             Text(
                                            "NORMAL",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: PrimaryColor,
                                                fontWeight: FontWeight.w700),
                                          ),
                                           Text("Health Status",
                                          style: TextStyle(
                                              color: Black.withOpacity(0.6),
                                              fontSize: 14)),
                                  ],)
                            ],),
                          )
                        
                                ,InkWell(

                            child: Row(children: [
                                                                Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: Colors.green),
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 16,
                                      color: Black,
                                    ),
                                  ),

                                  SizedBox(width: 8,),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                             Text(
                                            "2021-11-20",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: PrimaryColor,
                                                fontWeight: FontWeight.w700),
                                          ),
                                                                                Text("Last Screened",
                                          style: TextStyle(
                                              color: Black.withOpacity(0.6),
                                              fontSize: 14)),
                                  ],)
                            ],),
                          ),


                          InkWell(

                            child: Row(children: [
                                                                Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: Colors.green),
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 16,
                                      color: Black,
                                    ),
                                  ),

                                  SizedBox(width: 8,),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                             Text(
                                            "GOLD",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: PrimaryColor,
                                                fontWeight: FontWeight.w700),
                                          ),
                                                                                Text("Subscription Plan",
                                          style: TextStyle(
                                              color: Black.withOpacity(0.6),
                                              fontSize: 14)),
                                  ],)
                            ],),
                          )
                        
                        ],
                      )
                      ],
                    ),
                  
                  ),
                



                ],

              ),

            ),

                        SizedBox(
              height: 8,
            ),

                        Container(
              height: 132.0,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  children: [
                    categories("Awareness",
                        'assets/Homescreen/myawernessnew.png', 
                        Awareness()
                        // Signin()
                        ),

                        categories("Appointments",
                        'assets/Homescreen/appointment.png', 
                        MyAppointment()
                        // Signin()
                        ),


                    categories("Screening", 'assets/Homescreen/virus.png',
                        // SelfScreening()
                        // Hemoglobin()
                        ScreeningWithReports()
                        ),
                    categories(
                        "Report",
                        'assets/Homescreen/medical_report.png',
                        // Report(
                        //   patientId:
                        //       mainScreenController.patientDetails.length == 0
                        //           ? ""
                        //           : mainScreenController
                        //               .patientDetails[0].fireBaseID,
                        // )
                        Report()
                        
                        ),

                        categories(
                        "Prescription",
                        'assets/Homescreen/prescription.png',
                        // Report(
                        //   patientId:
                        //       mainScreenController.patientDetails.length == 0
                        //           ? ""
                        //           : mainScreenController
                        //               .patientDetails[0].fireBaseID,
                        // )
                        Prescription()
                        
                        ),
                    categories("Checkup", 'assets/Homescreen/mycheckupnew.png',
                        // CheckUp()
                        CheckUp()
                        ),
                    // categories("Appointments", 'assets/Homescreen/mycheckupnew.png', Appointments()) ,
                  ]),
            ),

                        SizedBox(
              height: 20,
            ),

            Padding(padding: const EdgeInsets.only(left: 14.0, right: 14.0),
            child: Column(children: [

              Center(
                            child: Text(
                              "No News Feed".tr,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ),
                                                                  Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Row(
                                                children: [
                                                 const Flexible(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Healthy Pregnant Woman",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text("Pregnancy is the time during which one or more offspring develops (gestates) inside a woman's uterus (womb).[4][13] A multiple pregnancy involves more than one offspring, such as with twins.[14]"),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 90,
                                                    width: 90,
                                                    child: Image.network(
                                                      "https://images.indianexpress.com/2023/05/pregnancy-1.jpg",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )


            ],),
            )

        ],),

        
      ),
    
    );
  }

  Card categories(String title, String image, Widget routes) {
  return Card(
    margin: EdgeInsets.only(left: 18, bottom: 5, top: 5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
      // side: BorderSide(color: PrimaryColor),
    ),
    child: InkWell(
      borderRadius: BorderRadius.circular(8.0),
      highlightColor: accentColor.withOpacity(0.1),
      splashColor: accentColor.withOpacity(0.8),
      onTap: () => Get.to(() => routes, transition: Transition.rightToLeft),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        width: 120,
        child: Padding(
          padding: EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                image,
                width: 60,
                height: 60,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 14),
              )
            ],
          ),
        ),
      ),
    ),
  );


  
}


}