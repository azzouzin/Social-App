import 'package:firebase/Views/Compenents/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../Controllers/State Managment/auth_manag.dart';
import '../../Controllers/State Managment/navigation_manag.dart';

class SettingsPage extends StatelessWidget {
  NavController navController = Get.find();
  AuthControl authController = Get.find();

  SettingsPage({super.key});
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
        if (count.value == 3000) {
          return Container();
        } else {
          return navController.isloading.value == true
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: Get.size.height * 0.24,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                  height: Get.size.height * 0.2,
                                  width: Get.size.width * 0.99,
                                  padding: EdgeInsets.all(5),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4),
                                          topRight: Radius.circular(4)),
                                      child: Image.network(
                                        navController.profile!.image!,
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          } else {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                        },
                                      ))),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              height: Get.size.width * 0.3,
                              width: Get.size.width * 0.3,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Get.theme.scaffoldBackgroundColor),
                              child: ClipOval(
                                child: Image.network(
                                  navController.profile!.image!,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        navController.profile!.name!,
                        style: Get.textTheme.titleSmall,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          navController.profile!.bio!,
                          textAlign: TextAlign.center,
                          style: Get.textTheme.bodySmall,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  '0',
                                  style: Get.textTheme.titleSmall,
                                ),
                                Text(
                                  'Post',
                                  style: Get.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          )),
                          Expanded(
                              child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  '0',
                                  style: Get.textTheme.titleSmall,
                                ),
                                Text(
                                  'Friends',
                                  style: Get.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          )),
                          Expanded(
                              child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  '0',
                                  style: Get.textTheme.titleSmall,
                                ),
                                Text(
                                  'Followrs',
                                  style: Get.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          )),
                          Expanded(
                              child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  '0',
                                  style: Get.textTheme.titleSmall,
                                ),
                                Text(
                                  'following',
                                  style: Get.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: Get.width * 0.9,
                        height: Get.height * 0.075,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: OutlinedButton(
                            onPressed: () {
                              Get.toNamed('/edit');
                            },
                            child: Icon(Iconsax.edit),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Dark Mode',
                            style:
                                Get.textTheme.bodySmall!.copyWith(fontSize: 15),
                          ),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            decoration: BoxDecoration(
                              color:
                                  Get.isDarkMode ? Colors.black : Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Switch(
                                activeColor: Get.theme.primaryColor,
                                value: Get.isDarkMode,
                                onChanged: (bool value) {
                                  print(Get.isDarkMode);
                                  Get.changeThemeMode(Get.isDarkMode
                                      ? ThemeMode.light
                                      : ThemeMode.dark);
                                  Get.offNamed('/home');
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: Get.size.width * 0.75,
                        height: 40,
                        child: OutlinedButton(
                            onPressed: () {
                              authController.logout();
                            },
                            child: Center(
                              child: Text(
                                'Log Out',
                                style: Get.textTheme.headlineLarge
                                    ?.copyWith(color: Colors.blue),
                              ),
                            )),
                      ),
                    ],
                  ),
                );
        }
      }),
    );
  }

  var count = 0.obs;
  changestate() {
    count++;
  }
}
