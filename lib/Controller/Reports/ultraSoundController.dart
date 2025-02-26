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

        RxBool loading = false.obs;

    startLoading(){
      loading = true.obs;
      update();
    }

     stopLoading(){
      loading = false.obs;
      update();
    }

int hemoGlobinValue = 12;


String? fetalPresentation = null;
String? fetalMovement = null;
String? Placenta = null;

TextEditingController desc = TextEditingController();
String alphaminePresent = "";
String sugarPresent = "";


   int? heartRate;
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
        //                  if(image==null){
        //   showToast("Please Upload Image", false);
        //   return;
        // }

                   if(created.value == true){
      return;
    }


        if(fetalPresentation==null){
          showToast("Please Select Fetal Presentation", false);
          return;
        }

                if(fetalMovement==null){
          showToast("Please Select Fetal Movement", false);
          return;
        }


                        if(Placenta==null){
          showToast("Please Select Placenta", false);
          return;
        }


        if(heartRate==null){
          showToast("Please Enter Heart Rate", false);
          return;
        }



        // if(desc.text==""){
        //   showToast("Please Update Description", false);
        //   return;
        // }


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

String?  url;

    if(image!=null){
   url = await OurFirebase.uploadImageToFirebase("reports","$phone $randomInt.jpg", image!,phone);
    }
    
    
     Map<String,dynamic> data = {
      "reportType":"Ultra Sound",
      "details":reportData,
      "imageurl":url,
      "description":desc.text,
    };

  final req =  await Reportapi().newaddReports(data);

    if(req.success){
    showToast("Report Saved Successfully .", true);
    print(req.id);
    controller.ultrasoundId = req.id;


    final selfscreeningreq = await SelfscreeningApi.create({
      "ultrasoundId" : req.id,
      "params" : reportData,
      "appointmentID": controller.appointmentid,
      "id" : controller.screeningId
      });

    if(selfscreeningreq.success){

      if(selfscreeningreq.created){
        controller.screeningId = selfscreeningreq.id;
      }


      

    }


   }

   created.value = true;
    controller.update();

    stopLoading();
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
      dynamic res = json.decode(await OurFirebase.askVertexAi(image!, prompt));

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