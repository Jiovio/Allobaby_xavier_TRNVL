
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/db/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'dart:io' as Io;
import 'dart:convert' as convert;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
class Fetalmonitoringcontroller extends GetxController {


int heartRate = 60;
int kickCount = 0;

TextEditingController desc = TextEditingController();

  late File image;

  final picker = ImagePicker();

  var fileImage64;


  void updateHeartRate(value) {
    print(value);
          heartRate = value;
          update();
  }

  Future getImageFromCamera() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 20);
    if (pickedFile != null) {
      final bytes = await Io.File(pickedFile.path).readAsBytes();
      fileImage64 = convert.base64Encode(bytes);
      image = File(pickedFile.path);
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
      Fluttertoast.showToast(
          msg: "Report Updated Successfully", backgroundColor: PrimaryColor);
    } else {
      print('No image selected.');
    }
    update();
  }


      void submit (){
    Map<String,dynamic> reportData = {
      "kickCount":kickCount,
      "heartRate":heartRate

    };

    Map<String,dynamic> data = {
      "reportType":"Fetal Monitoring",
      "details":json.encode(reportData),
      "reportFile":fileImage64,

    };

    addReports(data);

    // showToast("Please Enter All Details",'Fields are empty. please enter all fields.');
  }


}