// import 'package:Allobaby/Config/Color.dart';
// import 'package:Allobaby/Screens/MainScreen/Controller/BottomSheetController.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/MainController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Column exercise() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Padding(
        padding: EdgeInsets.fromLTRB(20.0, 10, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Exercise that have you done today?",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      Container(
        height: 120.0,
        child: 
        GetBuilder<Maincontroller>(
          init: Maincontroller(),
            builder: (controller) => 
            
            ListView.separated(
                padding: EdgeInsets.only(left: 10, right: 10),
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                      width: 10,
                    ),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: emojiList.length,
                itemBuilder: (BuildContext context, int index) =>
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: controller.bottomSheetData["exercises"].contains(index)
                            
                            // controller.exerciseSelected.contains(index)
                                ? BorderSide(color: PrimaryColor, width: 1.5)
                                : null,
                            padding: EdgeInsets.all(14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            textStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        onPressed: 
                        () => 
                        controller.setbottomSheetDataArray("exercises",index),
                        child: emojiList[index] == "none"
                            ? Center(child: Text("None"))
                            : Image.asset(emojiList[index],
                                height: 58, width: 58))),
        )
      
      ),
      SizedBox(
        height: 40,
      ),
    ],
  );
}

List emojiList = [
  'none',
  'assets/BottomSheet/Yoga/yoga.png',
  'assets/BottomSheet/Yoga/extended.png',
  'assets/BottomSheet/Yoga/corpse.png',
  'assets/BottomSheet/Yoga/cobra.png',
  'assets/BottomSheet/Yoga/head.png',
  'assets/BottomSheet/Yoga/chair.png',
  'assets/BottomSheet/Yoga/awkward.png',
  'assets/BottomSheet/Yoga/fish.png',
];
