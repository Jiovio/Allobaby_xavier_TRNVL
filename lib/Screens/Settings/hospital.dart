import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Screens/Settings/AppInfo.dart';
import 'package:allobaby/Screens/Settings/EditProfile.dart';
import 'package:allobaby/Screens/Settings/Help.dart';
import 'package:allobaby/Screens/Settings/SubscriptionViewApp.dart';
import 'package:allobaby/Screens/Settings/ViewHospital.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:allobaby/Components/languagedialog.dart';

class MyHospital extends StatelessWidget {
  const MyHospital({super.key});

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
                        "My Hospital",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: darkGrey2),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.local_hospital,
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
              child: 
              Column(
                children: [
                    Container(
                      padding: EdgeInsets.only(right: 15, left: 15),
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white38.withOpacity(0.4),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                       child: Theme(
                        data: ThemeData(
                          textTheme: const TextTheme(
                              titleMedium: TextStyle(color: PrimaryColor)),
                        ),
                        child: DropdownSearch<String>(
                          validator: (v) =>
                              v == null ? "Select Hospital".tr : null,
                          popupProps: PopupProps.menu(
                            // modalBottomSheetProps: ModalBottomSheetProps(
                            //   shape:BeveledRectangleBorder(borderRadius: BorderRadius.zero)
                            // ),
                            // showSearchBox: true,
                            showSelectedItems: true,
                          ),
                          
                          // label: "Select Doctor",
                          items: ["JioVio", "Savemom"],
                          dropdownDecoratorProps: DropDownDecoratorProps(
                             dropdownSearchDecoration:InputDecoration(
                              border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide:
                                  BorderSide(width: 3, color: Colors.grey),
                            ),
                            labelText: "Select Hospital".tr,
                            labelStyle: const TextStyle(color: Black),
                          )
                          )
                         ,
                          // maxHeight: Get.height * 0.15,
                          onChanged: (value) {
                            Get.to(Viewhospital());
                          },
                        ),
                          )),
                    SizedBox(
                        height: 18,
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