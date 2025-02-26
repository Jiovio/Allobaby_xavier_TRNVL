import 'package:allobaby/API/apiroutes.dart';
import 'package:allobaby/Config/Themes.dart';
import 'package:allobaby/Screens/Main/MainScreen.dart';
import 'package:allobaby/Screens/Signin.dart';
import 'package:allobaby/features/babycry/analyzing.dart';
import 'package:allobaby/features/babycry/cryhistory/cryhistoryhome.dart';
import 'package:allobaby/features/babycry/crytellhome.dart';
import 'package:allobaby/intl/TranslationService.dart';
import 'package:allobaby/temp/selfscreeningreport.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';


class MyApp extends StatefulWidget {

  final Locale initLang;
  const MyApp({super.key , required this.initLang});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetMaterialApp(
        title: "Allobaby",
        home: 
        // ScreeningReportPage(),
        Apiroutes.checkUser() ?MainScreen():Signin(),
        debugShowCheckedModeBanner: false,
        theme: Themes().lightTheme,
          locale: widget.initLang,
          fallbackLocale: TranslationService.fallbackLocale,
          translations: TranslationService(),
      
      ), 
    );
  }
}