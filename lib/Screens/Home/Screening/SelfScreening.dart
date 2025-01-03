import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/Reports/fetalMonitoringController.dart';
import 'package:allobaby/Controller/Reports/glucoseController.dart';
import 'package:allobaby/Controller/Reports/hemoglobinController.dart';
import 'package:allobaby/Controller/Reports/ultraSoundController.dart';
import 'package:allobaby/Controller/Reports/urineTestController.dart';
import 'package:allobaby/Screens/Home/Screening/Controllers/SelfScreeningController.dart';
import 'package:allobaby/Screens/Home/Screening/SymptomsScreen.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/Vitals.dart';
import 'package:allobaby/Screens/Home/Screening/labReports/Tests/FetalMonitoring.dart';
import 'package:allobaby/Screens/Home/Screening/labReports/Tests/Glucose.dart';
import 'package:allobaby/Screens/Home/Screening/labReports/Tests/Hemoglobin.dart';
import 'package:allobaby/Screens/Home/Screening/labReports/Tests/UltraSound.dart';
import 'package:allobaby/Screens/Home/Screening/labReports/Tests/Urine.dart';
import 'package:allobaby/Screens/Home/Screening/summary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelfScreening extends StatefulWidget {
   int initPage = 0;
    SelfScreening({super.key, required this.initPage});

  @override
  State<SelfScreening> createState() => _SelfScreeningState();
}

class _SelfScreeningState extends State<SelfScreening> {

    late int initP;
    int i = 0;
    late PageController pg ;


    @override
    void initState() {
      super.initState();
      initP = widget.initPage;
      i=initP;
      pg = PageController(initialPage: initP);

    }

    

  void _updateCurrentPageIndex(int index) {
    pg.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }


  Selfscreeningcontroller controller = Get.put(Selfscreeningcontroller());

  Hemoglobincontroller hemocont = Get.put(Hemoglobincontroller());
  Urinetestcontroller urinecont = Get.put(Urinetestcontroller());
  Glucosecontroller glucosecont = Get.put(Glucosecontroller());
  Fetalmonitoringcontroller fetalcont = Get.put(Fetalmonitoringcontroller());
  Ultrasoundcontroller ultrasoundcont = Get.put(Ultrasoundcontroller());


    


  void submit(int i) async {

  List<Function> funclist = [
        controller.submitSymptoms,
        controller.submitVitals,
        hemocont.submit,
        urinecont.submit,
        glucosecont.submit,
        fetalcont.submit,
        ultrasoundcont.submit
    ];


    print("i = $i");

    // await funclist[i]();

  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Self Screening".tr),
      ),


      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pg,
        onPageChanged: (index) {
          print(index);
          setState(() {
            i=index;
          });

        },
        children: [
          SymptomsScreen(),
          VitalsScreen(),
          Hemoglobin(),
          Urine(),
          Glucose(),
          Fetalmonitoring(),
          Ultrasound(),
          // summary(),

        ],
      ),


      bottomNavigationBar: Container(
                padding: EdgeInsets.only(top: 6.0, left: 20, right: 20, bottom: 10),
        color: Get.isDarkMode ? darkGrey2 : White,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

                
                      Visibility(
                        visible: i!=0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PrimaryColor,
                            padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            // primary: PrimaryColor,
                            foregroundColor: Colors.white

                          ),
                          onPressed: () {

                            // _updateCurrentPageIndex(i>0?i--:0);
                            pg.previousPage(duration: Durations.medium1,curve: Curves.bounceInOut);

// setState(() {
  
// });
                          },
                          child: Text("BACK".tr),
                        ),
                      ),



                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //     padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(20)),
                      //     // primary: PrimaryColor,
                      //     backgroundColor: PrimaryColor,
                      //     foregroundColor: Colors.white
                          
                      //   ),
                      //   // onPressed: () => serviceController.addCheckupDetails(),
                      //   onPressed: () {
                          
                      //   },
                      //   child: Text("SAVE"),
                      // ),

                      // Container(),


                      Visibility(
                        visible: i==6?false:true,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            backgroundColor: PrimaryColor,
                            textStyle: TextStyle(color: White),
                            foregroundColor: Colors.white
                          ),
                          onPressed: () {
                        
                            pg.nextPage(duration: Duration(milliseconds: 300),curve: Curves.linear);
                            submit(i);
                            // print(pg.page);
                        
                        // _updateCurrentPageIndex(i<1?i++:1);
                        

                          },
                          child: Text("NEXT".tr
                          ),
                        ),
                      ),

                      if(i==6)
                      ElevatedButton(onPressed: () {
                        Get.back();
                        
                      }, 
                      child: Text("Finish".tr),)

        ],),
      ),
    );
  }
}