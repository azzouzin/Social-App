import 'package:firebase/Controllers/State%20Managment/navigation_manag.dart';
import 'package:firebase/Controllers/State%20Managment/posts_mang.dart';
import 'package:firebase/Modules/post.dart';
import 'package:firebase/Views/Compenents/bottomnavbar.dart';
import 'package:firebase/Views/Compenents/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:like_button/like_button.dart';

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
                                  photo: postController.posts[index - 1].photo,
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
          color: Get.theme.cardColor,
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
                  child: post.photo == null
                      ? Container(
                          width: 100,
                          height: 100,
                          color: Colors.black,
                        )
                      : Image.network(
                          post.photo!,
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
              InkWell(
                  onTap: () async {
                    if (post.uid == navController.profile!.uid!) {
                      Get.dialog(
                        AlertDialog(
                          content: Container(
                            width: Get.width * 0.5,
                            height: Get.height * 0.1,
                            color: Colors.white,
                            child: InkWell(
                              onTap: () async {
                                String? msg;
                                msg = await postController.deletepost(index);
                                msg == 'ok'
                                    ? Get.snackbar('Post Deleted', '')
                                    : Get.snackbar(
                                        'Post Error', 'Unkown Error');
                              },
                              child: Center(
                                child: Text(
                                  'Delet Post',
                                  style: Get.textTheme.titleLarge!
                                      .copyWith(color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      Get.snackbar("Sorry The Post isn't Yours",
                          'to edit any post it must be yours');
                    }
                  },
                  child: Icon(Iconsax.more))
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
            child: post.postImage == 'null'
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
              LikeButton(
                  size: 30,
                  circleColor: CircleColor(
                      start: Color(0xff00ddff), end: Color(0xff0099cc)),
                  bubblesColor: BubblesColor(
                    dotPrimaryColor: Color(0xff33b5e5),
                    dotSecondaryColor: Color(0xff0099cc),
                  ),
                  likeBuilder: (bool isLiked) {
                    return Icon(
                      Icons.heart_broken_sharp,
                      color: isLiked ? Colors.purple : Colors.grey,
                      size: 30,
                    );
                  },
                  likeCount: postController.likes[index],
                  onTap: (isliked) async {
                    postController.likePost(navController.profile!.uid!, index);
                    return true;
                  },
                  countBuilder: (count, isLiked, string) {
                    var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
                    Widget result;
                    if (count == 0) {
                      result = Text(
                        "love",
                        style: TextStyle(color: color),
                      );
                    } else
                      result = Text(
                        string,
                        style: TextStyle(color: color),
                      );
                    return result;
                  }),
              SizedBox(
                width: 5,
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
                '${postController.comments[index].length} Comments',
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
          GetBuilder<PostController>(builder: (controller) {
            return Container(
              height: controller.usercomment[index].length <= 2
                  ? null
                  : Get.height * 0.135,
              child: controller.usercomment[index].length <= 2
                  ? Column(
                      children: [
                        controller.usercomment[index].length == 1
                            ? Row(
                                children: [
                                  //Profile picture
                                  ClipOval(
                                    child: SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Image.network(
                                        controller
                                            .usercomment[index][0]!.image!,
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller
                                              .usercomment[index][0]!.name!,
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                        Text(
                                          controller.comments[index][0],
                                          style: Get.textTheme.titleSmall!,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        controller.usercomment[index].length == 2
                            ? Row(
                                children: [
                                  //Profile picture
                                  ClipOval(
                                    child: SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Image.network(
                                        controller
                                            .usercomment[index][1]!.image!,
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller
                                              .usercomment[index][1]!.name!,
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                        Text(
                                          controller.comments[index][1],
                                          style: Get.textTheme.titleSmall!,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    )
                  : ListView.separated(
                      itemBuilder: (context, i) {
                        return Row(
                          children: [
                            //Profile picture
                            ClipOval(
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: Image.network(
                                  controller.usercomment[index][i]!.image!,
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.usercomment[index][i]!.name!,
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    controller.comments[index][i],
                                    style: Get.textTheme.titleSmall!,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, i) {
                        return Divider(
                          thickness: 1,
                        );
                      },
                      itemCount: controller.comments[index].length),
            );
          }),

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
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: LikeButton(
                    circleColor: CircleColor(
                        start: Color(0xff00ddff), end: Color(0xff0099cc)),
                    bubblesColor: BubblesColor(
                      dotPrimaryColor: Color(0xff33b5e5),
                      dotSecondaryColor: Color(0xff0099cc),
                    ),
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        Iconsax.send1,
                        color: isLiked ? Colors.purple : Colors.blue,
                        size: 30,
                      );
                    },
                    onTap: (isliked) async {
                      postController.addcomment(
                          navController.profile!.uid!,
                          index,
                          textEditingController.text,
                          navController.profile!);
                      return true;
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
