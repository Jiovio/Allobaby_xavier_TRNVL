import 'dart:convert';

import 'package:allobaby/API/apiroutes.dart';
import 'package:allobaby/Components/bottom_nav.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/CallController.dart';
import 'package:allobaby/Controller/MainController.dart';
import 'package:allobaby/Screens/Call/pickupLayout.dart';
import 'package:allobaby/Screens/Main/BottomSheet/BottomQuestion.dart';
import 'package:allobaby/Screens/Main/BottomSheet/widgets/Exercise.dart';
import 'package:allobaby/Screens/Main/BottomSheet/widgets/emoji.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localstorage/localstorage.dart';
import 'package:allobaby/Screens/AI/allobotModal.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int i=0;
  late  PageController pageController ;

  CallController callcont = Get.put(CallController());

    Stream<DatabaseEvent> listenForCall() {
    final String uid = localStorage.getItem("uid").toString();

    DatabaseReference ref = FirebaseDatabase.instance.ref("calls/$uid");

    // Listen to real-time changes in the calls/$uid node

    ref.onValue.listen((val){
      dynamic callData = (val.snapshot.value);

      bool isCall = callData?["call"] ?? false;


      if(isCall){

        callcont.showCallScreen(
          callerName: callData["callerName"],
            type: callData["type"],
            channel: callData["p1"],
            token: callData["token"],
            to : callData["p2"]
        );
      }else{
        callcont.endCall();
      }
    });

    return ref.onValue;


  }


    @override
  void initState() {
    super.initState();
   pageController =  PageController(initialPage: 0);
   listenForCall();
  }



  Maincontroller mainC = Get.put(Maincontroller());
  NavController navController = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: 
      // PickUpLayout(
      //   scaffold: 
        
        Scaffold(
          bottomNavigationBar:bottomNavigationBar(navController),
          // Obx(()=> mainC.loading.value?Container():bottomNavigationBar()),
          
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.transparent,
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                                  gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          PrimaryColor.withOpacity(0.8),
                          PrimaryColor,
                        ],
                      ),
              )
              ,child: Image.asset("assets/BottomSheet/baby_white.png")),
            onPressed: () {  

                              showAllobotModalWithEmoji(context);

                              return;

        
          
                              // bottomSheetController.pageChanged = 0;
                              // mainC.getCounterData();
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(12.0)),
                        ),
                        context: context,
                        builder: (BuildContext context) => Container(
                              height: Get.height / 2,
                              child:  
                              bottomQuestionSheet(context,0),
                              // Text("Hi")
        
        
                            ));
            },
            
          ),
        
          body: 
          
          Obx(() => mainC.loading.value? Center(child: CircularProgressIndicator()):bodyRoutes.elementAt(navController.selectedIndex.value))
        
        ),
      // ),
    );
  }
}