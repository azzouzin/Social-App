import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),

      // shadowColor: Colors.transparent,
      elevation: 0,
      backgroundColor: Colors.white,
    ),
    fontFamily: GoogleFonts.poppins().fontFamily,
    // Add your light theme properties here
    // For example:
    textTheme: TextTheme(
      bodySmall: TextStyle(
          color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w700),
      headlineLarge: TextStyle(
          color: Colors.white, fontSize: 17, fontWeight: FontWeight.w900),

      titleSmall: TextStyle(
          color: Colors.black, fontSize: 15, fontWeight: FontWeight.w900),
      bodyMedium: TextStyle(
          color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
      // Add more properties to customize the TextTheme
    ),
    primaryColor: Colors.blue,
    cardColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.light,
      accentColor: Colors.black,
    ));

final darkTheme = ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),

      // shadowColor: Colors.transparent,
      elevation: 0,
      backgroundColor: Colors.white,
    ),

    // Add your light theme properties here
    // For example:
    textTheme: TextTheme(
      bodySmall: TextStyle(
          color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
      headlineLarge: TextStyle(
          color: Colors.black, fontSize: 17, fontWeight: FontWeight.w900),

      titleSmall: TextStyle(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.w900),
      bodyMedium: TextStyle(
          color: Colors.black, fontSize: 12, fontWeight: FontWeight.w700),
      // Add more properties to customize the TextTheme
    ),
    cardColor: Color.fromARGB(255, 18, 1, 37),
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.indigo,
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
      accentColor: Colors.white,
    ));

Widget defaultbutton(
    {required Function onTap, required String child, required witdh}) {
  return Container(
    width: witdh,
    height: 40,
    child: OutlinedButton(
      onPressed: () {
        print('botton Clicked');
        onTap();
      },
      child: Center(
        child: Text(
          child,
          style: Get.textTheme.headlineLarge?.copyWith(color: Colors.blue),
        ),
      ),
    ),
  );
}
