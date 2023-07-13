import 'package:firebase/Controllers/State%20Managment/users_manag.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../Controllers/State Managment/navigation_manag.dart';
import '../Compenents/bottomnavbar.dart';
import '../Compenents/utils.dart';

class MessegePage extends StatelessWidget {
  MessegePage({super.key});
  NavController navController = Get.find();
  UsersController userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          userController.getallusers();
        }),
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: userController.appusers.isEmpty
              ? Text(
                  'There is no one here',
                  style: Get.textTheme.titleSmall,
                )
              : ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, i) {
                    return InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Profile picture
                          ClipOval(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Image.network(
                                userController.appusers[i].image ??
                                    'https://img.freepik.com/photos-gratuite/lapin-dessin-anime-mignon-genere-par-ai_23-2150288877.jpg?size=626&ext=jpg',
                                scale: 10,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                          //username + date
                          ,
                          SizedBox(
                            width: 20,
                          ),

                          Text(
                            userController.appusers[i].name,
                            style: Get.textTheme.titleSmall,
                          ),

                          //    Expanded(child: Container()),
                          //three dots
                          //   Icon(Iconsax.more)
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, i) => Divider(thickness: 2),
                  itemCount: userController.appusers.length),
        ));
  }
}
