import 'dart:convert';

import 'package:allobaby/Components/bottom_nav.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Config/OurFirebase.dart';
import 'package:allobaby/Controller/MainController.dart';
import 'package:allobaby/Controller/SignupController.dart';
import 'package:allobaby/Controller/UserController.dart';
import 'package:allobaby/Screens/Settings/AppInfo.dart';
import 'package:allobaby/Screens/Settings/EditProfile.dart';
import 'package:allobaby/Screens/Settings/Help.dart';
import 'package:allobaby/Screens/Settings/SubscriptionViewApp.dart';
import 'package:allobaby/Screens/Settings/ViewHospital.dart';
import 'package:allobaby/Screens/Settings/hospital.dart';
import 'package:allobaby/Screens/Signin.dart';
import 'package:allobaby/app.dart';
import 'package:allobaby/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:allobaby/Components/languagedialog.dart';
import 'package:localstorage/localstorage.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  Maincontroller mainC = Get.put(Maincontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

          appBar: PreferredSize(
              preferredSize: Size.fromHeight(100.0),
              
              child: Container(
                padding: EdgeInsets.only(top: 24, bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Settings".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: darkGrey2),
                      ),
                      // IconButton(
                      //   icon:const Icon(
                      //     Icons.notifications_none_rounded,
                      //     color: Black800,
                      //   ),
                      //   onPressed: () {} 
                      //   // Get.to(() => NotificationView(),
                      //   //     transition: Transition.rightToLeft),
                      // )
                    ],
                  ),
                ),
              )),

                        body: Scrollbar(
            radius: Radius.circular(4),
            // controller: _scrollController,
            child: SingleChildScrollView(
              // controller: _scrollController,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {} ,
                    // settingsController.getPatientDetails(),
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 16, top: 25, bottom: 16, right: 20),
                      child: Row(children: [
                    
                        GetBuilder<Maincontroller>(
                          builder: (controller) {
                            return CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 36.0,
                                backgroundImage: 
                                mainC.profile_pic!=null && mainC.profile_pic!="" ?
                                CachedNetworkImageProvider(controller.profile_pic as String):
                               const AssetImage("assets/General/avatar.png") as ImageProvider
                            
                                );
                          }
                        ),
                       const SizedBox(
                          width: 24.0,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                    mainC.name.text,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800),
                                  ),
                             const SizedBox(
                                height: 4,
                              ),
                              Text(mainC.email.text),
                            ])
                      ]),
                    ),
                  ),
                  ListView(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        title: Text(
                          'Edit Profile'.tr,
                        ),
                        leading: Icon(
                          Icons.edit,
                          color: Black,
                        ),
                        onTap: () {
                          Get.to(()=>EditProfile());
                        },
                        // settingsController.getPatientDetails(),
                      ),

                                            ListTile(
                        title: Text(
                          'My Hospital'.tr,
                        ),
                        leading: Icon(
                          Icons.local_hospital,
                          color: Black,
                        ),
                        onTap: () {
                          
                          final d = localStorage.getItem("defaultHospital");

                          if(d==null){
                          Get.to(() => MyHospital(),
                              transition: Transition.rightToLeft);
                          }else{
                            Get.to(()=> ViewHospital(hospital: json.decode(d), def: true,));
                          }


                        },
                      ),


                      ListTile(
                        title: Text(
                          'My Subscription'.tr,
                        ),
                        leading: Icon(
                          Icons.payment,
                          color: Black,
                        ),
                        onTap: () {
                          Get.to(() => SubscriptionViewApp(),
                              transition: Transition.rightToLeft);
                        },
                      ),
      
                      




                      ListTile(
                        title: Text(
                          'Notification'.tr,
                        ),
                        leading: Icon(
                          Icons.notifications_none_outlined,
                          color: Black,
                        ),
                 
                        subtitle: 
                        GetBuilder<Maincontroller>(builder: (c) => Text(
                              c.notification.value
                                  ? "ON".tr
                                  : "OFF".tr,
                            )),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                  title: Text("Notification"),
                                  content: ListTile(
                                      title: Text(
                                        'ON/OFF',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      leading: GetBuilder<Maincontroller>(
                                        builder: (controller) {
                                          return ValueBuilder<bool?>(
                                            initialValue: controller.notification.value,
                                            builder: (isChecked, updateFn) =>
                                                Switch(
                                              activeColor: PrimaryColor,
                                              value: isChecked!,
                                              onChanged: (newValue) async {
                                                updateFn(newValue);
                                                print(newValue);
                                                final bool = await controller.toggleNotificationPermission(!newValue);
                                                print(bool);
                                                controller.update();
                                                updateFn(bool);
                                              },
                                            ),
                                          );
                                        }
                                      ))));
                        },
                      ),
                      
                      
                      GetBuilder<Usercontroller>(
                        init: Usercontroller(),
                        builder: (c) {
                          return 
                          ListTile(
                            title: Text(
                              'Language'.tr,
                            ),
                            subtitle: Text(c.locale),
                            // GetBuilder<LanguageController>(
                            //     builder: (controller) => Text(
                            //           controller.selectedLang,
                            //         )),
                            leading: Icon(
                              Icons.translate_rounded,
                              color: Black,
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),
                            onTap: () {
                            languageSelectDialog(context);
                          
                            }
                          );
                        }
                      ),
                      ListTile(
                        title: Text(
                          'Terms & Conditions'.tr,
                        ),
                        leading: Icon(
                          Icons.assignment_outlined,
                          color: Black,
                        ),
                        // onTap: () => Get.to(() => TermsAndConditions(),
                        //     transition: Transition.rightToLeft),
                        onTap: () async {
                          const url =
                              'https://savemom.in/terms.html';
                          _launchURL(url);
                        },
                      ),
                      ListTile(
                        title: Text(
                          'Privacy Policy'.tr,
                        ),
                        leading: Icon(
                          Icons.warning_amber_rounded,
                          color: Black,
                        ),
                        // onTap: () => Get.to(() => PrivacyPolicy(),
                        //     transition: Transition.rightToLeft),
                        onTap: () async {
                          const url =
                              'https://savemom.in/privacy.html';
                          _launchURL(url);
                        },
                      ),
                      ListTile(
                        title: Text(
                          'Help'.tr,
                        ),
                        leading: Icon(
                          Icons.help_outline,
                          color: Black,
                        ),
                        onTap: () {
                          Get.to(() => Help(),
                              transition: Transition.rightToLeft);
                        },
                      ),
                      ListTile(
                        title: Text(
                          'App Info'.tr,
                        ),
                        leading: Icon(
                          Icons.info_outline,
                          color: Black,
                        ),
                        onTap: () =>
                        Get.to(() => AppInfo(),
                            transition: Transition.rightToLeft),
                      ),
                      ListTile(
                        title: Text(
                          'Logout'.tr,
                        ),
                        leading: Icon(
                          Icons.logout,
                          color: Black,
                        ),
                        onTap: () {
                          showDialog<void>(
                            context: context,
                            barrierDismissible: true, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Log Out'.tr),
                                content: SingleChildScrollView(
                                  child: Text('Are you sure to logout?'.tr),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Cancel'.tr),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Ok'.tr),
                                    onPressed: () async{

                                      try {

                                      OurFirebase.setStatus(false);

                                      await Get.delete<Maincontroller>();
                                      await Get.delete<Signupcontroller>();

                                      await Get.delete<Usercontroller>();
                                      await Get.delete<NavController>(force: true);

                                      localStorage.clear();
                                      

                                      Get.offAll(()=>const Signin());
                                      Get.snackbar("Logout Successfull".tr, "",snackPosition: SnackPosition.BOTTOM);

                                        
                                      } catch (e) {

                                        print(e);
                                        
                                      }
                                      
      
                                      // logoutUser();
                                      // _googleSignInController.googleSignOut();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        
          


    );
  }

}


  void  _launchURL(String url) async {
      print(Uri.https(Uri.encodeComponent(url)));
      // await launchUrl(Uri.https(Uri.encodeComponent(url)));
      await launchUrl(Uri.parse(url));

  }


void logoutUser() async {
  OurFirebase.setStatus(false);
  Get.reset();
  localStorage.clear();
  Get.put(Signupcontroller);
}