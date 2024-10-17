

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
    DROP TABLE IF EXISTS chats;
''');
  await db.execute('''
    DROP TABLE IF EXISTS chatlist;
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
  fileName TEXT,
  fid TEXT
);
''');

  await db.execute('''
    CREATE TABLE chatlist (
      name TEXT,
      fid TEXT,
      id TEXT,
      type TEXT,
      lastMessage TEXT,
      recent TIMESTAMP
    );
  ''');
}


Future<void> insertChatMessage( {
  required String id,
  required String senderId,
  required String receiverId,
  String? type,
  String? message,
  String? timestamp,
  String? photoUrl,
  String? fileUrl,
  String? fileSize,
  String? fileName,
  String? fid
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
      'timestamp':timestamp!=null?DateTime.parse(timestamp).toIso8601String():DateTime.now().toIso8601String(),
      'photoUrl': photoUrl,
      'fileUrl': fileUrl,
      'fileSize': fileSize,
      'fileName': fileName,
      'fid': fid
    },
  );
}

Future<bool> insertChatData( String name, String fid, String id, String type, String lastMessage, String recent) async {
  try {
    Database db = await Sqlite.db();


    // Prepare data to insert
    Map<String, dynamic> chatData = {
      'name': name,
      'fid': fid,
      'id': id,
      'type': type,
      'lastMessage': lastMessage,
      'recent': DateTime.parse(recent).toIso8601String(), // store the timestamp in ISO 8601 format
    };
    
    // Insert the data into the chatlist table
    await db.insert(
      'chatlist',
      chatData,
      conflictAlgorithm: ConflictAlgorithm.replace, // if there's a conflict, replace the existing row
    );
    return true; // Insertion was successful
  } catch (e) {
    print("Error inserting chat data: $e");
    return false; // Insertion failed
  }
}



Stream<List<Map<String, dynamic>>> getChatListStream(String type) async* {
  while (true) {
    Database db = await Sqlite.db();
    final data = await db.query("chatlist", where: "type=?", whereArgs: [type]);
    yield data;
    await Future.delayed(Duration(seconds: 5)); // Adjust the delay as needed
  }
}



Future<dynamic> getChatList(String type) async {
Database db = await Sqlite.db();

final data = await db.query("chatlist",
where: "type=?",
whereArgs: [type]);

return data;

}

Future<bool> checkWhetherChatExists(String fid) async {

Database db = await Sqlite.db();


  final data = await db.query("chatlist",
where: "id=?",
whereArgs: [fid]);

return data.isNotEmpty;

}


Future<bool> checkWhetherChatMessageExists(String fid) async {

Database db = await Sqlite.db();


  final data = await db.query("chats",
where: "fid=?",
whereArgs: [fid]);

return data.isNotEmpty;

}


Future<void> updateRecentMessage(String id , String message, String timestamp) async {

Database db = await Sqlite.db();

  await db.update("chatlist",
  where: "id = ?",
  whereArgs: ["id"],
  {
    "lastMessage": message,
    "recent": DateTime.parse(timestamp).toIso8601String()
  }
  );

}
