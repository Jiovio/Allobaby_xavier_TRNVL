import 'package:allobaby/API/apiroutes.dart';
import 'package:allobaby/Config/OurFirebase.dart';
import 'package:allobaby/Config/Themes.dart';
import 'package:allobaby/Screens/Main/MainScreen.dart';
import 'package:allobaby/Screens/Signin.dart';
import 'package:allobaby/intl/TranslationService.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late FirebaseMessaging _messaging;
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;


    void _requestNotificationPermissions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }


     OurFirebase().getToken();
  }


    void _setupForegroundNotificationListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Received foreground message: ${message.messageId}");

    });
  }


  @override
  void initState() {
    super.initState();
    _requestNotificationPermissions();
    _setupForegroundNotificationListeners();
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetMaterialApp(
        title: "Allobaby",
        home: Apiroutes.checkUser() ?MainScreen():Signin(),
        debugShowCheckedModeBanner: false,
        theme: Themes().lightTheme,
          locale: TranslationService.locale,
          fallbackLocale: TranslationService.fallbackLocale,
          translations: TranslationService(),
      
      ),
    );
  }
}