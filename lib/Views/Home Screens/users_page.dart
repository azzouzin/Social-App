import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../Controllers/State Managment/navigation_manag.dart';
import '../Compenents/bottomnavbar.dart';

class UsersPage extends StatelessWidget {
  UsersPage({super.key});
  NavController navController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Obx(() {
            return Text(navController.appbartitle.value);
          }),
          actions: [
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
      body: Obx(() {
        return navController.isloading.value == true
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [],
              );
      }),
    );
  }
}
