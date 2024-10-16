import 'package:allobaby/API/apiroutes.dart';
import 'package:allobaby/Config/Themes.dart';
import 'package:allobaby/Screens/Main/MainScreen.dart';
import 'package:allobaby/Screens/Signin.dart';
import 'package:allobaby/intl/TranslationService.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  

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