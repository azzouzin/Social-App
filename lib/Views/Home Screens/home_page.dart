import 'package:firebase/Controllers/State%20Managment/navigation_manag.dart';
import 'package:firebase/Controllers/State%20Managment/posts_mang.dart';
import 'package:firebase/Modules/post.dart';
import 'package:firebase/Views/Compenents/bottomnavbar.dart';
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
              ? Center(child: CircularProgressIndicator())
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
                          postitem(
                              Post(
                                  uid: postController.posts[index - 1].uid,
                                  postImage:
                                      postController.posts[index - 1].postImage,
                                  date: postController.posts[index - 1].date
                                      .substring(0, 11),
                                  name: postController.posts[index - 1].name,
                                  text: postController.posts[index - 1].text,
                                  photo: imgs.last,
                                  tags: postController.posts[index - 1].tags),
                              index - 1),
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

  Widget postitem(Post post, int index) {
    TextEditingController textEditingController = TextEditingController();
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 5, color: Colors.black.withOpacity(0.5))
          ]),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Profile picture
              ClipOval(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.network(
                    post.photo,
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

              Column(
                crossAxisAlignment: CrossAxisAlignment
                    .start, // Align elements to start from the same point on the right
                children: [
                  Text(
                    post.name,
                    style: Get.textTheme.titleSmall,
                  ),
                  Text(
                    post.date,
                    style: Get.textTheme.bodySmall,
                  ),
                ],
              ),

              Column(
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset(
                      'assets/ver.png',
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              //three dots
              Icon(Iconsax.more)
            ],
          ),
          Divider(
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              post.text,
              textAlign: TextAlign.start,
              style: Get.textTheme.titleSmall!.copyWith(fontSize: 13),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              post.tags,
              style: Get.textTheme.titleSmall!
                  .copyWith(fontSize: 13, color: Colors.blue),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: post.postImage == null
                ? Container()
                : Image.network(
                    post.postImage!,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
          ),
          SizedBox(
            height: 5,
          ),
          //LIKES AND COMMENTS
          Row(
            children: [
              Icon(
                Iconsax.lovely,
                color: Colors.red,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                postController.likes[index].toString(),
                style: TextStyle(color: Colors.grey),
              ),
              Expanded(child: Container()),
              Icon(
                Iconsax.messages_25,
                color: Colors.red,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '1200 Comments',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            thickness: 1,
          ),

          //Display Comments
          Container(
            height: Get.height * 0.2,
            child: ListView.separated(
                itemBuilder: (context, i) {
                  return Row(
                    children: [
                      //Profile picture
                      ClipOval(
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.network(
                            imgs.first,
                            scale: 10,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      //Comment
                      Expanded(
                        child: Text(
                          postController.comments[index],
                          style: Get.textTheme.titleSmall,
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          postController.likePost(
                              navController.profile!.uid!, index);
                        },
                        child: Icon(
                          Iconsax.heart,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Like',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, i) {
                  return Divider(
                    thickness: 5,
                  );
                },
                itemCount: postController.comments[index].length),
          ),

          //PUT IN COMMENT
          Row(
            children: [
              //Profile picture
              ClipOval(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.network(
                    navController.profile!.image!,
                    scale: 10,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              //Comment
              Expanded(
                child: TextField(
                  controller: textEditingController,
                  style: Get.textTheme.bodySmall,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Write a comment ...'),
                ),
              ),

              InkWell(
                onTap: () {
                  postController.addcomment(navController.profile!.uid!, index,
                      textEditingController.text);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Icon(Iconsax.message_add),
                ),
              ),
              InkWell(
                onTap: () {
                  postController.likePost(navController.profile!.uid!, index);
                },
                child: Icon(
                  Iconsax.lovely1,
                  color: Colors.red,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Like',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
