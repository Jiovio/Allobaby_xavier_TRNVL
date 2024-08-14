// import 'package:Allobaby/Config/Color.dart';
// import 'package:Allobaby/Screens/MainScreen/Controller/BottomSheetController.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/MainController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget symptoms(BuildContext context) {
  return 
  GetBuilder<Maincontroller>(
    init: Maincontroller(),
    builder: (controller) => 
  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 20, 20, 0),
          child: Text(
            "Do you have any of these Symptoms?",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
            height: 120.0,
            child: 
          
              ListView.separated(
                padding: EdgeInsets.only(left: 10, right: 10),
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  width: 10,
                ),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: symptomsList.length,
                itemBuilder: (BuildContext context, int index) =>
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: controller.bottomSheetData["symptoms"].contains(symptomsList[index].title)
                          //  controller.symptomsSelected.contains(index)
                              ? BorderSide(color: PrimaryColor, width: 1.5)
                              : null,
                          padding: EdgeInsets.all(14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () => 
                        controller.setbottomSheetDataArray(
                            "symptoms", symptomsList[index].title),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: controller.bottomSheetData["symptoms"].contains(symptomsList[index].title)
                                    // controller.symptomsSelected.contains(index)
                                        ? PrimaryColor
                                        : Colors.grey,
                              ),
                              child: Image.asset(
                                symptomsList[index].image,
                                height: 48,
                                width: 48,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              symptomsList[index].title,
                              style: TextStyle(
                                  color: controller.bottomSheetData["symptoms"].contains(symptomsList[index].title)
                                  // controller.symptomsSelected
                                  //         .contains(index)
                                      ? PrimaryColor
                                      : Black),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
              ),
            ),
        SizedBox(
          height: 40,
        ),
      ])

  );
}

List<Symptoms> symptomsList = [
  Symptoms(title: 'Normal', image: 'assets/BottomSheet/Symptoms/normal.png'),
  Symptoms(
      title: 'Body pain', image: 'assets/BottomSheet/Symptoms/boad_pain.png'),
  Symptoms(
      title: 'Burning Stomach',
      image: 'assets/BottomSheet/Symptoms/burning_in_stomach.png'),
  Symptoms(
      title: 'Cold cough', image: 'assets/BottomSheet/Symptoms/cold_cough.png'),
  Symptoms(
      title: 'Dizziness', image: 'assets/BottomSheet/Symptoms/dizziness.png'),
  Symptoms(
      title: 'Headache', image: 'assets/BottomSheet/Symptoms/headache.png'),
  Symptoms(title: 'Vomiting', image: 'assets/BottomSheet/Symptoms/vomiting.png')
];

class Symptoms {
  String title;
  String image;
  Symptoms({required this.title, required this.image});
}
