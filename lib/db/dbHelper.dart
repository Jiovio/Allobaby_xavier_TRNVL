

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
  print(d);
  // print(d);
  // print("Hii");


  Get.to(ReportListPage(),arguments: d);

}


createChatTable() async{
  Database db = await Sqlite.db();
  await db.execute('''
    DROP TABLE chats;
''');

await db.execute('''
CREATE TABLE chats (
  id TEXT NOT NULL,
  senderId TEXT NOT NULL,
  receiverId TEXT NOT NULL,
  type TEXT,
  message TEXT,
  timestamp TIMESTAMP NOT NULL,
  photoUrl TEXT,
  fileUrl TEXT,
  fileSize TEXT,
  fileName TEXT
);
''');
}


Future<void> insertMessage( {
  required String id,
  required String senderId,
  required String receiverId,
  String? type,
  String? message,
  DateTime? timestamp,
  String? photoUrl,
  String? fileUrl,
  String? fileSize,
  String? fileName,
}) async {
  Database db = await  Sqlite.db();
  await db.insert(
    'chats',
    {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'type': type,
      'message': message,
      'timestamp': (timestamp ?? DateTime.now()).toIso8601String(),
      'photoUrl': photoUrl,
      'fileUrl': fileUrl,
      'fileSize': fileSize,
      'fileName': fileName,
    },
  );
}
