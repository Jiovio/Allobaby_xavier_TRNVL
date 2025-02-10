import 'dart:convert';

import 'package:allobaby/API/authAPI.dart';
import 'package:allobaby/API/local/Storage.dart';
import 'package:allobaby/Screens/Home/Report/Report.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';

class Reportapi {


  


  Future<void> addReports(data) async {
    var d = await postRequest("/report/createbyuser", data);
    print(d);
    return d;
  }


    Future<void> updateReport(data) async {
    var d = await postRequest("/report/updatebyuser", data);
    print(d);
    return d;
  }


    static  Future<dynamic> deleteReport(dynamic id) async {
    var d = await deleteRequest("/report/delete?report_id=${id.toString()}");
    print(d);
    return d;
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