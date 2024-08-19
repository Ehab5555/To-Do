import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xff5D9CEC);
  static const Color backgroundLight = Color(0xffDFECDB);
  static const Color backgroundDark = Color(0xff060E1E);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color grey = Color(0xffC8C9CB);
  static const Color green = Color(0xff61E757);
  static const Color red = Color(0xffEC4B4B);
  static const Color bottomNavBarBackground = Color(0xff141922);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: backgroundLight,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: white,
      selectedItemColor: primary,
      unselectedItemColor: grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: white,
      shape: CircleBorder(side: BorderSide(width: 4, color: white)),
    ),
    textTheme: const TextTheme(
      titleMedium:
          TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: black),
      titleSmall:
          TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: black),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: backgroundDark,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: bottomNavBarBackground,
      selectedItemColor: primary,
      unselectedItemColor: grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: white,
      shape: CircleBorder(
          side: BorderSide(width: 4, color: bottomNavBarBackground)),
    ),
    textTheme: const TextTheme(
      titleMedium:
          TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: black),
      titleSmall:
          TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: black),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
      ),
    ),
  );
}
