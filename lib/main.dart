
import 'package:allobaby/Components/notification_service.dart';
import 'package:allobaby/app.dart';
import 'package:allobaby/db/sqlite.dart';
import 'package:allobaby/intl/TranslationService.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await NotificationService.initLocalNotificationsPlugin();



  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  
  await Sqlite.db();
  await initLocalStorage();

  final lang = localStorage.getItem("lang");
  
  final Locale initialLocale = 
  lang != null ?
  TranslationService().getLocaleFromLanguage(lang) as Locale : TranslationService.fallbackLocale;

  runApp( MyApp(initLang: initialLocale));
}
