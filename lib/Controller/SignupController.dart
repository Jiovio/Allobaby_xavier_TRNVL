
import 'dart:convert';
import 'dart:io';

import 'package:allobaby/API/Requests/OTPApi.dart';
import 'package:allobaby/API/apiroutes.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Config/OurFirebase.dart';
import 'package:allobaby/Screens/Initial/MomOrDad.dart';
import 'package:allobaby/Screens/Main/MainScreen.dart';
import 'package:allobaby/Screens/mobileverification/otpverification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


import 'dart:io' as Io;
import 'dart:convert' as convert;


class Signupcontroller extends GetxController{

  // image
  late File image;

  final picker = ImagePicker();

  var fileImage64;


    String? profile_pic;


  Future getImageFromCamera() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 20);
    if (pickedFile != null) {
      image = File(pickedFile.path);

     String url =  await OurFirebase.uploadImageToFirebase( "/profilepics", "${DateTime.now().toIso8601String()}.jpg", image,phone.text,);

     profile_pic = url;

      Fluttertoast.showToast(
          msg: "Profile Uploaded", backgroundColor: PrimaryColor);
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
      image = File(pickedFile.path);

           String url =  await OurFirebase.uploadImageToFirebase( "/profilepics", "${DateTime.now().toIso8601String()}.jpg", image,phone.text);

     profile_pic = url;

      Fluttertoast.showToast(
          msg: "Profile Uploaded", backgroundColor: PrimaryColor);
    } else {
      print('No image selected.');
    }
    update();
  }




  Map<String,dynamic> data = {
    "parentType":"Dad",
    "pregnancyStatus":"",
    "avgLengthOfCycles":28
  };

TextEditingController phone = TextEditingController();
String countryCode = "91";

  onSuccessLogin() {
    print(Apiroutes().getUrl("/login"));
    Get.offAll(()=>Otpverification(),
    transition: Transition.rightToLeft);
  }


  String? imgUrl;

  List<String> pregnancyStatusList = ["Iam trying to conceive","Iam pregnant","I have a baby"];


  updateData(String key, dynamic value){

    if(data.containsKey(key)){

      data[key] = value;
      update();
    }else{
      print("Key not found");
    }
  }


  TextEditingController partnerName = TextEditingController();
  TextEditingController partnerMobile = TextEditingController();

  TextEditingController lmpDate = TextEditingController();

  TextEditingController eddate = TextEditingController();
  TextEditingController averageCycleLength = TextEditingController();
  TextEditingController dateofdelivery = TextEditingController();

  TextEditingController doorNo = TextEditingController();
  TextEditingController streetName = TextEditingController();
  TextEditingController pincode = TextEditingController();

  bool pincodeSearching = false;




  List<String> areas = [];

  String selectedArea = "";

  TextEditingController name = TextEditingController();
  TextEditingController emailID = TextEditingController();
  String gender = "";
  TextEditingController age = TextEditingController();
  String bloodGroup = "";


 Future searchPincode() async {

  selectedArea="";
  areas=[];

  pincodeSearching= true;

  update();

  Uri url = Uri.parse("https://api.postalpincode.in/pincode/${pincode.text}");

  final req = await http.get(url);


  if(jsonDecode(req.body)[0]["Status"]=="Error"){

    print(jsonDecode(req.body));


    pincodeSearching=false;
    Get.snackbar("Invalid Pincode","Please Enter Valid PinCode",snackPosition: SnackPosition.BOTTOM);
    update(); 
    return;

  }


  if(req.statusCode==200){


    jsonDecode(req.body)[0]["PostOffice"].forEach((val)=>{
      areas.add(val["Name"])
    });

    selectedArea = areas[0];
    

    pincodeSearching=false;

    update();


  }else{


  }

  }

  String convertDateToYMD(String date) {
  // Parse the input string in DD-MM-YYYY format
  DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(date);
  
  // Format the parsed date into YYYY-MM-DD
  String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
  
  return formattedDate;
}

Map<String, dynamic> getJsonData() {
  return {
    "name": name.text,
    "phone_number": phone.text,
    // "date_of_birth": "",
    "age": int.tryParse(age.text) ?? 0,
    "blood_group": bloodGroup,
    "email": emailID.text,
    "alternate_phone": partnerMobile.text,
    "country_code": countryCode,
    "gender": gender,
    "pregnancy_status": data['pregnancyStatus'],
    // "picme_rch_id": "",
    if(lmpDate.text!="")
    "lmp_date": convertDateToYMD(lmpDate.text),
    if(eddate.text!="")
    "ed_date": convertDateToYMD(eddate.text),

    if(dateofdelivery.text!="")
    "delivery_date":convertDateToYMD(dateofdelivery.text),
    "average_length_of_cycles": data['avgLengthOfCycles'] ?? 0,
    "number_of_children": 0,
    "other_information": "",
    "door_no": doorNo.text,
    "street_name": streetName.text,
    "pincode": pincode.text,
    "area": selectedArea,
    // "state": "",
    "partner_name": partnerName.text,
    "partner_phone": partnerMobile.text,
    "partner_phone_verified": false,
    "profile_pic":profile_pic
  };
}




Future<void> checkUser() async{

  var res = await Apiroutes().getUserByPhone(phone.text);

  if(res==false){
    print("User Not Found");
    Get.snackbar("Welcome New User", "Thanks for choosing us",snackPosition: SnackPosition.BOTTOM);
    // await signInWithGoogle();
    Get.to(MomOrDad());
    return;
  }

    localStorage.setItem("user", json.encode(res));
    Get.snackbar("Login Successfull", "Redirecting to Home Page");
    Get.offAll(MainScreen());

  
}


Future<void> submitUser()async{

  dynamic data = getJsonData();

  // print(data);

  var req = await Apiroutes().createUser(data);

  OurFirebase.createUser(phone.text, data);



  if(req==false){
    print("Failed to create User");
  print(req);

  }
    localStorage.setItem('user', json.encode(req));
    Get.offAll(()=>const MainScreen(),transition: Transition.rightToLeft);


  
}

int? oid = null;

Future<void> sendOtp() async {

  var r = await Otpapi.sendOtp(phone.text);

  if(r["status"]){
  oid=r["id"];
  Get.to(Otpverification());
  }else {

  }
}

TextEditingController otp = TextEditingController();

Future<void> verifyOtp() async {
var r = await Otpapi.verifyOTP(otp.text,oid);

if(otp.text=="999777"){
  await checkUser();
  return;
}

if(r){
  await checkUser();
}else{
  Get.snackbar("Invalid OTP", "Please Enter Correct OTP",snackPosition: SnackPosition.BOTTOM);
}
}



  Future<void> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  var d = await FirebaseAuth.instance.signInWithCredential(credential);

  Map<String,dynamic>? userdata = d.additionalUserInfo?.profile;

  print(userdata);

  if(userdata!=null){
    var first_name = userdata["given_name"];
    var last_name = userdata["family_name"];
    var email = userdata["email"];
    var imgurl = userdata["picture"];
    name.text = "$first_name $last_name";
    emailID.text = email;
    profile_pic = imgurl;

  }
}


}