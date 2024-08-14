import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Screens/Settings/AppInfo.dart';
import 'package:allobaby/Screens/Settings/EditProfile.dart';
import 'package:allobaby/Screens/Settings/Help.dart';
import 'package:allobaby/Screens/Settings/SubscriptionViewApp.dart';
import 'package:allobaby/Screens/Settings/hospital.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:allobaby/Components/languagedialog.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
                        "Settings",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: darkGrey2),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.notifications_none_rounded,
                          color: Black800,
                        ),
                        onPressed: () {} 
                        // Get.to(() => NotificationView(),
                        //     transition: Transition.rightToLeft),
                      )
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
                        //  Obx(() =>
                        CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 36.0,
                            child: Image.asset(
                                "assets/General/avatar.png") //  MemoryImage(base64Decode(
                            //     mainScreenController
                            //         .patientDetails[0].imageUrl)
                            // )
                            // )
                            ),
                        SizedBox(
                          width: 24.0,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                    "Senthil Kumar",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800),
                                  ),
                              SizedBox(
                                height: 4,
                              ),
                              Text("SenthilKumar@gmail.com"),
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
                          'Edit Profile',
                        ),
                        leading: Icon(
                          Icons.edit,
                          color: Black,
                        ),
                        onTap: () {
                          Get.to(EditProfile());
                        },
                        // settingsController.getPatientDetails(),
                      ),

                                            ListTile(
                        title: Text(
                          'My Hospital',
                        ),
                        leading: Icon(
                          Icons.local_hospital,
                          color: Black,
                        ),
                        onTap: () {
                          Get.to(() => MyHospital(),
                              transition: Transition.rightToLeft);
                        },
                      ),


                      ListTile(
                        title: Text(
                          'My Subscription',
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
                          'Notification',
                        ),
                        leading: Icon(
                          Icons.notifications_none_outlined,
                          color: Black,
                        ),
                        subtitle: Text("YES"),
                        // Obx(() => Text(
                        //       settingsController.nIcon.value == false
                        //           ? "ON"
                        //           : "OFF",
                        //     )),
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
                                      leading: ValueBuilder<bool?>(
                                        initialValue: true,
                                            // settingsController.nIcon.value
                                            //     ? false
                                            //     : true,
                                        builder: (isChecked, updateFn) =>
                                            Switch(
                                          activeColor: PrimaryColor,
                                          value: isChecked!,
                                          onChanged: (newValue) {
                                            // settingsController.nIcon.value =
                                            //     !settingsController.nIcon.value
                                            //         .obs();
                                            // settingsController.update();
                                            // updateFn(newValue);
                                          },
                                        ),
                                      ))));
                        },
                      ),
                      
                      
                      ListTile(
                        title: Text(
                          'Language'.tr,
                        ),
                        subtitle: Text("English"),
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
                        onTap: () =>
                        languageSelectDialog(context),
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
                              'https://www.jiovio.com/jioviopolicy.php';
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
                              'https://www.jiovio.com/jioviopolicy.php';
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
                                title: const Text('Log Out'),
                                content: SingleChildScrollView(
                                  child: Text('Are you sure to logout?'),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Ok'),
                                    onPressed: () async{
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

    _launchURL(String url) async {
      await launchUrl(Uri.https(url));
    if (await canLaunchUrl(Uri.https(url))) {
      await launchUrl(Uri.https(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}