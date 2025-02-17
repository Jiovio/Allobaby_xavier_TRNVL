import 'dart:convert';
import 'dart:ffi';

import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Config/weeklysummary.dart';
import 'package:allobaby/Controller/MainController.dart';
import 'package:allobaby/Screens/Home/Screening/Controllers/SelfScreeningController.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/BMI.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/BloodGlucose.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/BloodPressure.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/BloodSaturation.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/HeartRate.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/HeartRateVariability.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/RespiratoryRate.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/Temperature.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/Vitals.dart';
import 'package:allobaby/Screens/Main/BottomSheet/BottomQuestion.dart';
import 'package:allobaby/db/dbHelper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';

class Healthprofile extends StatefulWidget {
 const Healthprofile({super.key});

  @override
  State<Healthprofile> createState() => _HealthprofileState();
}

class _HealthprofileState extends State<Healthprofile> {
  Maincontroller mc = Get.put(Maincontroller());

  DateTime? date;

  bool changed = false;


  @override
  void initState() {


  if(date==null){
    setState(() {
      date = DateTime.now();
    });
  }

  super.initState();
  }


  Selfscreeningcontroller cont = Get.put(Selfscreeningcontroller());

int calculateWeekDifference() {
  DateTime today = DateTime.now();
  DateTime oldDate = DateTime.parse(mc.lmpDate.text);

  int differenceInDays = today.difference(oldDate).inDays;
  int differenceInWeeks = (differenceInDays / 7).floor();

  return differenceInWeeks % 40;
}



  void goToVitals(context,int i) async {
        if (context.mounted){

        if(changed) return;
        
          await showDialog( 
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Update".tr),
                  content: 
                  Container(
                    child: vitals[i],
                  )
                  
                ));


            setState(() {
              
            });

        }

  }


  void openBottomSheet(int i) async {

      if(changed) return;


      await showModalBottomSheet(
      shape:const  RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(12.0)),
      ),
      context: context,
      builder: (BuildContext context) => Container(
            height: Get.height / 2,
            child:  
            bottomQuestionSheet(context, i),
          ));
          setState(() {
            
          });                            
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Black100,
      appBar: AppBar(
        title:const Text("Health Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                    Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              DateFormat('dd-MM-yy').format(date!),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            IconButton(
                                icon:const Icon(
                                  Icons.calendar_today_outlined,
                                ),
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime.now(),
                                  ).then((selectedDate) {


                                    print(selectedDate);
                                    if(selectedDate!=null){
                                    setState(() {
                                      if(selectedDate.month == DateTime.now().month && selectedDate.day == DateTime.now().day){
                                      date = selectedDate;
                                      changed = false;
                                      }else {
                                      date = selectedDate;
                                      changed = true;
                                      }
                                    });
                                    }

                                  });
                                }),
                       ],
                    ),
                    
                    
                const  SizedBox(
                  height: 10,
                ),

                mc.profile_pic==null?
                CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 36.0,
                    child: Image.asset("assets/General/avatar.png")):

                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                      child: CachedNetworkImage(imageUrl: mc.profile_pic as String,height: 74,width: 74,
                      
                      ),
                    ),
               const SizedBox(
                  height: 20,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.double_arrow),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              mc.healthStatus,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text("Health Status",
                                style: TextStyle(
                                    color: Black.withOpacity(0.6),
                                    fontSize: 14)),
                          ],
                        ),
                        Column(
                          children: [
                 
                            const Icon(Icons.double_arrow),
                     
                           const SizedBox(
                              height: 12,
                            ),
                            Text(mc.lastScreened==null?
                            "- - -": mc.lastScreened!,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                )),
                            SizedBox(
                              height: 8,
                            ),
                            Text("Last Screened",
                                style: TextStyle(
                                    color: Black.withOpacity(0.6),
                                    fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
               
               const SizedBox(
                  height: 8,
                ),
                 
                 if(mc.pregnancyStatus.text == "Iam pregnant" )
                 Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                // date!.day.toString(),
                                calculateWeekDifference().toString(),
                                style: TextStyle(fontSize: 26),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                
                                // monthNames[date!.month-1]
                                "Week",
                                
                                )
                            ],
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               const Text(
                                  "What's up this week ?",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                    weeklysummary[calculateWeekDifference()])
                              ],
                            ),
                          )
                        ],
                      )),
                ),


                // daily 
                if(date!=null)
                FutureBuilder(
                  
                  future: getDailyDataByDate("daily",date!), 
                  
                  builder:(context, snapshot) {
                    
                    if(snapshot.hasData){

                      dynamic obje = snapshot.data;
                      var data = json.decode(obje["data"]);

                      if(data==null) return Container();


                      return Column(
                        children: [

                  SizedBox(
                  height: 8,
                ),


                                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {

                      openBottomSheet(0);


                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 16),
                      width: double.infinity,
                      
                      child: Column(
                        children: [
                         const Text(
                            "Mood",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Black),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                            // Container(
                              //         child: Text("None"),
                              //         height: 58,
                              //         width: 58) :
                              Image.asset(
                                      emojiList[emojiIndex[data["feeling"]] as int].emoji,
                                      height: 58,
                                      width: 58),
                        ],
                      ),
                    ),
                  ),
                ),


                const SizedBox(
                  height: 8,
                ), 

                          Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                      openBottomSheet(1);

              },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 16),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Exercise",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Black),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Black,
                                  size: 18,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24,
                            ),
                             Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text( 

                                              "${data["exercises"].length}/8",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: PrimaryColor)),
                                            Text("Achieved",
                                                style: TextStyle(
                                                    color: PrimaryColor)),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Container(
                                              height: 28.0,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  shrinkWrap: true,
                                                  itemCount: data["exercises"].length,
                                                  
                                                  itemBuilder: (BuildContext
                                                              context,
                                                          int i) =>
                                                          Image.asset(
                                                              ExcersiseList[data["exercises"][i]],
                                                              
                                                              
                                                              // [controller.exerciseSelected[index]],
                                                              height: 38,
                                                              width: 38))),
                                        )
                                      ],
                                    )
                          ],
                        ),
                      )),
                ),
                

               const SizedBox(
                  height: 8,
                ),


                 Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      openBottomSheet(2);

                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      width: double.infinity,
                      child: Column(
                        children: [
                        const  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Glass of water",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Black),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Black,
                                size: 18,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                              Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("${data["glassOfWater"]}/8",
                                              style:const TextStyle(
                                                  fontSize: 18,
                                                  color: PrimaryColor)),
                                        const  Text("Achieved",
                                              style: TextStyle(
                                                  color: PrimaryColor)),
                                        ],
                                      ),
                                    const  SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Container(
                                            height: 28.0,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount: data["glassOfWater"],
                                                // controller.glass,
                                                itemBuilder: (BuildContext
                                                            context,
                                                        int index) =>
                                                    Image.asset(
                                                        "assets/BottomSheet/glass-of-water.png",
                                                        height: 38,
                                                        width: 38))),
                                      )
                                    ],
                                  )
                        ],
                      ),
                    ),
                  ),
                ),
                   
                const SizedBox(
                  height: 8,
                ),

                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      openBottomSheet(3);

                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         const  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Medicine",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Black),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Black,
                                size: 18,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "${data["tabletsTaken"].length}/4",
                                              style:const TextStyle(
                                                  fontSize: 18,
                                                  color: PrimaryColor)),
                                        const  Text("Achieved",
                                              style: TextStyle(
                                                  color: PrimaryColor)),
                                        ],
                                      ),
                                     const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Container(
                                            height: 28.0,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount: data["tabletsTaken"].length,
                                                
                                                // controller
                                                //     .medicineSelected.length,
                                                itemBuilder: (BuildContext
                                                            context,
                                                        int index) =>
                                                    Image.asset(
                                                        medicineList[medicineListIndex[data["tabletsTaken"][index]] as int]
                                                            .medicine,
                                                        height: 38,
                                                        width: 38))),
                                      )
                                    ],
                                  )
                        ],
                      ),
                    ),
                  ),
                ),
                 

                const SizedBox(
                  height: 8,
                ), 

                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {

                      openBottomSheet(4);


                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sleep Duration",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Black),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Black,
                                size: 18,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "${data["sleepDuration"]} Hours",
                              // healthProfileController.sleepDuration.value,
                              style: TextStyle(
                                  fontSize: 18, color: PrimaryColor)),
                        ],
                      ),
                    ),
                  ),
                ),
                 

                const SizedBox(
                  height: 8,
                ), 





                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      openBottomSheet(5);

                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        const  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Symptoms",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Black),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Black,
                                size: 18,
                              ),
                            ],
                          ),
                         const SizedBox(
                            height: 16,
                          ),  
                              Row(
                    children: [
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${data["symptoms"].length}/6",
                          style:const TextStyle(
                                  fontSize: 18,
                                  color: PrimaryColor)),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                            height: 28.0,
                            child: ListView.builder(
                                scrollDirection:
                                    Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: data["symptoms"].length,
                                itemBuilder: (BuildContext
                                            context,
                                        int index) =>
                                    Container(
                                      padding:
                                          EdgeInsets.all(4),
                                          margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius
                                                  .circular(
                                                      40)),
                                      child: Image.asset(
                                          symptomsList[symptomIndex[data["symptoms"][index]] as int]
                                              .image,
                                          color: Colors.white,
                                          height: 38,
                                          width: 38),
                                    ))),
                                      )
                                    ],
                                  )
                        ],
                      ),
                    ),
                  ),
                ),
 


                        ],
                      );




                    }else{
                      return Container();
                    }


                  },),

// daily records


// Vitals
      if(date!=null)
      FutureBuilder(
        
        future: getDailyDataByDate("vitals",date!)
      , builder:(context, snapshot) {
        if(snapshot.hasData){

          dynamic obj = snapshot.data;

          if(obj==null) return Container();

          final data = json.decode(obj["data"]);
          return Column(
            children: [

                                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {

                      goToVitals(context,0);

                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Blood Pressure",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Black),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Black,
                                size: 18,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Text(
                                    "${data["bloodPressureL"] ?? "___"} / ${data["bloodPressureH"] ?? "___"}",

                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                              Text(
                                " mmHg",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                
              const SizedBox(
                  height: 8,
                ),



                                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      goToVitals(context,1);

                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Blood Glucose",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Black),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Black,
                                size: 18,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                             Text(
                                    // "${healthProfileController.bloodGlucoseBF.value} f /${healthProfileController.bloodGlucoseAF.value} pp",
                                    "${data["bloodGlucoseBF"] ?? "___"} f / ${data["bloodGlucoseAF"] ?? "___"} pp",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                              Text(
                                " mg/dl",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                

              const  SizedBox(
                  height: 8,
                ),




                                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      goToVitals(context,2);

                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Blood Saturation",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Black),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Black,
                                size: 18,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Text(
                                    "${data["bloodSaturationBW"]  ?? "___" } / ${data["bloodSaturationAW"]  ?? "___"}",
                                    // "${healthProfileController.bloodSaturationBW.value}/${healthProfileController.bloodSaturationAW.value}",

                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                              Text(
                                " %",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
               const SizedBox(
                  height: 8,
                ),


                                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      goToVitals(context,3);


                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Temperature",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Black),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Black,
                                size: 18,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Text(
                                    "${data["temperature"]  ?? "___" }",
                                    // "${healthProfileController.temperature.value}",

                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                              Text(
                                " °${data["temperatureMetric"] ?? "___"}",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),



                                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      goToVitals(context,4);

                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "BMI Weight",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Black),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Black,
                                size: 18,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Text(
                                    "${data["bmiWeight"] ?? "___"}",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                              Text(
                                " kg",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
             const SizedBox(
                  height: 8,
                ),



                                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      goToVitals(context,5);

                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "BMI Height",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Black),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Black,
                                size: 18,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Text(
                                    "${data["bmiHeight"] ?? "___"}",
                                    // "${healthProfileController.bmi}",

                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                              Text(
                                " Height",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),

                          
                                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      goToVitals(context,6);


                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Heart Rate".tr,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Black),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Black,
                                size: 18,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Text(
                                    "${data["heartRateBW"] ?? "___"} / ${data["heartRateAW"] ?? "___"}",
                                    // "${healthProfileController.heartRateBW.value}/${healthProfileController.heartRateAW.value}",

                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                              Text(
                                " BPM",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              const SizedBox(
                  height: 8,
                ),



                              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      goToVitals(context,7);


                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Respiratory Rate".tr,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Black),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Black,
                                size: 18,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                             Text(
                                    "${data["respiratoryRate"] ?? "___"}",
                                    // "${healthProfileController.respiratoryRate.value}",

                                    style:const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                            const Text(
                                " beats per minute",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
               const SizedBox(
                  height: 8,
                ),




                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      goToVitals(context,8);


                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "HRV",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Black),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Black,
                                size: 18,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Text(
                                    "${data["hrv"] ?? "___"}",
                                    // "${healthProfileController.hrv.value}",

                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                              Text(
                                " MS",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              




            ],
          );
        }

        return Container();
      },),
              ]
          )                    
    )))
    );
  }
}


 emojis(int index) {
  return TextButton(
          style: TextButton.styleFrom(
              // shape: 
              // (controller.risk_Selected == index)
              //     ? RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(8.0),
              //         side: BorderSide(color: PrimaryColor, width: 1.5))
              //     : null,
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          onPressed: () {},
          // controller.riskSelected(index),
          child: Column(
            children: [
              emojiList[index].title == "none"
                  ? Center(child: Text("None".tr))
                  : Image.asset(emojiList[index].emoji, height: 58, width: 58),
             const SizedBox(
                height: 10,
              ),
              Text(
                emojiList[index].title,
                style: TextStyle(
                    color: Black
                    // controller.risk_Selected == index
                    //     ? PrimaryColor
                    //     : Black
                        ),
              ),
            ],
          ));
}

List<Emojis> emojiList = [
  // Emojis(title: 'none', emoji: ''),
  Emojis(title: 'Good', emoji: 'assets/BottomSheet/Emojis/good.png'),
  Emojis(title: 'Happy', emoji: 'assets/BottomSheet/Emojis/happy.png'),
  Emojis(title: 'Cool', emoji: 'assets/BottomSheet/Emojis/cool.png'),
  Emojis(title: 'Smile', emoji: 'assets/BottomSheet/Emojis/smile.png'),
  Emojis(title: 'Angry', emoji: 'assets/BottomSheet/Emojis/angry.png')
];

var emojiIndex = {
"Good": 0,
"Happy": 1,
"Cool": 2,
"Smile": 3,
"Angry": 4
};



class Emojis {
  String title;
  String emoji;
  Emojis({required this.title, required this.emoji});
}

List ExcersiseList = [
  'none',
  'assets/BottomSheet/Yoga/yoga.png',
  'assets/BottomSheet/Yoga/head.png',
  'assets/BottomSheet/Yoga/extended.png',
  'assets/BottomSheet/Yoga/corpse.png',
  'assets/BottomSheet/Yoga/cobra.png',
  'assets/BottomSheet/Yoga/chair.png',
  'assets/BottomSheet/Yoga/awkward.png',
  'assets/BottomSheet/Yoga/fish.png',
];

List emojiListImages = [
  '',
  'assets/BottomSheet/Yoga/yoga.png',
  'assets/BottomSheet/Yoga/head.png',
  'assets/BottomSheet/Yoga/extended.png',
  'assets/BottomSheet/Yoga/corpse.png',
  'assets/BottomSheet/Yoga/cobra.png',
  'assets/BottomSheet/Yoga/chair.png',
  'assets/BottomSheet/Yoga/awkward.png',
  'assets/BottomSheet/Yoga/fish.png',
];



class MedicineClass {
  String title;
  String medicine;
  MedicineClass({required this.title, required this.medicine});
}

List<MedicineClass> medicineList = [
  // MedicineClass(
  //     title: 'Vitamin C', medicine: 'assets/BottomSheet/Medicine/drug.png'),
  MedicineClass(
      title: 'Folic Acid', medicine: 'assets/BottomSheet/Medicine/drug.png'),
  // MedicineClass(
  //     title: 'Zinc', medicine: 'assets/BottomSheet/Medicine/vitamins.png'),
  MedicineClass(
      title: 'Iron', medicine: 'assets/BottomSheet/Medicine/vitamins.png'),
  MedicineClass(
      title: 'Calcium', medicine: 'assets/BottomSheet/Medicine/vitamins.png'),
  MedicineClass(title: 'Other', medicine:'assets/BottomSheet/Medicine/drug.png'),
  // MedicineClass(
  //     title: 'Anti Viral', medicine: 'assets/BottomSheet/Medicine/vitamin.png'),
];

var medicineListIndex = {
    "Folic Acid": 0,
"Iron": 1,
"Calcium": 2,
"Other": 3,

};


List<Symptoms> symptomsList = [
  Symptoms(title: 'Normal', image: 'assets/BottomSheet/Symptoms/normal.png'),
  Symptoms(
      title: 'Body pain', image: 'assets/BottomSheet/Symptoms/boad_pain.png'),
  Symptoms(
      title: 'Burning Stomach',
      image: 'assets/BottomSheet/Symptoms/burning_in_stomach.png'),
  Symptoms(
      title: 'Cold cough', image: 'assets/BottomSheet/Symptoms/cold_cough.png'),
  Symptoms(
      title: 'Dizziness', image: 'assets/BottomSheet/Symptoms/dizziness.png'),
  Symptoms(
      title: 'Headache', image: 'assets/BottomSheet/Symptoms/headache.png'),
  Symptoms(title: 'Vomiting', image: 'assets/BottomSheet/Symptoms/vomiting.png')
];

var symptomIndex = {
"Normal" : 0,
"Body pain" : 1,
"Burning Stomach" : 2,
"Cold cough" : 3,
"Dizziness" : 4,
"Headache" : 5,
"Vomiting" : 6,
};

class Symptoms {
  String title;
  String image;
  Symptoms({required this.title, required this.image});
}

List<String> monthNames = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];
  final List<dynamic> vitals = [
    BloodPressure(),
    BloodGlucose(),
    BloodSaturation(),
    Temperature(),
    BMI(),
    BMI(),
    HeartRate(),
    RespiratoryRate(),
    HeartRateVariability()
  ];