

import 'dart:convert';



import 'package:allobaby/API/local/Storage.dart';
import 'package:allobaby/Models/DailyScreening.dart';
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


Future<void> addReports(Map<String, Object?> data) async {

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
//     await db.execute('''
//     DROP TABLE IF EXISTS vitals;
// ''');
//   await db.execute('''
//     DROP TABLE IF EXISTS chatlist;
// ''');

// await db.execute('''
// CREATE TABLE chats (
//   id TEXT NOT NULL,
//   senderId TEXT NOT NULL,
//   receiverId TEXT NOT NULL,
//   type TEXT,
//   message TEXT,
//   timestamp TIMESTAMP NOT NULL,
//   photoUrl TEXT,
//   fileUrl TEXT,
//   fileSize TEXT,
//   fileName TEXT,
//   fid TEXT
// );
// ''');

//   await db.execute('''
//     CREATE TABLE chatlist (
//       name TEXT,
//       fid TEXT,
//       id TEXT,
//       type TEXT,
//       lastMessage TEXT,
//       recent TIMESTAMP
//     );
//   ''');

//   await db.execute('''
// CREATE TABLE dailyscreening (
//     id INTEGER PRIMARY KEY,
//     date DATE NOT NULL,
//     feeling TEXT,
//     glassOfWater INTEGER,
//     bedTime TEXT,
//     wakeUpTime TEXT,
//     sleepDuration INTEGER
//     exercises TEXT,
//     tabletsTaken TEXT,
//     symptoms TEXT,
//     exercises TEXT,
//     data TEXT,
//     created DATETIME DEFAULT CURRENT_TIMESTAMP
// );
// ''');

//   await db.execute('''
// CREATE TABLE vitals (
//     data TEXT NOT NULL,
//     date DATE DEFAULT (DATE('now')) PRIMARY KEY,
//     synced BOOLEAN DEFAULT 0,
//     uid INTEGER
// );
// ''');

//   await db.execute('''
// CREATE TABLE daily (
//     data TEXT NOT NULL,
//     date DATE DEFAULT (DATE('now')) PRIMARY KEY,
//     synced BOOLEAN DEFAULT 0,
//     uid INTEGER
// );
// ''');
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

Future<int> insertDailyRecord(dynamic record) async {
  // Open the database
  final Database db = await Sqlite.db();

  // Create a new map to avoid modifying the original record
  var map = Map<String, dynamic>.from(record);

  map["data"] = json.encode(map);
  
  // Properly handle List<String> conversion
  if (map["tabletsTaken"] is List) {
    map["tabletsTaken"] = jsonEncode((map["tabletsTaken"] as List).map((e) => e.toString()).toList());
  }
  
  if (map["exercises"] is List) {
    map["exercises"] = jsonEncode((map["exercises"] as List).map((e) => e.toString()).toList());
  }
  
  if (map["symptoms"] is List) {
    map["symptoms"] = jsonEncode((map["symptoms"] as List).map((e) => e.toString()).toList());
  }

  

  // Ensure date is in correct format
  map["date"] = DateTime.now().toIso8601String();

  return await db.insert(
    'dailyscreening',
    map,
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

     Future<Map<String, dynamic>?> getMostRecentRecord() async {
    final Database db = await Sqlite.db();

    final List<Map<String, dynamic>> maps = await db.query(
      'dailyscreening',
      orderBy: "date DESC, created DESC",
      limit: 1,
    );

    print(maps.first);

    if (maps.isNotEmpty) {
      var data = maps.first;

        try {
        data["tabletsTaken"] = jsonDecode(data["tabletsTaken"].toString()) as List;
        data["exercises"] = jsonDecode(data["exercises"].toString()) as List;
        data["symptoms"] = jsonDecode(data["symptoms"].toString()) as List;
      } catch (e) {
        print('Error decoding JSON: $e');
      }
      return data;
    } else {
      return null; // No records found
    }
  }

Future<int> insertOrUpdateDaily(String jsonData,String tablename) async {

  // 'symptoms , daily , vitals
  final db = await Sqlite.db();

  int id = Storage.getUserID();

  try {
    return await db.insert(
      tablename,
      {
        'data': jsonData,
        'date': DateTime.now().toIso8601String().split('T')[0], // Ensuring today's date
        'synced': 0,
        "uid" : id
      },
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace if today's record exists
    );
  } catch (e) {
    print("Error inserting or updating record: $e");
    return -1;
  }
}

  // Function to retrieve today's entry
   Future<Map<String, dynamic>?> getTodayData(String tablename) async {
    final db = await Sqlite.db();
    String today = DateTime.now().toIso8601String().split('T')[0];

    final List<Map<String, dynamic>> result = await db.query(
      tablename,
      where: "date(date) = ?",
      whereArgs: [today],
      limit: 1,
    );

    if (result.isNotEmpty) {
      print(result.first);
      return result.first;
    } else {
      return null; 
    }
  }

     Future<Map<String, dynamic>?> getDailyDataByDate(String tablename, DateTime date) async {
    final db = await Sqlite.db();
    String today = date.toIso8601String().split('T')[0];

    final List<Map<String, dynamic>> result = await db.query(
      tablename,
      where: "date(date) = ?",
      whereArgs: [today],
      limit: 1,
    );

    if (result.isNotEmpty) {
      print(result.first);
      return result.first;
    } else {
      return null; 
    }
  }
