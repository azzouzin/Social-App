import 'package:flutter/material.dart';

final lightTheme = ThemeData(

    // Add your light theme properties here
    // For example:
    primaryColor: Colors.blue,
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.light,
      accentColor: Colors.red,
    ));

final darkTheme = ThemeData(

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
