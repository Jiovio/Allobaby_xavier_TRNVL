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

class Urinetestcontroller extends GetxController {


    @override
    void onInit(){
      super.onInit();

      Selfscreeningcontroller cont = Get.find<Selfscreeningcontroller>();


      if(cont.urineTestId!=null){

        print(cont.urineTestId);

      }
    }

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

TextEditingController desc = TextEditingController();
String? alphaminePresent = null;
String? sugarPresent = null;

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
        // if(image==null){
        //   showToast("Please Upload Image", false);
        //   return;
        // }

           if(created.value == true){
      return;
    }

        if(alphaminePresent==null){
          showToast("Please Select Alphamine Present", false);
          return;
        }

                        if(sugarPresent==null){
          showToast("Please Select Sugar Present", false);
          return;
        }

        //         if(image==null){
        //   showToast("Please Upload Image", false);
        //   return;
        // }

        // if(desc.text==""){
        //   showToast("Please Update Description", false);
        //   return;
        // }

      startLoading();
    Map<String,dynamic> reportData = {
      "alphaminePresent":alphaminePresent,
      "sugarPresent":sugarPresent
    };

var d = await Userapi.getUser();

    String phone = d["phone_number"];
        var random = Random();
  int randomInt = random.nextInt(1000000);

    String?  url ;

    if(image!=null){
   url = await OurFirebase.uploadImageToFirebase("reports","$phone $randomInt.jpg", image!,phone);
    }
    
    
        Map<String,dynamic> data = {
      "reportType":"Urine",
      "details":reportData,
      "imageurl":url,
      "description":desc.text,
    };

   final req = await Reportapi().newaddReports(data);

      if(req.success){
    showToast(req.detail, true);
    print(req.id);
    controller.urineTestId = req.id;


    final selfscreeningreq = await SelfscreeningApi.create({
      "urineTestId" : req.id,
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

    stopLoading();

    showToast("Report Saved Successfully .", true);
    
    created.value = true;
    controller.update();
  }

    Future<void> askAI(File img) async {

      String prompt = """This is a health report. 
      give me Alpamine present , Sugar present and the general summary in the schema 
      {alphaminePresent: "Yes" or "No",
      sugarPresent:"Yes" or "No",
      summary:string}""";
      dynamic res = json.decode(await OurFirebase.askVertexAi(image!, prompt));

      print(res);
      desc.text = res["summary"]??"";
      // 
      alphaminePresent = res["alphaminePresent"]??null;
      sugarPresent = res["sugarPresent"]??null;


      
      // 
      update();
  }
}