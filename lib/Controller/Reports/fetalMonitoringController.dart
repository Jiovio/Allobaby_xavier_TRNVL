
import 'dart:math';

import 'package:allobaby/API/Requests/ReportAPI.dart';
import 'package:allobaby/API/Requests/Userapi.dart';
import 'package:allobaby/Components/Loadingbar.dart';
import 'package:allobaby/Components/snackbar.dart';
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
class Fetalmonitoringcontroller extends GetxController {

        RxBool loading = false.obs;

    startLoading(){
      loading = true.obs;
      update();
    }

     stopLoading(){
      loading = false.obs;
      update();
    }


int? heartRate;
int kickCount = 0;

TextEditingController desc = TextEditingController();

   File? image;

  final picker = ImagePicker();

  var fileImage64;


  void updateHeartRate(value) {
    print(value);
          heartRate = value;
          update();
  }

  Future getImageFromCamera(context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 20);
    if (pickedFile != null) {
      final bytes = await Io.File(pickedFile.path).readAsBytes();
      fileImage64 = convert.base64Encode(bytes);
      image = File(pickedFile.path);
      Navigator.of(context).pop();
            Loadingbar.use("Analyzing Report", () async {
        await askAI(image!);
      });
      Fluttertoast.showToast(
          msg: "Report Updated Successfully", backgroundColor: PrimaryColor);
    } else {
      print('No image selected.');
    }
    update();
  }

    Future<void> getImageFromGallery(context) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    );
    if (pickedFile != null) {
      final bytes = await Io.File(pickedFile.path).readAsBytes();
      fileImage64 = convert.base64Encode(bytes);
      image = File(pickedFile.path);
      Navigator.of(context).pop();
            Loadingbar.use("Analyzing Report", () async {
        await askAI(image!);
      });
      Fluttertoast.showToast(
          msg: "Report Updated Successfully", backgroundColor: PrimaryColor);
    } else {
      print('No image selected.');
    }
    update();
  }


      Future<void> submit () async {

        //          if(image==null){
        //   showToast("Please Upload Image", false);
        //   return;
        // }

        if(heartRate==null){
          showToast("Please Enter Heart Rate", false);
          return;
        }

        // if(desc.text==""){
        //   showToast("Please Update Description", false);
        //   return;
        // }



        startLoading();
    Map<String,dynamic> reportData = {
      "kickCount":kickCount,
      "heartRate":heartRate

    };

    var d = await Userapi.getUser();

    String phone = d["phone_number"];
        var random = Random();
  int randomInt = random.nextInt(1000000);

String  url = "";

    if(image!=null){
   url = await OurFirebase.uploadImageToFirebase("reports","$phone $randomInt.jpg", image!,phone);
    }

    
    Map<String,dynamic> data = {
      "reportType":"Fetal Monitoring",
      "details":reportData,
      "imageurl":url,
      "description":desc.text,
    };
      await Reportapi().addReports(data);

      stopLoading();
  }

  

      Future<void> askAI(File img) async {

      String prompt = """This is a health report. 
      give me HeartRate value and the general summary in the schema 
      {heartRateValue: int ,
      summary:string}""";
      dynamic res = json.decode(await OurFirebase.askVertexAi(image!, prompt));

      print(res);
      desc.text = res["summary"]??"";
      // 
      heartRate= res["heartRateValue"]??60;

      // 
      update();
  }


}