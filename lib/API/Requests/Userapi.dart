import 'dart:convert';

import 'package:allobaby/API/Requests/HospitalAPI.dart';
import 'package:allobaby/API/authAPI.dart';
import 'package:allobaby/API/local/Storage.dart';
import 'package:allobaby/Screens/Main/MainScreen.dart';
import 'package:get/route_manager.dart';
import 'package:localstorage/localstorage.dart';

class Userapi {

 static Future<dynamic> getUser() async {
    var req = await getRequest("/user/get");

    return req;
  }

  

   static Future<dynamic> registerFirebaseToken(data) async {
    var req = await postRequest("/register_token",data);

    return req;
  }


  static Future<dynamic> getCheckups () async {
    var req = await getRequest("/user/checkups");
    return req;
  }

    static Future<dynamic> getCheckupByID (int id) async {
    var req = await getRequest("/checkup/getbyid?id=${id.toString()}");
    return req;
  }




  static Future<bool> updateUser(data) async {

    var req = await putRequest("/user/updateuser",data);

    return req;
  }


  static Future<bool> updateDefaultHospital(dynamic hospital) async {
    try {
    bool req = await postRequest("/user/setdefaulthospital", {"hospitalId" : hospital["id"]});
    print(req);
    if(req){
      final d = await Hospitalapi.getDefaultChatAgent(hospital["id"]);
      print("------------------------------------------------");
      print(d);
      print("------------------------------------------------");

      localStorage.setItem("defaultHospital", json.encode(hospital));
      localStorage.setItem("defaultChat", json.encode(d));

      print(d);

      return true;
    }else {
      Get.snackbar("Error", "Please Try Again Later", snackPosition: SnackPosition.BOTTOM);

      return false;
    }
    } catch (e) {
      Get.snackbar("Error", "Please Try Again Later", snackPosition: SnackPosition.BOTTOM);

      return false;
    }
  }


  static Future<String?> getCallToken(String cname) async {
    try {
    final req = await getRequest("/ws/generateToken?cname=$cname");
    return req["token"]; 
    } catch (e) {
        return null;
    }
  }



    static Future<bool> addScreeningData(dynamic bottomsheetdata, 
    dynamic vitals, [dynamic symptoms] ) async {
    try {
      
      Map<String,dynamic> data = {
        "screening_date" : DateTime.now().toIso8601String(),
      };


       if(symptoms!=null) {
        data["symptoms"] = symptoms;
        }



      if(bottomsheetdata!=null) {
        data["bottomsheet"] = bottomsheetdata;
        }

      print("***********************************************");


      if(vitals!=null) {data["vitals"] = vitals;}


      

    final req = await postRequest("/screening/add",data);
    return req["status"]; 
    } catch (e) {

      print(e);
        return false;
    }
  }

    static Future<void> addCheckup(appointmentId,vitals ,symptoms, patientId) async {

    

    Map<String, dynamic> data = {
      "userId":patientId
    };
    if(appointmentId!=null){
      data["appointmentId"] = appointmentId;
    }
    if(vitals!=null){
      data["vitals"] = vitals;
    }
    if(symptoms!=null){
      data["symptoms"] = symptoms;
    }

    print(data);

    var req = await postRequest("/user/addcheckup",data);
    return req;

  }


}