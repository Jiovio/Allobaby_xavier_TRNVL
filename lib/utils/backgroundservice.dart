import 'package:allobaby/API/local/Storage.dart';
import 'package:allobaby/Config/OurFirebase.dart';
import 'package:allobaby/db/dbHelper.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Backgroundservice {


    static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize notifications
  static Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap-hdpi/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  // Show notification
  static Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'allolab', 'allolab',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      title,
      body,
      platformChannelSpecifics,
    );
  }



    static final myid = Storage.getUserID();

 static String checkIDType(String s){

    List<String> ls = s.split('');


    switch (ls[0]) {
      case "P":
          return "patient";
      
      case "D":
        return "doctor";


      case "H":
        return "healthworker";

      case "L":
        return "lab";

      default:

        return "Z";
    }

  }


  static Future<void> deleteDataFromFirebase(fid) async {

    DatabaseReference ref = FirebaseDatabase.instance.ref("users/P$myid/$fid");

  await ref.remove();


  }

 static Future<void> insertMessagesFromFirebase(value,fid) async{
          switch (value["type"]) {
            case "text":
           await insertChatMessage(
            id: value["id"], senderId: value["senderId"], 
            receiverId: value["receiverId"], 
            timestamp: value["timestamp"],
            fid: fid,
            type: "text",
            message: value["message"]
            );
              break;

            case "image":
           await insertChatMessage(
            fid: fid,
            id: value["id"], senderId: value["senderId"], 
            receiverId: value["receiverId"], 
            timestamp: value["timestamp"],
            photoUrl : value["photoUrl"],
            message: value["message"],
            type: "image"


            );
              break;
            default:
          }

          
  }





  static Future<void> processDataList() async {

    Map<Object?,Object?>? data = await OurFirebase.getCurrentMessages();


    if(data!=null){
      
      data.keys.forEach((val) async {

        // {-O9JmC5NssinSehgePz8: {senderId: P1, receiverId: D2, p2Name: Senthil, 
        // p1Name: Vijay S U, id: P1-D2, 
        // message: Hello, type: text, timestamp: 2024-10-16T15:34:01.809983}}

                    final key = val as String;

        var value = data[key];

       await processData(key, value);



      });
    }

  }




  static Future<void> processData(String key,Object? value) async{



        var id = "";
        

        if(value!=null){
          value = value as Map<dynamic,dynamic>;
          id = value["id"];
        }else{

          return;
        }

        bool chatexists = await checkWhetherChatExists(id);

        if(!chatexists){

          String name = "";
          String cid = "";
          if(value["senderId"] == "P$myid"){
            name = value["p2Name"];
            cid = value["receiverId"];
          }else {name = value["p1Name"];
            cid = value["senderId"];
          }


         await  insertChatData(name, key, value["id"], 
          checkIDType(cid), value["message"], value["timestamp"]);

          print("Chat Inserted");
        }


        bool messageExists = await checkWhetherChatMessageExists(key);

        if(!messageExists ){
         await  insertMessagesFromFirebase(value,key);
         await  updateRecentMessage(value["id"], value["message"],value["timestamp"]);
          print("Message Inserted");
        }

        bool checkMessageExists = await checkWhetherChatMessageExists(key);


        if(checkMessageExists){
          deleteDataFromFirebase(key);
        }
  }

  static listenForData() async {

      final userid =  Storage.getUserID();
      DatabaseReference ref = FirebaseDatabase.instance.ref("users/P$userid");

      ref.onChildAdded.listen((event) async {

      final key = (event.snapshot.key) as String;

      final value = (event.snapshot.value);

     await  processData(key, value);

      });
      


  }

}