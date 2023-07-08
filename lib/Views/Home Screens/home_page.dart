import 'package:firebase/Modules/post.dart';
import 'package:firebase/Views/Compenents/bottomnavbar.dart';
import 'package:firebase/Views/Compenents/postitem.dart';
import 'package:firebase/Views/Compenents/utils.dart';
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
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: Get.size.width * 0.03,
                  horizontal: Get.size.width * 0.01),
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.3),
                            )
                          ]),
                          width: Get.size.width * 0.95,
                          height: Get.size.height * 0.3,
                          margin: EdgeInsets.only(bottom: 15),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: Get.size.width * 0.95,
                                height: Get.size.height * 0.3,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    imgs[0],
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    'Communicat with Family and Friends',
                                    style: Get.textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          Postitem(Post(
                              date: 'August 1 2023  11:06 pm',
                              name: "Azzouz Merouani",
                              desc:
                                  "this is random text this is random textthis is random textthis is random textthis is random textthis is random textthis is random text ",
                              photo: imgs.last,
                              hashtags: '#alger #dz #fpl #palastine')),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      );
                    }
                  }),
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
