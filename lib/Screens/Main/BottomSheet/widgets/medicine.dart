// import 'package:Allobaby/Config/Color.dart';
// import 'package:Allobaby/Screens/MainScreen/Controller/BottomSheetController.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/MainController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Column medicine() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Padding(
        padding: EdgeInsets.fromLTRB(20.0, 10, 20, 0),
        child: Text(
          "Select tablets that you have taken".tr,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Center(
        child: Container(
            height: 120.0,
            child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                      width: 10,
                    ),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: medicineList.length,
                itemBuilder: (BuildContext context, int index) =>
                    medicineListView(index))),
      ),
      SizedBox(
        height: 40,
      ),
    ],
  );
}

Widget medicineListView(int index) {

  String val = medicineList[index].title;
  return 
  
  GetBuilder<Maincontroller>(
    init: Maincontroller(),
      builder: (controller) => 
      OutlinedButton(
          style: OutlinedButton.styleFrom(
              side: controller.bottomSheetData["tabletsTaken"].contains(val)
                  ? BorderSide(color: PrimaryColor, width: 1.5)
                  : null,
              padding: EdgeInsets.all(14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          onPressed: () => 
          controller.setbottomSheetDataArray("tabletsTaken",val),
          child: Column(
            children: [
              Image.asset(medicineList[index].medicine, height: 58, width: 58),
              SizedBox(
                height: 10,
              ),
              Text(
                medicineList[index].title,
                style: TextStyle(
                    color:
                    controller.bottomSheetData["tabletsTaken"].contains(val)
                        ? PrimaryColor
                        : darkGrey2),
              ),
            ],
          ))
  );

}

List<MedicineClass> medicineList = [
  // MedicineClass(
  //     title: 'Vitamin C', medicine: 'assets/BottomSheet/Medicine/drug.png'),
  MedicineClass(
      title: 'Folic Acid', medicine: 'assets/BottomSheet/Medicine/drug.png'),
  // MedicineClass(
  //     title: 'Zinc', medicine: 'assets/BottomSheet/Medicine/vitamins.png'),
  MedicineClass(
      title: 'Iron', medicine: 'assets/BottomSheet/Medicine/vitamins.png'),
  MedicineClass(
      title: 'Calcium', medicine: 'assets/BottomSheet/Medicine/vitamins.png'),
  MedicineClass(title: 'Other', medicine:'assets/BottomSheet/Medicine/drug.png'),
  // MedicineClass(
  //     title: 'Anti Viral', medicine: 'assets/BottomSheet/Medicine/vitamin.png'),
];

class MedicineClass {
  String title;
  String medicine;
  MedicineClass({required this.title, required this.medicine});
}
