import 'dart:async';
import 'dart:convert';

import 'package:allobaby/API/Requests/Userapi.dart';
import 'package:allobaby/API/authAPI.dart';
import 'package:allobaby/Components/Loadingbar.dart';
import 'package:allobaby/Components/bottom_nav.dart';
import 'package:allobaby/Components/notification_service.dart';
import 'package:allobaby/Components/snackbar.dart';
import 'package:allobaby/Config/OurFirebase.dart';
import 'package:allobaby/Controller/UserController.dart';
import 'package:allobaby/Screens/Signin.dart';
import 'package:allobaby/db/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:permission_handler/permission_handler.dart';


class Maincontroller extends GetxController {

      RxBool notification = false.obs;


    void checkNotificationPermission() async{
      final status = await Permission.notification.isGranted;
      notification = status.obs;
     update();

    }

    Future<bool> toggleNotificationPermission(bool val) async {

      print("incoming : $val");
        if(val){
        await OurFirebase.deleteMessagingToken();
        notification = false.obs;
        localStorage.setItem("notification","0");
        update();
        return false;
        }else{
        localStorage.setItem("notification","1");
         final stat = await NotificationService.requestNotificationPermissions();
         if(!stat){
        localStorage.setItem("notification","0");

         }
         notification = stat.obs;
         update();
         return stat;

        }
    }

// 

  RxBool loading = true.obs;

  String? language;

  String? profile_pic;

  String? lastScreened;


  Future<void> updateUser() async{
    var d = await Userapi.getUser();
  fromJson(d);

  getCounterData();

  update();
  }




  Timer? timer;

  Future<void> initScreen() async {

    timer?.cancel();


    try {

      var d = await Userapi.getUser();
      localStorage.setItem("uid", d["uid"].toString());

      fromJson(d);

      // print(d);
  

      if(localStorage.getItem("phone")==null){
      localStorage.setItem("phone",d["phone_number"]);
      }


      // Backgroundservice.listenForData();

  loading.value = false;
  update();
      
    } catch (e) {

      timer = Timer.periodic(const Duration(seconds: 5), (t){
        initScreen();

      return;
      });
      
    }

    try {

  getCounterData();


  dynamic bs = await getTodayData("daily");

  if(bs!=null){
  bottomSheetData = json.decode(bs["data"]);
  }

  final ls = localStorage.getItem("lastScreened");

  if(ls!=null){
    lastScreened = ls;
  }
      
  } catch (e) {


      
    }


          NotificationService.requestNotificationPermissions().then((v){
    notification = v.obs;
    update();
  });


  }


  @override
  void onInit() {
    super.onInit();

     OurFirebase.getToken();

      SystemChannels.lifecycle.setMessageHandler((message) async {
    print("Lifecycle state: $message"); // Debug all states

    if (message == AppLifecycleState.paused.toString()) {
      print("App paused/background");
      // Do cleanup here
      OurFirebase.setStatus(false);
    }
    
    if (message == AppLifecycleState.resumed.toString()) {
      print("App resumed");
      OurFirebase.setStatus(true);
    }

    if (message == AppLifecycleState.inactive.toString()) {
      print("App inactive");
      OurFirebase.setStatus(false);
    }

    if (message == AppLifecycleState.detached.toString()) {
      print("App detached");
      OurFirebase.setStatus(false);
    }
    
    return null;
  });

  refreshToken().then((value) {
  initScreen();
  },).catchError((e){
    print(e=="logout");
    

    // if(e=="failed"){
    //   Get.dialog(Container(child: const Text("No Internet !"),));
    // }else if (e=="logout"){

    //   print("Loggggoouutttt");
    //   OurFirebase.setStatus(false);

    //   Get.delete<Maincontroller>();
    //   Get.delete<Usercontroller>();
    //   Get.delete<NavController>();


    //   localStorage.clear();
    //   Get.offAll(()=>const Signin());

    // }




  });





  }
    String healthStatus = "NORMAL";

    String locale = "English";

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
  TextEditingController pregnancyStatus = TextEditingController();
  TextEditingController otherInformation = TextEditingController();
  TextEditingController numberOfChildren = TextEditingController();
  TextEditingController averageLengthOfCycles = TextEditingController();
  TextEditingController partnerPhoneVerified = TextEditingController();
  TextEditingController deliveryDate = TextEditingController();
  String created = "";

  
  String gender = "Female";
  String bloodGroup = "A+";

  fromJson(Map<String, dynamic> data) {

    name.text = data['name'] ?? '';
    lmpDate.text = data['lmp_date'] ?? '';
    edDate.text = data['ed_date'] ?? '';
    pregnancyStatus.text = data['pregnancy_status'] ?? '';
    averageLengthOfCycles.text = data['average_length_of_cycles']?.toString() ?? '';
    deliveryDate.text = data['delivery_date'] ?? '';
    profile_pic = data["profile_pic"] ?? "";
    healthStatus = data["health_status"]??"Normal";
    email.text = data['email'] ?? '';

    // age.text = data['age']?.toString() ?? '';
    // pincode.text = data['pincode']?.toString() ?? '';

    // alternatePhone.text = data['alternate_phone']?.toString() ?? '';
    // phoneNumber.text = data['phone_number']?.toString() ?? '';
    // partnerName.text = data['partner_name'] ?? '';
    // partnerPhone.text = data['partner_phone']?.toString() ?? '';
    // doorNo.text = data['door_no'] ?? '';
    // streetName.text = data['street_name'] ?? '';
    // otherInformation.text = data['other_information'] ?? '';
    // numberOfChildren.text = data['number_of_children']?.toString() ?? '';
    // partnerPhoneVerified.text = data['partner_phone_verified']?.toString() ?? '';

    // // Non-editable fields
    // gender = data['gender'] ?? 'Female';
    // bloodGroup = data['blood_group'] ?? 'A+';
    // created = data["created_at"]??"";


  }


  

int calcdaysPassed(String dateString) {
  // Parse the date using DateTime's parse method
  DateTime parsedDate = DateTime.parse(dateString);

  // Get the current date
  DateTime currentDate = DateTime.now();

  // Calculate the difference in days
  int daysDifference = currentDate.difference(parsedDate).inDays;

  return daysDifference;
}

    int ctotalDays = 0;
    int cdaysPassed = 0;

double ccomp = 0;


  getCounterData(){

    switch (pregnancyStatus.text) {
      case "Iam trying to conceive":
        ctotalDays = int.parse(averageLengthOfCycles.text);
        cdaysPassed = calcdaysPassed(
          // d,
          lmpDate.text
          ) % ctotalDays;
        break;

      case "Iam pregnant":
        ctotalDays = 1000;
        cdaysPassed = calcdaysPassed(lmpDate.text);
        break;  

      case "I have a baby":
        ctotalDays = 1000;
        cdaysPassed = calcdaysPassed(deliveryDate.text);
        break;
      default:
    }

     ccomp = cdaysPassed / ctotalDays;

    //  print([ctotalDays,cdaysPassed,ccomp]);

  }










  // 

  bool voice = true;

  int currpage = 0;
  void pageChanged(int i){

          currpage=i;
          update();


    // try {
    //       currpage=i;
    //       update();
      
    // } catch (e) {
    //       currpage=i;
      
    // }

  }

  // Bottom Sheet


TextEditingController bedtime = TextEditingController();
TextEditingController waketime = TextEditingController();

    Map<String,dynamic> bottomSheetData = {
    "feeling":"",
    "exercises":[],
    "glassOfWater":0,
    "tabletsTaken":[],
    "bedTime": "",
    "wakeUpTime":"",
    "sleepDuration":0,
    "symptoms":[]
  };


  Future<void> submitBottomSheetData() async {

    // print(bottomSheetData);

    await insertDailyRecord(bottomSheetData);



    

  }

  Future<void> updateDailyScreening() async {


      Loadingbar.show("Updating Screening");

      final req = await Userapi.addScreeningData(bottomSheetData,null);

      print(req);


      if(req==false){
        Loadingbar.close();
        showToast("Failed to add Screening", false);
        return;
      }

      await insertOrUpdateDaily(json.encode(bottomSheetData), "daily");
      localStorage.setItem("lastScreened", DateFormat('dd-MM-yyyy').format(DateTime.now()));
      lastScreened = DateFormat('dd-MM-yyyy').format(DateTime.now());


      Loadingbar.close();

      showToast("Screening Added Successfully", true);

  }


  void setBottomSheetData(key,value) async{
    if(bottomSheetData.containsKey(key)){
      bottomSheetData[key] = value;

      // await insertOrUpdateDaily(json.encode(bottomSheetData), "daily");
      update();
    }
  }
  void setbottomSheetDataArray(key,val) async {

    List<dynamic> ls = bottomSheetData[key];


    if(!ls.contains(val))
    ls.add(val);
    else
    ls.remove(val);

    bottomSheetData[key] = ls;

    // await insertOrUpdateDaily(json.encode(bottomSheetData), "daily");

    update();
  }

  // Plan Controller
RxInt planType = 0.obs;
RxString plan = "".obs;
int planPrice = 0;



bool rec = false;

void toggleerec () {
  rec= !rec;
  update();
}





}




