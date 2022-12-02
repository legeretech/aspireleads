import 'package:flutter/material.dart';

class Constants {
  //Colors for theme
  static const Color lightPrimary = Colors.white;
  static const Color darkPrimary = Colors.black;
  static const Color lightAccent = Color(0xffFCB413);
  static const Color lightBG = Color(0xfffcfcff);
  static const Color grey = Color(0xff312f37);

  static ThemeData lightTheme = ThemeData(
    backgroundColor: darkPrimary,
    primaryColorDark: darkPrimary,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    cardColor: grey,
    textTheme: TextTheme(
      headline1: TextStyle(
        color: lightAccent,
        fontSize: 35.0,
        fontWeight: FontWeight.w800,
      ),
      headline2: TextStyle(
        color: lightPrimary.withOpacity(0.6),
        fontSize: 22.0,
        fontWeight: FontWeight.w500,
      ),
      headline4: TextStyle(
        color: darkPrimary,
        fontSize: 17.0,
        fontWeight: FontWeight.w500,
      ),
      headline3: TextStyle(
        color: lightPrimary.withOpacity(0.6),
        fontSize: 22.0,
        fontWeight: FontWeight.w400,
      ),
      subtitle1: TextStyle(
        color: darkPrimary,
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
      ),
      headline5: TextStyle(
        color: lightPrimary,
        fontSize: 22.0,
        fontWeight: FontWeight.w600,
      ),
      headline6: TextStyle(
        color: darkPrimary,
        fontSize: 22.0,
        fontWeight: FontWeight.w600,
      ),
      subtitle2: TextStyle(
        color: darkPrimary,
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
