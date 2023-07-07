import 'package:firebase/Controllers/Bindings/auth_bindings.dart';
import 'package:firebase/Views/Home%20Screens/home_page.dart';
import 'package:firebase/Views/Login%20Screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Views/Login Screens/Register/register_page.dart';
import 'Views/Compenents/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    title: 'Sports Channels',
    theme: lightTheme,
    darkTheme: darkTheme,
    themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
    initialRoute: '/home',
    getPages: [
      GetPage(name: '/', page: (() => LoginScreen()), binding: AuthBindings()),
      GetPage(
        name: '/register',
        page: (() => RegisterScreen()),
      ),
      GetPage(name: '/home', page: (() => Homepage()), binding: AuthBindings())
    ],
  ));
}
