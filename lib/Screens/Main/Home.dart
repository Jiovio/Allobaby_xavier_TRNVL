import 'package:allobaby/Components/appbar.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/MainController.dart';
import 'package:allobaby/Controller/NewsController.dart';
import 'package:allobaby/Screens/AI/Allobot.dart';
import 'package:allobaby/Screens/AI/allobotModal.dart';
import 'package:allobaby/Screens/Home/Awareness/Awareness.dart';
import 'package:allobaby/Screens/Home/Checkup/CheckUp.dart';
import 'package:allobaby/Screens/Home/Prescription/Prescription.dart';
import 'package:allobaby/Screens/Home/Report/Report.dart';
import 'package:allobaby/Screens/Home/Screening/SelfScreening.dart';
import 'package:allobaby/Screens/Home/Screening/SymptomsScreen.dart';
import 'package:allobaby/Screens/Home/Screening/labReports/ScreeningwithReports.dart';
import 'package:allobaby/Screens/Home/Screening/labReports/Tests/Hemoglobin.dart';
import 'package:allobaby/Screens/Main/Card/AvatarCard.dart';
import 'package:allobaby/Screens/Main/Card/BannerCard.dart';
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


  Maincontroller mainC = Get.put(Maincontroller());

  Newscontroller newsC = Get.put(Newscontroller());

    Locale currentLocale = Get.locale as Locale;

    ValueNotifier<Locale> currentLocaleNotifier = ValueNotifier(Get.locale as Locale);


  

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: customAppBar(title: "AlloBaby".tr, context: context),
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
                                      lineWidth: 15.0,
                                      percent: mainC.ccomp<0 ? mainC.ccomp*-1 : mainC.ccomp,
                              
                                      center: true
                                          ? Text(
                                              "Day".tr +" " +"${mainC.ctotalDays - (mainC.ctotalDays - mainC.cdaysPassed)}",
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            )
                                          : Text(
                                              "Not yet started".tr,
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
                                           Text("Health Status".tr,
                                          style: TextStyle(
                                              color: Black.withOpacity(0.6),
                                              fontSize: 14)),
                                  ],)
                            ],),
                          )
                        
                                ,InkWell(
                                  

                            child: Row(children: [
                                                                Container(
                                    padding:const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: Colors.green),
                                    child:const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 16,
                                      color: Black,
                                    ),
                                  ),

                                  const SizedBox(width: 8,),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                               GetBuilder<Maincontroller>(
                                                 builder: (controller) =>  Text(
                                                    mainC.lastScreened==null?
                                                    "- - - ":
                                                    mainC.lastScreened!,
                                                    style:const TextStyle(
                                                    fontSize: 18,
                                                    color: PrimaryColor,
                                                    fontWeight: FontWeight.w700),
                                                                                           ),
                                               ),
                                             
                                          Text("Last Screened".tr ,
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: Black.withOpacity(0.6),
                                              fontSize:currentLocale.languageCode == 'ta' ||currentLocale.languageCode == 'ka'  
                                              ? 10: 14
                                              ),
                                                softWrap: true,
                                                overflow: TextOverflow.visible,
                                              ),
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
                                            "FREE",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: PrimaryColor,
                                                fontWeight: FontWeight.w700),
                                          ),
                                                                                Text("Subscription Plan".tr,
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

            const SizedBox(
              height: 8,
            ),

                        Container(
              height: 132.0,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  children: [
                        categories("Allobot".tr, 'assets/Chat/chatbot.png',
                        // CheckUp()
                        Container(),() {allobotModal(context);}
                        ),
                    categories("Awareness".tr,
                        'assets/Homescreen/myawernessnew.png', 
                        Awareness()
                        // Signin()
                        ),

                        categories("Appointments".tr,
                        'assets/Homescreen/appointment.png', 
                        MyAppointment()
                        // Signin()
                        ),


                    categories("Screening".tr, 'assets/Homescreen/virus.png',
                        // SelfScreening()
                        // Hemoglobin()
                        ScreeningWithReports()
                        ),
                    categories(
                        "Report".tr,
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
                        "Prescription".tr,
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
                    categories("Checkup".tr, 'assets/Homescreen/mycheckupnew.png',
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

              Obx(()=>

              newsC.loading.value?CircularProgressIndicator():
              newsC.news.length==0?
              Center(
                            child: Text(
                              "No News Feed".tr,
                              style:const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ):
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: newsC.news.length,
                itemBuilder: (context, index) {

                  dynamic data = newsC.news[index];

                  String type = data["cardtype"];

                  switch (type) {
                    case "banner":
                     return   Bannercard(title: data["title"],
                     description: data["description"],
                     imgurl: data["imageurl"],);
                      

                    case "avatar":
                    return  Avatarcard(title: data["title"],
                     description: data["description"],
                     imgurl: data["imageurl"]);
                      
                  }
                          
                 

                
              },)
              
              ),




                          // Avatarcard(),


            ],),
            )

        ],),

        
      ),
    
    );
  }

  Card categories(String title, String image, Widget routes,[Function? func = null]) {
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
      onTap: ()  {
        if(func!=null){
          func();
        }else
        Get.to(() => routes, transition: Transition.rightToLeft);
        
        },
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
                style: TextStyle(fontSize: currentLocale.languageCode == 'ta'?12:14),
              )
            ],
          ),
        ),
      ),
    ),
  );


  
}


}