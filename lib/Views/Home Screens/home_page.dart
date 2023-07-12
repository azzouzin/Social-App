import 'package:firebase/Controllers/State%20Managment/navigation_manag.dart';
import 'package:firebase/Controllers/State%20Managment/posts_mang.dart';
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
  NavController navController = Get.find();
  PostController postController = Get.find();
  var txt = 'light';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Container(
        margin: EdgeInsets.symmetric(
            vertical: Get.size.width * 0.03, horizontal: Get.size.width * 0.01),
        child: GetBuilder<PostController>(builder: (controler) {
          return controler.isloading == true
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: postController.posts.length + 1,
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
                              uid: '',
                              postImage:
                                  postController.posts[index - 1].postImage,
                              date: postController.posts[index - 1].date
                                  .substring(0, 11),
                              name: postController.posts[index - 1].name,
                              text: postController.posts[index - 1].text,
                              photo: imgs.last,
                              tags: postController.posts[index - 1].tags)),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      );
                    }
                  });
        }),
      ),
    );
  }
}
