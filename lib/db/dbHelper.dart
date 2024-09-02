

import 'dart:convert';



import 'package:allobaby/db/sqlite.dart';
import 'package:allobaby/temp/ReportListPage.dart';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';


String hashId(dynamic id){
  DateTime currentd = new DateTime.now();
  var bytes = utf8.encode(currentd.toString()+id.toString());
   var digest = sha1.convert(bytes);
   
   return digest.toString();
}

Map<String,dynamic> addToDb (String type, dynamic details, dynamic image) {

  return {
      "reportType":type,
      "details":json.encode(details),
      "image":image,

    };

}


void addReports(Map<String, Object?> data) async {

  Database db = await Sqlite.db();


  await db.insert("reports",{...data,"reportId":hashId(1)} );


  Get.snackbar("Report Added Successfully", "The Report has been added Successully");

}

// Future<List<Map<String, Object?>>> 
getReports() async {
  Database db = await Sqlite.db();
  var d = await db.query("reports");
  // print(d);
  // print("Hii");


  Get.to(ReportListPage(),arguments: d);

}