
import 'package:allobaby/Components/notification_service.dart';
import 'package:allobaby/app.dart';
import 'package:allobaby/db/sqlite.dart';
import 'package:allobaby/intl/TranslationService.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // print('Handling a background message: ${message.messageId}');
}


Future<void> initializeAppCheck() async {
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.appAttest,
  );
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  try {
      await Sqlite.db();
  } catch (e) {
    print(e);
    print("Error Initializing DB");
  }
  


  try {

      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await NotificationService.initLocalNotificationsPlugin();



  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  await initializeAppCheck();
    
  } catch (e) {

    print(e);

    print("Error on Firebase Initialization");
    
  }



  

  // final lang = localStorage.getItem("lang");
  
  // final Locale initialLocale = 
  // lang != null ?
  // TranslationService().getLocaleFromLanguage(lang) as Locale 
  // : 
  // TranslationService.fallbackLocale;

  runApp( MyApp(initLang: initialLocale()));
}


Locale initialLocale() {

    final lang = localStorage.getItem("lang");
  
  final Locale initialLocale = 
  lang != null ?
  TranslationService().getLocaleFromLanguage(lang) as Locale 
  : 
  TranslationService.fallbackLocale;

  return initialLocale;
}
