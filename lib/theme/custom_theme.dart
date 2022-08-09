import 'package:flutter/material.dart';

class AppTheme {
  static const Color _appbarColorLight = Colors.blue;
  static final Color _appbarColorDark = Colors.blueGrey.shade800;
  static const Color _iconColor = Colors.white;

  static ThemeData get lightTheme {
    //1
    return ThemeData(
        //2
        primaryColor: Colors.purple,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: _appbarColorLight,
        ),
        fontFamily: 'Montserrat', //3
        buttonTheme: ButtonThemeData(
          // 4
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: Colors.purple[400],
        ));
  }

  static ThemeData get darkTheme {
    return ThemeData(
        primaryColor: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.blueGrey[100],
        appBarTheme: AppBarTheme(
            color: _appbarColorDark,
            iconTheme: const IconThemeData(color: _iconColor)),
        fontFamily: 'Montserrat',
        //textTheme: ThemeData.dark().textTheme,
        buttonTheme: ButtonThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: Colors.purple,
        ));
  }
}
