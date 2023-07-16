import 'package:firebase/Controllers/Services/post_service.dart';
import 'package:firebase/Controllers/State%20Managment/posts_mang.dart';
import 'package:firebase/Views/Compenents/bottomnavbar.dart';
import 'package:firebase/Views/Compenents/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../Controllers/State Managment/navigation_manag.dart';

class AddPost extends StatelessWidget {
  AddPost({super.key});
  NavController navController = Get.find();
  PostController postController = Get.find();
  TextEditingController textEditingController = TextEditingController();
  TextEditingController tagsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              postController
                  .creatnewpost(
                      text: textEditingController.text,
                      date: DateTime.now().toUtc().toString(),
                      tags: tagsController.text)
                  .then((value) {
                Get.back();
              });
            },
            child: Text(
              'POST',
              style: TextStyle(
                fontSize: 17,
                color: Colors.blue,
              ),
            ),
          )
        ],
        automaticallyImplyLeading: false,
        title: Text("Creat Post"),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Iconsax.arrow_left,
            color: const Color.fromARGB(255, 8, 8, 8),
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GetBuilder<PostController>(builder: (controller) {
                    if (controller.isloading == true) {
                      return LinearProgressIndicator();
                    } else {
                      return Container();
                    }
                  }),
                  //Profile
                  Row(
                    children: [
                      Container(
                        height: Get.size.width * 0.2,
                        width: Get.size.width * 0.2,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Get.theme.scaffoldBackgroundColor),
                        child: ClipOval(
                          child: Image.network(
                            navController.profile!.image!,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
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
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: SizedBox(
                          height: Get.size.width * 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                navController.profile!.name!,
                                style: Get.textTheme.titleSmall,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'public',
                                style: Get.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: Get.width,
                    child: TextFormField(
                      maxLines: 10,
                      controller: textEditingController,
                      decoration: InputDecoration(
                          hintMaxLines: 10,
                          border: InputBorder.none,
                          hintText:
                              "What's on your mind ? ${navController.profile!.name!}"),
                    ),
                  ),

                  GetBuilder<PostController>(builder: (controller) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                          color: Colors.black.withOpacity(0.5),
                          height: Get.size.height * 0.2,
                          width: Get.size.width * 0.99,
                          padding: EdgeInsets.all(5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: postController.postimage == null
                                ? Center(
                                    child: Text('Add Some Images'),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: FileImage(
                                                postController.postimage!),
                                            fit: BoxFit.cover)),
                                  ),
                          )),
                    );
                  }),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                defaultbutton(
                    witdh: Get.size.width * 0.5,
                    child: 'Add Photos',
                    onTap: () async {
                      print('hihhihi');
                      postController.pickimage();
                    }),
                defaultbutton(
                    witdh: Get.size.width * 0.5,
                    child: 'Add tags #',
                    onTap: () {
                      Get.dialog(
                        AlertDialog(
                          title: Text('Tags #'),
                          content: TextField(
                            controller: tagsController,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text('Close'),
                            ),
                          ],
                        ),
                      );
                      print('hihhihi');
                    }),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
