import 'package:flutter/material.dart';
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
      bodyMedium: TextStyle(
          color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
      // Add more properties to customize the TextTheme
    ),
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.light,
      accentColor: Colors.red,
    ));

final darkTheme = ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily,
    // Add your dark theme properties here
    // For example:
    primaryColor: Colors.indigo,
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
      accentColor: Colors.yellow,
    ));

class ThemeBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, ThemeData themeData) builder;

  const ThemeBuilder({required this.builder});

  @override
  _ThemeBuilderState createState() => _ThemeBuilderState();
}

class _ThemeBuilderState extends State<ThemeBuilder> {
  bool isDarkTheme = false;

  void toggleTheme() {
    setState(() {
      isDarkTheme = !isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = isDarkTheme ? darkTheme : lightTheme;

    return widget.builder(context, themeData);
  }
}
