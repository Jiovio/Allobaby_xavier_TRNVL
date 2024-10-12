import 'dart:convert';

import 'package:allobaby/API/authAPI.dart';
import 'package:allobaby/Screens/Home/Report/Report.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';

class Reportapi {


  Future<void> addReports(data) async {

    try {
    var ld = localStorage.getItem("user");
    var id;

    if(ld!=null){
    id = json.decode(ld)["id"];
    print(id);
    }else{

    }

    data["id"] = id;
    // return;
    data.remove("created");
    print(data);
    data["details"] = json.decode(data["details"]);
    var d = await postRequest("/report/create", data);
    print(d);

    Get.to(Report());
      

    } catch (e) {
      print(e);
      throw e;
    }


  }

}