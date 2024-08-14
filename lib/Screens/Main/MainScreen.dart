import 'package:allobaby/Components/bottom_nav.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Screens/Main/BottomSheet/BottomQuestion.dart';
import 'package:allobaby/Screens/Main/BottomSheet/widgets/Exercise.dart';
import 'package:allobaby/Screens/Main/BottomSheet/widgets/emoji.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int i=0;
    PageController pageController = PageController(initialPage: 0);

    

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: bottomNavigationBar(),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.transparent,
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            
            // color: Colors.transparent,
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
                          // bottomSheetController.pageChanged = 0;
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12.0)),
                    ),
                    context: context,
                    builder: (BuildContext context) => Container(
                          height: Get.height / 2,
                          child:  
                          bottomQuestionSheet(context),
                          // Text("Hi")


                        ));
        },
        
      ),

      body: Obx(() => bodyRoutes.elementAt(navController.selectedIndex.value))

    );
  }
}