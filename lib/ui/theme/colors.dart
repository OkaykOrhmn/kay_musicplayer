import 'package:flutter/material.dart';

Color? backgroundColorDark = Colors.grey[900];
Color? backgroundColorlight = Colors.grey[300];

ThemeData lightMode = ThemeData(
    scaffoldBackgroundColor: backgroundColorlight,
    appBarTheme: AppBarTheme(backgroundColor: backgroundColorlight),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: backgroundColorlight,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[500]),
    // primaryColor: const Color(0xff470FF4),
    drawerTheme: DrawerThemeData(
      backgroundColor: backgroundColorlight,
    ),
    //  colorScheme: const ColorScheme.light(
    //           primary: Color(0xff470FF4),
    //           secondary: Color(0xffCE2D4F),
    //           onSurface: Colors.white)
    colorScheme: ColorScheme.light(
      primary: Colors.grey.shade500,
      secondary: Colors.grey.shade200,
      inversePrimary: Colors.grey.shade900,
    ));

ThemeData darkMode = ThemeData(
    scaffoldBackgroundColor: backgroundColorDark,
    appBarTheme: AppBarTheme(backgroundColor: backgroundColorDark),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: backgroundColorDark,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[700]),
    // primaryColor: const Color(0xff470FF4),
    drawerTheme: DrawerThemeData(
      backgroundColor: backgroundColorDark,
    ),
    colorScheme: ColorScheme.dark(
      primary: Colors.grey.shade600,
      secondary: Colors.grey.shade800,
      inversePrimary: Colors.grey.shade300,
    ));
