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

import 'Controllers/State Managment/middlwear.dart';
import 'Views/Home Screens/messeg_page.dart';
import 'Views/Login Screens/Register/register_page.dart';
import 'Views/Compenents/theme.dart';
import 'Views/User Screens/edit_user.dart';

/*Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle notification when app is in background
  print(message.data.toString());
  Get.snackbar('on messege', message.data.toString());
}
*/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
/*
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  var token = await messaging.getToken();
  print(token);
//Requaset Permissions of FCM
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );  
//On App Notifications FCM
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    Get.snackbar('on messege', event.data.toString());
  });
//On Click on notifications FCM
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    Get.snackbar('on  onMessageOpenedApp messege', event.data.toString());
  });
//Background Notification FCM
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
*/
  runApp(GetMaterialApp(
    title: 'Pingle ',
    theme: lightTheme,
    darkTheme: darkTheme,
    themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: (() => OnBord()), middlewares: [MyMiddelware()]),
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
          bindings: [HomeBindings(), AuthBindings()]),
      GetPage(
          name: '/chats', page: (() => MessegePage()), binding: HomeBindings()),
      GetPage(
          name: '/edit',
          page: (() => EditProfilePage()),
          binding: HomeBindings()),
    ],
  ));
}
