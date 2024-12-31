

import 'dart:io';

import 'package:allobaby/API/Requests/Userapi.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Config/OurFirebase.dart';
import 'package:allobaby/Controller/MainController.dart';
import 'package:allobaby/Screens/Main/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io' as Io;
import 'dart:convert' as convert;

class Editprofilecontroller extends GetxController {

  RxBool loading = true.obs;

  List<String> pregnancyList = ["Iam trying to conceive","Iam pregnant","I have a baby"];

  Future<void> initScreen() async {
  var d = await Userapi.getUser();
  fromJson(d);
  print("*********************");

  print(d);

  loading.value = false;
  update();

  }

    @override
  void onInit() {
    super.onInit();
  initScreen();

  }


// image
  late File image;

  final picker = ImagePicker();

  var fileImage64;


    String? profile_pic;


  Future getImageFromCamera(context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 20);
    if (pickedFile != null) {
      image = File(pickedFile.path);

    String url =  await OurFirebase.uploadImageToFirebase( "/profilepics", "${DateTime.now().toIso8601String()}.jpg", image,phoneNumber.text,);

     profile_pic = url;
     setUpdateData("profile_pic",profile_pic);

      Fluttertoast.showToast(
          msg: "Profile Updated", backgroundColor: PrimaryColor);
    } else {
      print('No image selected.');
    }

    Navigator.of(context).pop();


    update();
  }

    Future<void> getImageFromGallery(context) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    );
    if (pickedFile != null) {

      image = File(pickedFile.path);

    String url =  await OurFirebase.uploadImageToFirebase( "/profilepics", "${DateTime.now().toIso8601String()}.jpg", image,phoneNumber.text,);

     profile_pic = url;
     setUpdateData("profile_pic",profile_pic);


      Fluttertoast.showToast(
          msg: "Profile Updated", backgroundColor: PrimaryColor);
    } else {
      print('No image selected.');
    }

    Navigator.of(context).pop();

    update();
  }












// 

  String? imageurl;


  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController lmpDate = TextEditingController();
  TextEditingController edDate = TextEditingController();
  TextEditingController alternatePhone = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController partnerName = TextEditingController();
  TextEditingController partnerPhone = TextEditingController();
  TextEditingController doorNo = TextEditingController();
  TextEditingController streetName = TextEditingController();
  TextEditingController otherInformation = TextEditingController();
  TextEditingController numberOfChildren = TextEditingController();
  TextEditingController averageLengthOfCycles = TextEditingController();
  TextEditingController partnerPhoneVerified = TextEditingController();
  TextEditingController deliveryDate = TextEditingController();
  String created = "";
  String? healthStatus;


  String? pregnancyStatus ;

  TextEditingController area = TextEditingController();
  // String area = "";



  
  String gender = "Female";
  String bloodGroup = "A+";




    fromJson(Map<String, dynamic> data) {
    name.text = data['name'] ?? '';
    age.text = data['age']?.toString() ?? '';
    email.text = data['email'] ?? '';
    pincode.text = data['pincode']?.toString() ?? '';
    lmpDate.text = data['lmp_date'] ?? '';
    edDate.text = data['ed_date'] ?? '';
    alternatePhone.text = data['alternate_phone']?.toString() ?? '';
    phoneNumber.text = data['phone_number']?.toString() ?? '';
    partnerName.text = data['partner_name'] ?? '';
    partnerPhone.text = data['partner_phone']?.toString() ?? '';
    doorNo.text = data['door_no'] ?? '';
    streetName.text = data['street_name'] ?? '';
    pregnancyStatus = data['pregnancy_status'] ?? '';
    otherInformation.text = data['other_information'] ?? '';
    numberOfChildren.text = data['number_of_children']?.toString() ?? '';
    averageLengthOfCycles.text = data['average_length_of_cycles']?.toString() ?? '';
    partnerPhoneVerified.text = data['partner_phone_verified']?.toString() ?? '';
    deliveryDate.text = data['delivery_date'] ?? '';

    // Non-editable fields
    gender = data['gender'] ?? 'Female';
    bloodGroup = data['blood_group'] ?? 'A+';
    created = data["created_at"]??"";

    area.text = data["area"]??"";

    profile_pic = data["profile_pic"];

    healthStatus = data["health_status"];

  }

  Map<String, dynamic> updateData = {

  };


  void setUpdateData(String key, dynamic value) {
      updateData[key] = value;
  }

  Future<void> updateProfile() async{

    Maincontroller cont = Get.put(Maincontroller());


    if(updateData.isEmpty){

      Get.snackbar("No Data to Update", "Update the Fields"
      ,snackPosition: SnackPosition.BOTTOM);


    }else{

    print(updateData);

   var req =  await Userapi.updateUser(updateData);

   if(req){
   await cont.updateUser();
    Get.offAll(MainScreen());

    Get.snackbar("Updated Successfully !", "User Details are updated successfully"
      ,snackPosition: SnackPosition.BOTTOM);
    
   }else{

        Get.snackbar("Failed to Update", "Please Try Again"
      ,snackPosition: SnackPosition.BOTTOM);

   }


    }





  }



}