import 'package:allobaby/API/Requests/ReportAPI.dart';
import 'package:allobaby/API/Requests/SelfScreeningAPI.dart';
import 'package:allobaby/API/Requests/Userapi.dart';
import 'package:allobaby/API/authAPI.dart';
import 'package:allobaby/Components/Loadingbar.dart';
import 'package:allobaby/Components/snackbar.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Config/OurFirebase.dart';
import 'package:allobaby/Screens/Home/Report/Report.dart';
import 'package:allobaby/Screens/Home/Screening/Controllers/SelfScreeningController.dart';
import 'package:allobaby/Screens/Home/Screening/SelfScreening.dart';
import 'package:allobaby/db/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'dart:io' as Io;
import 'dart:convert' as convert;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:math';
class Hemoglobincontroller extends GetxController {

      RxBool loading = false.obs;





      

    startLoading(){
      loading = true.obs;
      update();
    }

     stopLoading(){
      loading = false.obs;
      update();
    }


int? hemoGlobinValue ;

TextEditingController desc = TextEditingController();

String url = "";

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
      // askAI(image);

      Loadingbar.use("Analyzing Report", () async {

        try {
          await askAI(image!);
        } catch (e) {
          print(e);
          
        }
        
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
      
        if(hemoGlobinValue==null){
          showToast("Please Select Hemoglobin Value", false);
          return;
        }

        // if(desc.text==""){
        //   showToast("Please Update Description", false);
        //   return;
        // }

        

    startLoading();

    Map<String,dynamic> reportData = {
      "hemoglobinValue":hemoGlobinValue,
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
      "reportType":"Hemoglobin",
      "details":reportData,
      "imageurl":url,
      "description":desc.text,
    };
   final req =  await Reportapi().newaddReports(data);


   if(req.success){
    showToast(req.detail, true);
    print(req.id);
    controller.hemoglobinId = req.id;


    final selfscreeningreq = await SelfscreeningApi.create({
      "hemoglobinId" : req.id,
      "params" : reportData,
      "id" : controller.screeningId,
      "appointmentID": controller.appointmentid,
      });

    if(selfscreeningreq.success){

      if(selfscreeningreq.created){
        controller.screeningId = selfscreeningreq.id;
      }

    }


   }
    controller.update();


    created.value = true;

    stopLoading();

    


    
  }

  
  Future<void> askAI(File img) async {

      String prompt = """This is a health report. 
      give me hemoglobin value and the general summary in the schema 
      {hemoglobinValue:int,
      summary:string}""";
      dynamic res = json.decode(await OurFirebase.askVertexAi(image!, prompt));
      desc.text = res["summary"]??"";
      // 
      hemoGlobinValue = res["hemoglobinValue"] ?? "_";

      update();


  }


  Future<void> uploadImage(File image) async {

  final spaceRef = OurFirebase.storageRef.child("/space.jpg");

  print(spaceRef.bucket);

  try {

 var upl =  await spaceRef.putFile(image);
 print(await spaceRef.getDownloadURL());

  print("Uploaded");
    } catch (e) {

    }

  }





}