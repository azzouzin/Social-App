import 'package:firebase/Controllers/Bindings/auth_bindings.dart';
import 'package:firebase/Views/Login%20Screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Views/Register/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    title: 'Sports Channels',
    theme: ThemeData(
      primaryColor: Color(0xFFC7F9CC),
    ),
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: (() => LoginScreen()), binding: AuthBindings()),
      GetPage(
        name: '/register',
        page: (() => RegisterScreen()),
      )
    ],
  ));
}
