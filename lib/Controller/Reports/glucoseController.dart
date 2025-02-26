
import 'dart:math';

import 'package:allobaby/API/Requests/ReportAPI.dart';
import 'package:allobaby/API/Requests/SelfScreeningAPI.dart';
import 'package:allobaby/API/Requests/Userapi.dart';
import 'package:allobaby/Components/Loadingbar.dart';
import 'package:allobaby/Components/snackbar.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Config/OurFirebase.dart';
import 'package:allobaby/Screens/Home/Report/Report.dart';
import 'package:allobaby/Screens/Home/Screening/Controllers/SelfScreeningController.dart';
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

        RxBool loading = false.obs;

    startLoading(){
      loading = true.obs;
      update();
    }

     stopLoading(){
      loading = false.obs;
      update();
    }


double? glucoseValue ;

TextEditingController desc = TextEditingController();

   File? image;

  final picker = ImagePicker();

  var fileImage64;

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



  Selfscreeningcontroller controller = Get.put(Selfscreeningcontroller());
RxBool created = false.obs;
      Future<void> submit () async {

                   if(created.value == true){
      return;
    }


        //          if(image==null){
        //   showToast("Please Upload Image", false);
        //   return;
        // }

        if(glucoseValue==null){
          showToast("Please Select Glucose Value", false);
          return;
        }

        // if(desc.text==""){
        //   showToast("Please Update Description", false);
        //   return;
        // }



        startLoading();
    Map<String,dynamic> reportData = {
      "glucose":glucoseValue,

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
      "reportType":"Glucose",
      "details":reportData,
      "reportFile":fileImage64,
      "imageurl":url,
      "description":desc.text,
      "phone":phone
    };


   final req =  await Reportapi().newaddReports(data);


   if(req.success){
    showToast(req.detail, true);

    created.value = true;
    print(req.id);
    controller.glucoseTestId = req.id;


    final selfscreeningreq = await SelfscreeningApi.create({
      "glucodeId" : req.id,
      "params" : reportData,
      "id" : controller.screeningId
      });

    if(selfscreeningreq.success){

      if(selfscreeningreq.created){
        controller.screeningId = selfscreeningreq.id;
      }

    }


   }
    controller.update();

    showToast("Report Saved Successfully .", true);

    stopLoading();


    // showToast("Please Enter All Details",'Fields are empty. please enter all fields.');


  }



      Future<void> askAI(File img) async {

      String prompt = """This is a health report. 
      give me bloodGlucose value and the general summary in the schema 
      {glucoseValue: double ,
      summary:string}""";
      dynamic res = json.decode(await OurFirebase.askVertexAi(image!, prompt));

      print(res);
      desc.text = res["summary"]??"";
      // 
      glucoseValue= res["glucoseValue"]??70.0;

      // 
      update();
  }
}