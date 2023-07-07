import 'package:firebase/Views/Compenents/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

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
      appBar: AppBar(title: Text("Home"), actions: [
        Icon(
          Iconsax.notification,
          color: Colors.black,
        ),
        SizedBox(width: 16),
        Icon(
          Iconsax.search_normal4,
          color: Colors.black,
        ),
        SizedBox(width: 16),
      ]),
      bottomNavigationBar: BottomNavBar(),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                children: [],
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
      ),
    );
  }
}
