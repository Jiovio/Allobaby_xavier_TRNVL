import 'dart:math';

import 'package:allobaby/API/Requests/Userapi.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Config/OurFirebase.dart';
import 'package:allobaby/Screens/Home/Report/Report.dart';
import 'package:allobaby/db/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'dart:io' as Io;
import 'dart:convert' as convert;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class Ultrasoundcontroller extends GetxController {

int hemoGlobinValue = 12;


String? fetalPresentation = null;
String? fetalMovement = null;
String? Placenta = null;

TextEditingController desc = TextEditingController();
String alphaminePresent = "";
String sugarPresent = "";


   int heartRate = 60;
  late File image;

  final picker = ImagePicker();

  var fileImage64;

  Future getImageFromCamera() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 20);
    if (pickedFile != null) {
      final bytes = await Io.File(pickedFile.path).readAsBytes();
      fileImage64 = convert.base64Encode(bytes);
      image = File(pickedFile.path);
      askAI(image);
      Fluttertoast.showToast(
          msg: "Report Updated Successfully", backgroundColor: PrimaryColor);
    } else {
      print('No image selected.');
    }
    update();
  }

    Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    );
    if (pickedFile != null) {
      final bytes = await Io.File(pickedFile.path).readAsBytes();
      fileImage64 = convert.base64Encode(bytes);
      image = File(pickedFile.path);
      askAI(image);
      Fluttertoast.showToast(
          msg: "Report Updated Successfully", backgroundColor: PrimaryColor);
    } else {
      print('No image selected.');
    }
    update();
  }

      Future<void> submit () async {
    Map<String,dynamic> reportData = {
      "fetalPresentation":fetalPresentation,
      "fetalMovement":fetalMovement,
      "placenta":Placenta,
      "heartRate":heartRate
    };

var d = await Userapi.getUser();

    String phone = d["phone_number"];
        var random = Random();
  int randomInt = random.nextInt(1000000);

String  url = await OurFirebase.uploadImageToFirebase(phone,"reports","$phone $randomInt.jpg", image);
    Map<String,dynamic> data = {
      "reportType":"Ultra Sound",
      "details":json.encode(reportData),
      "reportFile":fileImage64,
      "imageurl":url,
      "description":desc.text,
      "phone":phone
    };


  
  // Generates a random integer between 0 and 99
    addReports(data);

  data["created"] = DateTime.now().toString();

    OurFirebase.createDataWithName("reports","$phone $randomInt",data);


    print(data);

    Get.to(Report());

    // showToast("Please Enter All Details",'Fields are empty. please enter all fields.');
  }

      Future<void> askAI(File img) async {

      String prompt = """This is a health report. 
      give me Fetal Presentation , Fetal Movement, Placenta, Heart Rate and the general summary in the schema 
      {fetalPresentation: string,
      fetalMovement:string,
      placenta : string,
      heartRate:int,
      summary:string}""";
      dynamic res = json.decode(await OurFirebase.askVertexAi(image, prompt));

      print(res);
      desc.text = res["summary"]??"";
      // 
      fetalMovement = res["fetalMovement"]??null;
      fetalPresentation = res["fetalPresentation"]??null;
      Placenta = res["placenta"]??null;
      heartRate = res["heartRate"]??null;




      // 
      update();
  }


}