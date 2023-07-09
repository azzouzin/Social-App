import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../Controllers/State Managment/navigation_manag.dart';
import '../Compenents/bottomnavbar.dart';
import '../Compenents/utils.dart';

class MessegePage extends StatelessWidget {
  MessegePage({super.key});
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
      body: Column(
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
                            imgs[2],
                            fit: BoxFit.cover,
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
                      imgs[2],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Azzouz Merouani',
            style: Get.textTheme.titleSmall,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'My Bio ...',
            style: Get.textTheme.bodySmall,
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
                      '100',
                      style: Get.textTheme.titleSmall,
                    ),
                    Text(
                      'Post',
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
          InkWell(
            onTap: () {},
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: Get.size.width,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    'Edit Profile',
                    style: Get.textTheme.headlineLarge,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
