import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData appTheme() {
  return ThemeData(
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: HexColor("#BF0000"),
      iconTheme: IconThemeData(color: Colors.white),
      actionsIconTheme: IconThemeData(color: Colors.white),
      textTheme: TextTheme(
        headline6: TextStyle(
            fontSize: 20,
            fontFamily: 'Montserrat',
            color: Colors.white,
            fontWeight: FontWeight.w600),
      ),
    ),
    fontFamily: 'Montserrat',
    backgroundColor: HexColor("#1A1A1A"),
    splashColor: Colors.red,
    indicatorColor: Colors.red,
    primarySwatch: Colors.red,
    buttonColor: HexColor("#BF0000"),
    iconTheme: IconThemeData(
      size: 25,
      color: Colors.red,
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      actionTextColor: Colors.blue,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(fontSize: 23),
      subtitle1: TextStyle(
          fontSize: 16,
          //  fontWeight: FontWeight.bold,
          color: Colors.black),
      headline5: TextStyle(fontSize: 18, color: Colors.black),
      subtitle2: TextStyle(fontSize: 16, color: Colors.black54),
    ),
    buttonTheme: ButtonThemeData(
      //  padding: EdgeInsets.all(10),
      shape: StadiumBorder(),
      buttonColor: Color(0XFF54B0F3),
    ),
  );
}
