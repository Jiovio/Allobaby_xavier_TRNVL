import 'dart:convert';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Screens/Service/HealthProfile.dart';
// import 'package:Allobaby/Screens/Home/Health%20Profile%20Details/View/healthProfileDetails.dart';
// import 'package:Allobaby/Screens/MainScreen/Controller/MainScreenController.dart';
// import 'package:Allobaby/Screens/Settings/View/subscription/Subscription.dart';
// import 'package:Allobaby/Screens/Notification/View.dart';
import 'package:allobaby/Screens/Signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'languageDialog.dart';

PreferredSize customAppBar(
    {required String title, required BuildContext context}) {
  // MainScreenController mainScreenController = Get.put(MainScreenController());
  // print(mainScreenController.patientDetails[0].imageUrl);
  return PreferredSize(
      preferredSize: Size.fromHeight(100.0),
      child: Material(
        elevation: 1,
        surfaceTintColor: White,
        color: White,
        child: Container(
          padding: EdgeInsets.only(top: 24, bottom: 8),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: darkGrey2),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.translate_rounded,
                        color: Black800,
                      ),
                      onPressed: () => languageSelectDialog(context),
                    ),
                    // IconButton(
                    //   icon: Icon(
                    //     Icons.notifications_none_rounded,
                    //     color: Black800,
                    //   ),
                    //   onPressed: () => Get.to(() => NotificationView(),
                    //       transition: Transition.rightToLeft),
                    // ),
                    SizedBox(
                      width: 6,
                    ),
                    // Obx(() =>
                    GestureDetector(
                      onTap: () => Get.to(() => Healthprofile(),
                          transition: Transition.rightToLeft),
                      child:
                          // mainScreenController.patientDetails[0].imageUrl
                          //         .contains('.png')
                          //     ?
                          CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 10.0,
                              child: Image.asset(
                                  "assets/General/avatar.png")
                                  ) // : CircleAvatar(
                      //     backgroundColor: Colors.transparent,
                      //     radius: 16.0,
                      //     backgroundImage: MemoryImage(base64Decode(
                      //         mainScreenController
                      //             .patientDetails[0].imageUrl)))
                      ,
                      // )
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ));
}
