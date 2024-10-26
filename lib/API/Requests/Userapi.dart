import 'dart:convert';

import 'package:allobaby/API/Requests/HospitalAPI.dart';
import 'package:allobaby/API/authAPI.dart';
import 'package:allobaby/Screens/Main/MainScreen.dart';
import 'package:get/route_manager.dart';
import 'package:localstorage/localstorage.dart';

class Userapi {

 static Future<dynamic> getUser() async {
    var req = await getRequest("/user/get");

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
      localStorage.setItem("defaultHospital", json.encode(hospital));
      localStorage.setItem("defaultChat", json.encode(d));

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
}