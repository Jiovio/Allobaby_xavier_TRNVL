import 'dart:convert';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/MainController.dart';
import 'package:allobaby/Screens/Service/HealthProfile.dart';
import 'package:allobaby/Screens/Signin.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'languageDialog.dart';

PreferredSize customAppBar(
    {required String title, required BuildContext context}) {
  // MainScreenController mainScreenController = Get.put(MainScreenController());
  // print(mainScreenController.patientDetails[0].imageUrl);

  Maincontroller controller = Get.put(Maincontroller());
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


                      controller.profile_pic==null?
                                              CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 13.0,
                              backgroundImage: AssetImage(
                                "assets/General/avatar.png"
                              ),
                              
                                              ):

SizedBox(
  child: Container(
    width: 26.0,  // Circle diameter (2 * radius)
    height: 26.0,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(
        image: CachedNetworkImageProvider(controller.profile_pic as String),
        fit: BoxFit.cover,
      ),
    ),
    child: CircleAvatar(
      radius: 13.0,
      backgroundColor: Colors.transparent,  // To ensure only image shows
    ),
  ),
)


                          
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ));
}
