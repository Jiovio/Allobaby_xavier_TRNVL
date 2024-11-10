

import 'dart:convert';

import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/MainController.dart';
import 'package:allobaby/Screens/Main/BottomSheet/widgets/Exercise.dart';
import 'package:allobaby/Screens/Main/BottomSheet/widgets/emoji.dart';
import 'package:allobaby/Screens/AI/allobotModal.dart';

import 'package:allobaby/Screens/Main/BottomSheet/widgets/medicine.dart';
import 'package:allobaby/Screens/Main/BottomSheet/widgets/sleepduration.dart';
import 'package:allobaby/Screens/Main/BottomSheet/widgets/symptoms.dart';
import 'package:allobaby/Screens/Main/BottomSheet/widgets/voicerecord.dart';
import 'package:allobaby/Screens/Main/BottomSheet/widgets/watercount.dart';
import 'package:allobaby/db/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget bottomQuestionSheet(BuildContext context, int i){

  PageController pageController = PageController(initialPage: i);
  Maincontroller mc = Get.put(Maincontroller());
  mc.currpage = (i);

  return
  GetBuilder<Maincontroller>(
    init: Maincontroller(),
    builder: (controller) =>  
   Stack(
    alignment: Alignment.bottomCenter,
children: [
        PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: (index) {
            controller.pageChanged(index);
          },
          children: [
          emojiPage(),
          exercise(),
          waterCount(),
          medicine(),
          sleepDuration(context),
          symptoms(context),
          const Voicerecord()
          ]),

          Container(
            padding: EdgeInsets.only(top: 6.0, left: 20, right: 20, bottom: 10),
        color: Get.isDarkMode ? darkGrey2 : White,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          Visibility(
                        visible: controller.currpage<6,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          // backgroundColor: PrimaryColor,
                          textStyle: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {

                          pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);

                          // pageController.pageController.animateToPage(
                          //     pageController.pageChanged - 1,
                          //     duration: Duration(milliseconds: 300),
                          //     curve: Curves.easeInOut);
                        },
                        child: Text("BACK"),
                      ),
                    ),

                        
                        Visibility(
                            visible: controller.currpage<6,
                          child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            // backgroundColor: PrimaryColor,
                            textStyle: TextStyle(color: White),
                          ),
                          onPressed: () {

                                                        controller.pageChanged(6);
                            controller.update();


                            pageController.jumpToPage(6);

                        
                                    
                          },
                          child: Icon(Icons.mic_none_rounded,color: White,),
                                                ),
                        ),

                          // if(controller.currpage==5)
                          // (
                          //   ElevatedButton(
                          //   style: ElevatedButton.styleFrom(
                          //     padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                          //     shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(20)),
                          //     // backgroundColor: PrimaryColor,
                          //     textStyle: TextStyle(color: White),
                          //   ),
                          //   onPressed: () async {
                          //     await createChatTable();
                          //   // await  controller.submitBottomSheetData();

                                      
                          //   },
                          //   child: Text("Finish"),
                          //                         )),

                          if(controller.currpage==5)
                          Visibility(
                            visible: controller.currpage==5,
                            child: ElevatedButton(
                              child: Text("Finish"),
                              onPressed: () async {

                               await controller.updateDailyScreening();

           


                                Navigator.pop(context);
                                
                              },
                              ),),
                          

                  
                    
                    if(controller.currpage <5 )
                    (
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          // backgroundColor: PrimaryColor,
                          textStyle: TextStyle(color: White),
                        ),
                        onPressed: () {
                          print(controller.currpage);
                          if(controller.currpage<5)
                          pageController.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                    
                    
                                      
                        },
                        child: Text("NEXT"),
                    ))
        ],),
          )

],
  )
  );


    }


    