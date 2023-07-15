import 'package:firebase/Views/Compenents/bottomnavbar.dart';
import 'package:firebase/Views/Compenents/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../Controllers/State Managment/navigation_manag.dart';

class SettingsPage extends StatelessWidget {
  NavController navController = Get.find();
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
              : Column(
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
                                '100',
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
                                '782',
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
                                '25k',
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
                                '125',
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
                    Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            width: Get.size.width * 0.75,
                            height: 40,
                            child: OutlinedButton(
                                onPressed: () {},
                                child: Center(
                                  child: Text(
                                    'Add Photos',
                                    style: Get.textTheme.headlineLarge
                                        ?.copyWith(color: Colors.blue),
                                  ),
                                )),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: OutlinedButton(
                              onPressed: () {
                                Get.toNamed('/edit');
                              },
                              child: Icon(Iconsax.edit),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                );
        }
      }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Get.isDarkMode ? Iconsax.moon : Iconsax.sun),
          onPressed: () {
            print(Get.isDarkMode);
            Get.changeThemeMode(
                Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);

            print(Get.theme.cardColor.toString());
            print(Get.isDarkMode);
          }),
    );
  }

  var count = 0.obs;
  changestate() {
    count++;
  }
}
