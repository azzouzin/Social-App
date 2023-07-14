import 'package:firebase/Controllers/Bindings/auth_bindings.dart';
import 'package:firebase/Controllers/Bindings/home_bindings.dart';
import 'package:firebase/Views/Home%20Screens/add_post.dart';
import 'package:firebase/Views/Home%20Screens/home_page.dart';
import 'package:firebase/Views/Home%20Screens/settings_page.dart';
import 'package:firebase/Views/Home%20Screens/users_page.dart';
import 'package:firebase/Views/Login%20Screens/login_page.dart';
import 'package:firebase/Views/Login%20Screens/onbord.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Views/Home Screens/messeg_page.dart';
import 'Views/Login Screens/Register/register_page.dart';
import 'Views/Compenents/theme.dart';
import 'Views/User Screens/edit_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    title: 'Flutter Chat',
    theme: lightTheme,
    darkTheme: darkTheme,
    themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: (() => OnBord())),
      GetPage(
          name: '/login', page: (() => LoginScreen()), binding: AuthBindings()),
      GetPage(
        name: '/register',
        page: (() => RegisterScreen()),
        binding: AuthBindings(),
      ),
      GetPage(
          name: '/home',
          page: (() => Homepage()),
          bindings: [AuthBindings(), HomeBindings()]),
      GetPage(
          name: '/addpost', page: (() => AddPost()), binding: HomeBindings()),
      GetPage(
          name: '/settings',
          page: (() => SettingsPage()),
          binding: HomeBindings()),
      GetPage(
          name: '/users', page: (() => UsersPage()), binding: HomeBindings()),
      GetPage(
          name: '/chats', page: (() => MessegePage()), binding: HomeBindings()),
      GetPage(
          name: '/edit',
          page: (() => EditProfilePage()),
          binding: HomeBindings()),
    ],
  ));
}
