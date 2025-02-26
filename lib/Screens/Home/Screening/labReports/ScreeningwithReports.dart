
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Screens/Home/Screening/Controllers/SelfScreeningController.dart';
import 'package:allobaby/Screens/Home/Screening/SelfScreening.dart';
import 'package:allobaby/features/selfscreening/model/self_screening_model.dart';

import 'package:allobaby/features/selfscreening/self_screening_list.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ScreeningWithReports extends StatefulWidget {
  const ScreeningWithReports({super.key});

  @override
  State<ScreeningWithReports> createState() => _ScreeningWithReportsState();
}

class _ScreeningWithReportsState extends State<ScreeningWithReports> {


  List<LabreportOptions> ls = [
  LabreportOptions("Symptoms".tr,SelfScreening(initPage: 0,),"symptoms.png"),
  LabreportOptions("Vital Test".tr,SelfScreening(initPage: 1,),"vitals.png"),
  LabreportOptions("Hemoglobin Test".tr,SelfScreening(initPage: 2,),"hemoglobin.png"),
  LabreportOptions("Urine Test".tr,SelfScreening(initPage: 3,),"urinetest.png"),
  LabreportOptions("Glucose Test".tr,SelfScreening(initPage: 4,),"glucose.png"),
  LabreportOptions("Fetal Monitoring".tr,SelfScreening(initPage: 5,),"fetalmon.png"),
  LabreportOptions("Ultrasound Test".tr,SelfScreening(initPage: 6,),"ultrasound.png")
  ];

  Selfscreeningcontroller sc = Get.put(Selfscreeningcontroller());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Self Screening".tr),

        actions: [IconButton(onPressed: ()async {

          bool sympsub = sc.symptomsUploaded;
          bool vitsub = sc.vitalsUploaded;


         final item =  SelfScreeningModel(created: DateTime(2024),
          id: sc.screeningId,
          hemoglobinId: sc.hemoglobinId,
          urineTestId: sc.urineTestId,
          glucoseId: sc.glucoseTestId,
          fetalTestId: sc.fetalmonitoringId,
          ultrasoundId: sc.ultrasoundId,
          params: {"vitals" : sc.vitalsData, "symptoms" : sc.getSelectedSymptoms()});



        await  Get.to(()=> const SelfScreeningList());

        sc.setSelfScreeningData(item);



          sc.symptomsUploaded = sympsub;
          sc.vitalsUploaded = vitsub;

          sc.update();


        }, icon: Icon(Icons.list))],
      ),

      body: SingleChildScrollView(
        child: Container(
          
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          width: double.infinity,
          child: Column(children: [
            Image.asset(
              "assets/reportsicon.png",
              scale: 1,
              width: 100,
              height: 100,
            ),
           const SizedBox(
              height: 20,
            ),
            Text(
              "Let's begin the test".tr,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
           const SizedBox(
              height: 40,
            ),


             GetBuilder<Selfscreeningcontroller>(
               builder: (controller) {
                 return Card(
                             shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(color: Black)),
                             child: InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    highlightColor: accentColor.withOpacity(0.1),
                    splashColor: accentColor.withOpacity(0.8),
                    onTap: () => 
                    Get.to(()=>SelfScreening(initPage: 0,) ,
                        transition: Transition.rightToLeft),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: ListTile(
                        leading: Image.asset(
                          "assets/labReports/symptoms.png",
                          scale: 12,
                        ),
                        title: Text(
                          "Symptoms".tr,
                          style: const TextStyle(fontSize: 18),
                        ),
                        trailing:
                                 controller.symptomsUploaded ?
                                 const Icon(Icons.check, color: Colors.green):
                                 const Icon(Icons.arrow_forward_ios_rounded, color: Black)
                      ),
                    )));
               }
             ),

                const SizedBox(
                      height: 20,
                    ),


                                 GetBuilder<Selfscreeningcontroller>(
                                   builder: (controller) {
                                     return Card(
                                                 shape: RoundedRectangleBorder(
                                                     borderRadius: BorderRadius.circular(8.0),
                                                     side: const BorderSide(color: Black)),
                                                 child: InkWell(
                                                     borderRadius: BorderRadius.circular(8.0),
                                                     highlightColor: accentColor.withOpacity(0.1),
                                                     splashColor: accentColor.withOpacity(0.8),
                                                     onTap: () => 
                                                     Get.to(()=>SelfScreening(initPage: 1,) ,
                                                         transition: Transition.rightToLeft),
                                                     child: Padding(
                                                       padding: const EdgeInsets.only(top: 8, bottom: 8),
                                                       child: ListTile(
                                                         leading: Image.asset(
                                                           "assets/labReports/vitals.png",
                                                           scale: 12,
                                                         ),
                                                         title: Text(
                                                           "Vital Test".tr,
                                                           style: const TextStyle(fontSize: 18),
                                                         ),
                                                         trailing:
                                     controller.vitalsUploaded ?
                                     const Icon(Icons.check, color: Colors.green):
                                     const Icon(Icons.arrow_forward_ios_rounded, color: Black)
                                                       ),
                                                     )));
                                   }
                                 ),

                const SizedBox(
                      height: 20,
                    ),

                         GetBuilder<Selfscreeningcontroller>(
                           builder: (controller) {
                             return Card(
                                         shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(8.0),
                                             side: const BorderSide(color: Black)),
                                         child: InkWell(
                                             borderRadius: BorderRadius.circular(8.0),
                                             highlightColor: accentColor.withOpacity(0.1),
                                             splashColor: accentColor.withOpacity(0.8),
                                             onTap: () => 
                                             Get.to(()=>SelfScreening(initPage: 2,) ,
                                                 transition: Transition.rightToLeft),
                                             child: Padding(
                                               padding: const EdgeInsets.only(top: 8, bottom: 8),
                                               child: ListTile(
                                                 leading: Image.asset(
                                                   "assets/labReports/hemoglobin.png",
                                                   scale: 12,
                                                 ),
                                                 title: Text(
                                                   "Hemoglobin Test".tr,
                                                   style: const TextStyle(fontSize: 18),
                                                 ),
                                                 trailing:
                                                     controller.hemoglobinId!=null ?
                             const Icon(Icons.check, color: Colors.green):
                             const Icon(Icons.arrow_forward_ios_rounded, color: Black)
                             
                             
                             
                                               ),
                                             )));
                           }
                         ),

                const SizedBox(
                      height: 20,
                    ),


                         GetBuilder<Selfscreeningcontroller>(
                           builder: (controller) {
                             return Card(
                                         shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(8.0),
                                             side: const BorderSide(color: Black)),
                                         child: InkWell(
                                             borderRadius: BorderRadius.circular(8.0),
                                             highlightColor: accentColor.withOpacity(0.1),
                                             splashColor: accentColor.withOpacity(0.8),
                                             onTap: () => 
                                             Get.to(()=>SelfScreening(initPage: 3,) ,
                                                 transition: Transition.rightToLeft),
                                             child: Padding(
                                               padding: const EdgeInsets.only(top: 8, bottom: 8),
                                               child: ListTile(
                                                 leading: Image.asset(
                                                   "assets/labReports/urinetest.png",
                                                   scale: 12,
                                                 ),
                                                 title: Text(
                                                   "Urine Test".tr,
                                                   style: const TextStyle(fontSize: 18),
                                                 ),
                                                 trailing:
                                                     controller.urineTestId!=null ?
                             const Icon(Icons.check, color: Colors.green):
                             const Icon(Icons.arrow_forward_ios_rounded, color: Black)                                               ),
                                             )));
                           }
                         ),

                const SizedBox(
                      height: 20,
                    ),



                         GetBuilder<Selfscreeningcontroller>(
                           builder: (controller) {
                             return Card(
                                         shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(8.0),
                                             side: const BorderSide(color: Black)),
                                         child: InkWell(
                                             borderRadius: BorderRadius.circular(8.0),
                                             highlightColor: accentColor.withOpacity(0.1),
                                             splashColor: accentColor.withOpacity(0.8),
                                             onTap: () => 
                                             Get.to(()=>SelfScreening(initPage: 4,) ,
                                                 transition: Transition.rightToLeft),
                                             child: Padding(
                                               padding: const EdgeInsets.only(top: 8, bottom: 8),
                                               child: ListTile(
                                                 leading: Image.asset(
                                                   "assets/labReports/glucose.png",
                                                   scale: 12,
                                                 ),
                                                 title: Text(
                                                   "Glucose Test".tr,
                                                   style: const TextStyle(fontSize: 18),
                                                 ),
                                                 trailing:
                                          controller.glucoseTestId!=null ?
                                          const Icon(Icons.check, color: Colors.green):
                                          const Icon(Icons.arrow_forward_ios_rounded, color: Black)
                                               ),
                                             )));
                           }
                         ),

                const SizedBox(
                      height: 20,
                    ),


                         GetBuilder<Selfscreeningcontroller>(
                           builder: (controller) {
                             return Card(
                                         shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(8.0),
                                             side: const BorderSide(color: Black)),
                                         child: InkWell(
                                             borderRadius: BorderRadius.circular(8.0),
                                             highlightColor: accentColor.withOpacity(0.1),
                                             splashColor: accentColor.withOpacity(0.8),
                                             onTap: () => 
                                             Get.to(()=>SelfScreening(initPage: 5,) ,
                                                 transition: Transition.rightToLeft),
                                             child: Padding(
                                               padding: const EdgeInsets.only(top: 8, bottom: 8),
                                               child: ListTile(
                                                 leading: Image.asset(
                                                   "assets/labReports/fetalmon.png",
                                                   scale: 12,
                                                 ),
                                                 title: Text(
                                                   "Fetal Monitoring".tr,
                                                   style: TextStyle(fontSize: 18),
                                                 ),
                                                 trailing:
                             controller.fetalmonitoringId!=null ?
                             const Icon(Icons.check, color: Colors.green):
                             const Icon(Icons.arrow_forward_ios_rounded, color: Black)
                                               ),
                                             )));
                           }
                         ),

                const SizedBox(
                      height: 20,
                    ),



                         GetBuilder<Selfscreeningcontroller>(
                           builder: (controller) {
                             return Card(
                                         shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(8.0),
                                             side: const BorderSide(color: Black)),
                                         child: InkWell(
                                             borderRadius: BorderRadius.circular(8.0),
                                             highlightColor: accentColor.withOpacity(0.1),
                                             splashColor: accentColor.withOpacity(0.8),
                                             onTap: () => 
                                             Get.to(()=>SelfScreening(initPage: 6,) ,
                                                 transition: Transition.rightToLeft),
                                             child: Padding(
                                               padding: const EdgeInsets.only(top: 8, bottom: 8),
                                               child: ListTile(
                                                 leading: Image.asset(
                                                   "assets/labReports/ultrasound.png",
                                                   scale: 12,
                                                 ),
                                                 title: Text(
                                                   "Ultrasound Test".tr,
                                                   style: TextStyle(fontSize: 18),
                                                 ),
                                                 trailing:
                             controller.ultrasoundId!=null ?
                             const Icon(Icons.check, color: Colors.green):
                             const Icon(Icons.arrow_forward_ios_rounded, color: Black)
                                               ),
                                             )));
                           }
                         ),

                const SizedBox(
                      height: 20,
                    ),
        











            // ListView.builder(
            //   physics: NeverScrollableScrollPhysics(),
            //   itemCount: ls.length,
            //   shrinkWrap: true,
            //   itemBuilder:(context, index) {
            //     String title = ls[index].x;
            //     Widget sc = ls[index].screen;
            //     String img = ls[index].img;

            //     return Column(
            //       children: [
            //         Card(
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(8.0),
            //             side: const BorderSide(color: Black)),
            //         child: InkWell(
            //             borderRadius: BorderRadius.circular(8.0),
            //             highlightColor: accentColor.withOpacity(0.1),
            //             splashColor: accentColor.withOpacity(0.8),
            //             onTap: () => 
            //             Get.to(sc ,
            //                 transition: Transition.rightToLeft),
            //             child: Padding(
            //               padding: const EdgeInsets.only(top: 8, bottom: 8),
            //               child: ListTile(
            //                 leading: Image.asset(
            //                   "assets/labReports/$img",
            //                   scale: 12,
            //                 ),
            //                 title: Text(
            //                   title,
            //                   style: TextStyle(fontSize: 18),
            //                 ),
            //                 trailing:
            //                     Icon(Icons.arrow_forward_ios_rounded, color: Black),
            //               ),
            //             ))),
                        
            //             SizedBox(
            //   height: 20,
            // ),
            //       ],
            //     );
           
            //   }),    
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