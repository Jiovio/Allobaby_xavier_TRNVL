

import 'package:allobaby/API/Requests/Userapi.dart';
import 'package:allobaby/API/local/Storage.dart';
import 'package:allobaby/Config/OurFirebase.dart';
import 'package:allobaby/Config/agora_configs.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:localstorage/localstorage.dart';

class NotificationService {

      static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();


    static Future<void> initLocalNotificationsPlugin() async {
      

  const AndroidInitializationSettings initializationSettingsAndroid = 
      AndroidInitializationSettings('@mipmap/launcher_icon');
  const InitializationSettings initializationSettings =  InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (details) {
   
      // print(details);
    },
  );
        }


    static Future<bool> requestNotificationPermissions() async {

      if(localStorage.getItem("notification") == "0" ){
        return false;
      }

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

        await messaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // print('User granted permission');

      localStorage.setItem("notification","1");
      
      setupForegroundNotificationListeners();
      return true;
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      // print('User granted provisional permission');
      localStorage.setItem("notification","1");

      return true;
    } else {
      // print('User declined or has not accepted permission');
      localStorage.setItem("notification","0");

      return false;

    }


    //  OurFirebase().getToken();
  }


 static Future<void> registerTokenToServer() async{
      String? fbtoken = await OurFirebase.getToken();
      final uid = Storage.getUserUID();

      print("uid : $uid");



      if(fbtoken==null || uid==null){return;}

    final req = await Userapi.registerFirebaseToken({
      "uid": int.parse(uid),
      "token":fbtoken
    });
  }


     static void setupForegroundNotificationListeners() async {

      await registerTokenToServer();

   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  print('Got a message whilst in the foreground!');
  print('Message data: ${message.data}');

  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');

    print(message.notification?.toMap());

    RemoteNotification notification = message.notification!;

    print(notification.toMap());

    _showNotification(title: notification.title! , body: notification.body!);
  }
});
  }



  // 


    void initLocalNotifications(){
        const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );



    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation
            <AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

    static void _showNotification({required String title, required String body}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'background_notifications',
      'Background Notifications',
      importance: Importance.high,
      priority: Priority.high,
      // icon: "@drawable/ic_launcher_foreground"
      icon: "@mipmap/launcher_icon"
    );
    
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }







}