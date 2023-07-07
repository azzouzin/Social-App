import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/State Managment/auth_manag.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  AuthControl authControl = Get.find();
  var txt = 'light';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                ElevatedButton(
                  child: Text("LogOut"),
                  onPressed: () {
                    authControl.logout();
                  },
                ),
                ElevatedButton(
                  child: Text(txt),
                  onPressed: () {
                    Get.changeThemeMode(
                        Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                    print(Get.isDarkMode);
                    setState(() {
                      txt = Get.isDarkMode == true ? 'light' : 'dark';
                    });
                  },
                ),
              ],
            ),
          ),
          Obx(() {
            return Center(
                child: authControl.isloading.value == true
                    ? CircularProgressIndicator()
                    : Container());
          }),
        ],
      ),
    );
  }
}
