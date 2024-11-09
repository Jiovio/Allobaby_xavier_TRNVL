// import 'package:Allobaby/Config/Color.dart';
// import 'package:Allobaby/Screens/MainScreen/Controller/BottomSheetController.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/MainController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget waterCount() {
  return GetBuilder<Maincontroller>(
    init: Maincontroller(),
    builder: (controller) => 
  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
     const Padding(
        padding: EdgeInsets.fromLTRB(20.0, 10, 20, 0),
        child:  Text(
          "How many Glass of water have you drunk today?",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Container(
          height: 38.0,
          child: 
        
              ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                        width: 4,
                      ),
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: controller.bottomSheetData["glassOfWater"],
                  itemBuilder: (BuildContext context, int index) => Container(
                        height: 38,
                        width: 38,
                        child: Image.asset(
                          'assets/BottomSheet/glass-of-water.png',
                        ),
                      ))
                      
                      ),
        Column(
          children: [
            Text( " ${controller.bottomSheetData["glassOfWater"]} Glass ",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: PrimaryColor),
            ),
            Slider(
              value: controller.bottomSheetData["glassOfWater"].toDouble(),
              onChanged: (value) {
                var v = value.round();
                controller.setBottomSheetData("glassOfWater", v);
              },
              min: 0,
              max: 8,
              divisions: 8,
            ),
          ],
        ),
      
      SizedBox(
        height: 20,
      ),
    ],
  )
  );
}
