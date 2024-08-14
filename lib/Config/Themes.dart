import 'package:flutter/material.dart';

import 'Color.dart';

class Themes {

  final lightTheme = ThemeData().copyWith(

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: PrimaryColor,
        foregroundColor: White
      )
    ),
    scaffoldBackgroundColor: White,

        textSelectionTheme:const TextSelectionThemeData(
        cursorColor: PrimaryColor,
        selectionColor: Blue800,
        selectionHandleColor: Blue800),

            appBarTheme: AppBarTheme(
              // backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              shadowColor: Colors.grey,
              elevation: 3,
      // brightness: Brightness.light,
      titleTextStyle: TextStyle(
              color: Black, fontSize: 20, fontWeight: FontWeight.w600),
      // color: White,
      iconTheme: IconThemeData(
        color: Black,
      ),
    ),


    tabBarTheme:const TabBarTheme(
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: PrimaryColor, width: 2.0)),
      labelColor: PrimaryColor,
      unselectedLabelColor: Black,
      indicatorSize: TabBarIndicatorSize.label,
    ),



    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      unselectedItemColor: Black800,
      selectedItemColor: PrimaryColor,
    ),

brightness: Brightness.light,
    primaryColor: PrimaryColor,
    iconTheme: const IconThemeData(color: PrimaryColor),

        // primaryColorBrightness: Brightness.light,
    primaryIconTheme:const IconThemeData(color: PrimaryColor),


        timePickerTheme: TimePickerThemeData(
        dialHandColor: PrimaryColor,
        entryModeIconColor: PrimaryColor,
        backgroundColor: White), 
        
        
        colorScheme: const ColorScheme(
        primary: PrimaryColor,
        secondary: accentColor,
        surface: White,
        error: Colors.red,
        onPrimary: White,
        onSecondary: Black,
        onSurface: Black,
        onError: Colors.red,
        brightness: Brightness.light,
        primaryContainer: Blue800,
        secondaryContainer: SecondaryColor
        ).copyWith(secondary: accentColor,primary: PrimaryColor),


  );
  // final lightTheme = ThemeData.light().copyWith(
  //   textSelectionTheme: TextSelectionThemeData(
  //       cursorColor: PrimaryColor,
  //       selectionColor: Blue800,
  //       selectionHandleColor: Blue800),
  //   appBarTheme: AppBarTheme(
  //     // brightness: Brightness.light,
  //     titleTextStyle: TextStyle(
  //             color: Black, fontSize: 20, fontWeight: FontWeight.w600),
  //     color: White,
  //     iconTheme: IconThemeData(
  //       color: Black,
  //     ),
  //   ),
  //   tabBarTheme: TabBarTheme(
  //     indicator: UnderlineTabIndicator(
  //         borderSide: BorderSide(color: PrimaryColor, width: 2.0)),
  //     labelColor: PrimaryColor,
  //     unselectedLabelColor: Black,
  //     indicatorSize: TabBarIndicatorSize.label,
  //   ),
  //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //     unselectedItemColor: Black800,
  //     selectedItemColor: PrimaryColor,
  //   ),
  //   brightness: Brightness.light,
  //   primaryColor: PrimaryColor,
  //   iconTheme: IconThemeData(color: PrimaryColor),
  //   // primaryColorBrightness: Brightness.light,
  //   primaryIconTheme: IconThemeData(color: PrimaryColor),
  //   timePickerTheme: TimePickerThemeData(
  //       dialHandColor: PrimaryColor,
  //       entryModeIconColor: PrimaryColor,
  //       backgroundColor: White), colorScheme: ColorScheme(
  //       primary: PrimaryColor,
  //       secondary: accentColor,
  //       surface: Black,
  //       background: White,
  //       error: Colors.red,
  //       onPrimary: White,
  //       onSecondary: Black,
  //       onSurface: Black,
  //       onBackground: White,
  //       onError: Colors.red,
  //       brightness: Brightness.light,
  //       primaryContainer: Blue800,
  //       secondaryContainer: SecondaryColor
  //       ).copyWith(secondary: accentColor),
  // );

  // final darkTheme = ThemeData.dark().copyWith(
  //   textSelectionTheme: TextSelectionThemeData(
  //       cursorColor: SecondaryColor,
  //       selectionColor: Colors.blueAccent[50],
  //       selectionHandleColor: SecondaryColor),
  //   hoverColor: Colors.blueAccent[50],
  //   splashColor: SecondaryColor,
  //   tabBarTheme: TabBarTheme(
  //     indicator: UnderlineTabIndicator(
  //         borderSide: BorderSide(color: SecondaryColor, width: 2.0)),
  //     labelColor: White,
  //     unselectedLabelColor: Colors.white38,
  //     indicatorSize: TabBarIndicatorSize.label,
  //   ),
  //   accentColor: Colors.white70,
  //   timePickerTheme: TimePickerThemeData(
  //       dialHandColor: SecondaryColor,
  //       entryModeIconColor: SecondaryColor,
  //       backgroundColor: Colors.black),
  //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //     backgroundColor: darkGrey2,
  //     unselectedItemColor: Colors.white38,
  //     selectedItemColor: SecondaryColor,
  //   ),
  //   appBarTheme: AppBarTheme(
  //     color: darkGrey2,
  //     textTheme: TextTheme(
  //         headline6: TextStyle(
  //             color: White, fontSize: 20, fontWeight: FontWeight.w600)),
  //     iconTheme: IconThemeData(
  //       color: White,
  //     ),
  //   ),
  //   colorScheme: ColorScheme(
  //       primary: SecondaryColor,
  //       secondary: accentColor,
  //       surface: Black,
  //       background: White,
  //       error: Colors.red,
  //       onPrimary: White,
  //       onSecondary: Black,
  //       onSurface: Black,
  //       onBackground: White,
  //       onError: Colors.red,
  //       brightness: Brightness.light,
  //       primaryVariant: Blue800,
  //       secondaryVariant: SecondaryColor),
  //   iconTheme: IconThemeData(color: Colors.grey),
  //   scaffoldBackgroundColor: darkGrey,
  //   brightness: Brightness.dark,
  //   primaryColor: darkGrey,
  // );
}
