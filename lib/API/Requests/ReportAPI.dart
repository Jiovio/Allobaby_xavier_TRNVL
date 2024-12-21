import 'dart:convert';

import 'package:allobaby/API/authAPI.dart';
import 'package:allobaby/API/local/Storage.dart';
import 'package:allobaby/Screens/Home/Report/Report.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';

class Reportapi {


  


  Future<void> addReports(data) async {

        data["id"] = Storage.getUserID();


    var d = await postRequest("/report/createbyuser", data);

    
    print(d);

    return d;

    try {

    data["id"] = Storage.getUserID();

    var d = await postRequest("/report/create", data);
    print(d);

    Get.to(()=>Report());
      

    } catch (e) {
      print(e);
      throw e;
    }


  }


       static Future<dynamic> getAppointmentForReport(id) async {
    try {
    var d = await getRequest("/report/full/$id");
    print(id);
    return d;
    } catch (e) {
      return false;
    }
  }

}