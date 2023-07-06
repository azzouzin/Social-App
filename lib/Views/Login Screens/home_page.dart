import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/State Managment/auth_manag.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});
  AuthControl authControl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: ElevatedButton(
              child: Text("LogOut"),
              onPressed: () {
                authControl.logout();
              },
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
