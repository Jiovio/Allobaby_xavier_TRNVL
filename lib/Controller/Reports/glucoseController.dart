
import 'dart:math';

import 'package:allobaby/API/Requests/ReportAPI.dart';
import 'package:allobaby/API/Requests/Userapi.dart';
import 'package:allobaby/Components/snackbar.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Config/OurFirebase.dart';
import 'package:allobaby/Screens/Home/Report/Report.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/BloodGlucose.dart';
import 'package:allobaby/db/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'dart:io' as Io;
import 'dart:convert' as convert;
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
class Glucosecontroller extends GetxController {


double glucoseValue = 70;

TextEditingController desc = TextEditingController();

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
      "glucose":glucoseValue,

    };

    var d = await Userapi.getUser();

    String phone = d["phone_number"];
   var random = Random();
  int randomInt = random.nextInt(1000000);

String  url = await OurFirebase.uploadImageToFirebase("reports","$phone $randomInt.jpg", image,phone,);

    Map<String,dynamic> data = {
      "reportType":"Glucose",
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

    await Reportapi().addReports(data);

    showToast("Report Added Successfully",true);

    Get.to(Report());


    // showToast("Please Enter All Details",'Fields are empty. please enter all fields.');


  }



      Future<void> askAI(File img) async {

      String prompt = """This is a health report. 
      give me bloodGlucose value and the general summary in the schema 
      {glucoseValue: double ,
      summary:string}""";
      dynamic res = json.decode(await OurFirebase.askVertexAi(image, prompt));

      print(res);
      desc.text = res["summary"]??"";
      // 
      glucoseValue= res["glucoseValue"]??70.0;

      // 
      update();
  }
}