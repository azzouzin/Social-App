import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyMiddelware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return const RouteSettings(name: '/home');
    } else {
      return null;
    }
  }
}
