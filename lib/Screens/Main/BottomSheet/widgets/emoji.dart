import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/MainController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


Column emojiPage() {
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
              "Hi!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "How do you feel today?",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      Center(
        child: Container(
            height: 120.0,
            child: ListView.separated(
                padding: EdgeInsets.only(left: 10, right: 10),
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                      width: 10,
                    ),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: emojiList.length,
                itemBuilder: (BuildContext context, int index) =>
                    emojis(index))),
      ),
      SizedBox(
        height: 40,
      ),
    ],
  );
}

Widget emojis(int index) {

  var val = emojiList[index].title;

  return  GetBuilder<Maincontroller>(
    init: Maincontroller(),
    builder: (controller) =>  
   TextButton(
          style: TextButton.styleFrom(
              padding: EdgeInsets.all(14),
              shape: controller.bottomSheetData["feeling"]==val
                  ? RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: PrimaryColor, width: 1.5))
                  : null,
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          onPressed: () {
            controller.setBottomSheetData("feeling",val);
          },
          child: Column(
            children: [
              Image.asset(emojiList[index].emoji, height: 58, width: 58),
              SizedBox(
                height: 10,
              ),
              Text(
                emojiList[index].title,
                style: TextStyle(
                    color:controller.bottomSheetData["feeling"]==val ? PrimaryColor : Black),
              ),
            ],
          )));
}

List<Emojis> emojiList = [
  Emojis(title: 'Good', emoji: 'assets/BottomSheet/Emojis/good.png'),
  Emojis(title: 'Happy', emoji: 'assets/BottomSheet/Emojis/happy.png'),
  Emojis(title: 'Cool', emoji: 'assets/BottomSheet/Emojis/cool.png'),
  Emojis(title: 'Smile', emoji: 'assets/BottomSheet/Emojis/smile.png'),
  Emojis(title: 'Angry', emoji: 'assets/BottomSheet/Emojis/angry.png')
];

class Emojis {
  String title;
  String emoji;
  Emojis({required this.title, required this.emoji});
}




