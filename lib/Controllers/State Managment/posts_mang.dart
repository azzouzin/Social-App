import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Controllers/Services/post_service.dart';
import 'package:firebase/Modules/post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../Modules/user.dart';
import '../Services/user_services.dart';

class PostController extends GetxController {
  bool isloading = false;
  PostsServices postsServices = PostsServices();
  List<Post> posts = [];
  List<String> postsids = [];
  List<int> likes = [];

  List<String> comments = [];

  File? postimage;
  Future<void> creatnewpost({
    required String text,
    required String date,
    required String tags,
  }) async {
    isloading = true;
    update();

    await postsServices.uploadImage(date: date, tags: tags, text: text);
    print("POST IMAGE = $postimage");

    //await postsServices.creatpost(post);

    isloading = false;
    update();
  }

  Future<AppUser?> getUser() async {
    return await UserServices().getTheUser();
  }

  File? getimage() {
    return postsServices.selectedImage;
  }

  void pickimage() async {
    postimage = await postsServices.pickImage();
    update();
  }

  void getposts() async {
    isloading = true;
    update();
    await getComments();
    FirebaseFirestore.instance.collection('posts').get().then((value) async {
      var i = 0;
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          print(value.docs.length);
          likes.add(value.docs.length);

          posts.add(Post.fromMap(element.data()));
          postsids.add(element.id);
          update();
        }).catchError((e) {
          print(e);
        });

        print(posts);

        print(comments[i].length);
        i = i + 1;
      });

      Get.showSnackbar(GetSnackBar(
          duration: Duration(seconds: 3),
          message: 'Welcome Back ',
          icon: Icon(
            Iconsax.user,
          )));
      isloading = false;
      update();
    }).onError((error, stackTrace) {
      print(error.toString());
      Get.showSnackbar(GetSnackBar(
          message: error.toString(),
          icon: Icon(
            Iconsax.warning_2,
          )));
      isloading = false;
      update();
    });
  }

  void likePost(String profileid, int index) {
    print(
        "Like Called on post id ${postsids[index]} from account id $profileid");
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postsids[index])
        .collection('likes')
        .doc(profileid)
        .set({'liked': true}).then((value) {
      print('seccess');
    }).onError((error, stackTrace) {});
  }

  Future<void> getComments() async {
    QuerySnapshot postsSnapshot =
        await FirebaseFirestore.instance.collection('posts').get();
    for (DocumentSnapshot postDoc in postsSnapshot.docs) {
      QuerySnapshot commentsSnapshot =
          await postDoc.reference.collection('comments').get();
      for (DocumentSnapshot commentDoc in commentsSnapshot.docs) {
        String comment = commentDoc.get('comment');
        comments.add(comment);
        int commentLength = comment.length;
        print("Comment Length: $commentLength, Comment: $comment");
      }
    }
  }

  void addcomment(String profileid, int index, String coment) {
    print(
        "Comment Called on post id ${postsids[index]} from account id $profileid");
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postsids[index])
        .collection('comments')
        .doc(profileid)
        .set({'comment': coment}).then((value) {
      print('seccess comment add');
    }).onError((error, stackTrace) {});
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getposts();
  }
}
