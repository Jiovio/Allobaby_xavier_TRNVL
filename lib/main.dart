import 'package:allobaby/Config/background_service.dart';
import 'package:allobaby/app.dart';
import 'package:allobaby/db/sqlite.dart';
import 'package:allobaby/intl/TranslationService.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:just_audio_background/just_audio_background.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //   await JustAudioBackground.init(
  //   androidNotificationChannelId: 'com.example.allobaby.channel.audio',
  //   androidNotificationChannelName: 'Audio playback',
  //   androidNotificationOngoing: true,
  // );


  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  

  //   await FirebaseAppCheck.instance.activate(
  //   // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
  //   // argument for `webProvider`
  //   webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
  //   // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
  //   // your preferred provider. Choose from:
  //   // 1. Debug provider
  //   // 2. Safety Net provider
  //   // 3. Play Integrity provider
  //   androidProvider: AndroidProvider.debug,
  //   // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
  //       // your preferred provider. Choose from:
  //       // 1. Debug provider
  //       // 2. Device Check provider
  //       // 3. App Attest provider
  //       // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
  //   appleProvider: AppleProvider.appAttest,
  // );


  
  await Sqlite.db();
  await initLocalStorage();

  final lang = localStorage.getItem("lang");
  print("*********************");
  print(lang);
  print("*********************");

  final Locale initialLocale = 
  lang != null ?
  TranslationService().getLocaleFromLanguage(lang) as Locale : TranslationService.fallbackLocale;
  // localStorage.getItem("lang");

  runApp( MyApp(initLang: initialLocale));
}
