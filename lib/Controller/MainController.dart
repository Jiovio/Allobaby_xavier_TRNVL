import 'package:allobaby/API/Requests/Userapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class Maincontroller extends GetxController {

  RxBool loading = true.obs;

  Future<void> initScreen() async {
  var d = await Userapi.getUser();
  fromJson(d);
  getCounterData();
  print("*********************");

  loading.value = false;
  update();

  }


  @override
  void onInit() {
    super.onInit();
  initScreen();

  }


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
    pregnancyStatus.text = data['pregnancy_status'] ?? '';
    otherInformation.text = data['other_information'] ?? '';
    numberOfChildren.text = data['number_of_children']?.toString() ?? '';
    averageLengthOfCycles.text = data['average_length_of_cycles']?.toString() ?? '';
    partnerPhoneVerified.text = data['partner_phone_verified']?.toString() ?? '';
    deliveryDate.text = data['delivery_date'] ?? '';

    // Non-editable fields
    gender = data['gender'] ?? 'Female';
    bloodGroup = data['blood_group'] ?? 'A+';
    created = data["created_at"]??"";
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

    var d = "2024-09-01";

    switch (pregnancyStatus.text) {
      case "Iam trying to Conceive":
        ctotalDays = int.parse(averageLengthOfCycles.text);
        cdaysPassed = calcdaysPassed(d
          // lmpDate.text
          ) % ctotalDays;
        break;

      case "Iam Pregnant":
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




  void setBottomSheetData(key,value){
    if(bottomSheetData.containsKey(key)){
      bottomSheetData[key] = value;
      update();
    }
  }
  void setbottomSheetDataArray(key,val){

    List<dynamic> ls = bottomSheetData[key];

    if(!ls.contains(val))
    ls.add(val);
    else
    ls.remove(val);

    bottomSheetData[key] = ls;
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




