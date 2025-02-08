import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Screens/Chat/ChatScreen.dart';
import 'package:allobaby/Screens/Main/Home.dart';
import 'package:allobaby/Screens/Service/ServiceScreen.dart';
import 'package:allobaby/Screens/Settings/Settings.dart';
// import 'package:Allobaby/Screens/Chat/View/ChatScreen.dart';
// import 'package:Allobaby/Screens/Home/View/HomeScreen.dart';
// import 'package:Allobaby/Screens/Service/View/ServiceScreen.dart';
// import 'package:Allobaby/Screens/Settings/View/SettingsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final NavController navController = Get.put(NavController());
final List<Widget> bodyRoutes = <Widget>[
  Home(),
  ServiceScreen(),
  ChatScreen(),
  SettingsScreen(),
];

Obx bottomNavigationBar() {
  return Obx(
    () => Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 8,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        navController.selectedIndex.value = 0;
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.home_outlined,
                            color: navController.selectedIndex.value == 0
                                ? PrimaryColor
                                : Colors.grey,
                          ),
                          Text(
                            "Home".tr,
                            style: TextStyle(
                              fontSize: 12,
                              color: navController.selectedIndex.value == 0
                                  ? PrimaryColor
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        navController.selectedIndex.value = 1;
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            color: navController.selectedIndex.value == 1
                                ? PrimaryColor
                                : Colors.grey,
                          ),
                          Text(
                            "Service".tr,
                            style: TextStyle(
                              fontSize: 12,
                              color: navController.selectedIndex.value == 1
                                  ? PrimaryColor
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        navController.selectedIndex.value = 2;
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            color: navController.selectedIndex.value == 2
                                ? PrimaryColor
                                : Colors.grey,
                          ),
                          Text(
                            "Chat".tr,
                            style: TextStyle(
                              fontSize: 12,
                              color: navController.selectedIndex.value == 2
                                  ? PrimaryColor
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        navController.selectedIndex.value = 3;
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.settings_outlined,
                            color: navController.selectedIndex.value == 3
                                ? PrimaryColor
                                : Colors.grey,
                          ),
                          Text(
                            "Settings".tr,
                            style: TextStyle(
                              fontSize: 12,
                              color: navController.selectedIndex.value == 3
                                  ? PrimaryColor
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // BottomNavigationBar(
        //   type: BottomNavigationBarType.fixed,
        //   items: [
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.home_outlined), label: 'Home'),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.auto_awesome), label: 'Service'.tr),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.settings_outlined), label: 'Settings')
        //   ],
        //   currentIndex: navController.selectedIndex.value,
        //   onTap: (index) => navController.selectedIndex.value = index,
        // ),
      ],
    ),
  );
}

//NavController
class NavController extends GetxController {
  var selectedIndex = 0.obs;
}
