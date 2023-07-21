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

  List<List<String>> comments = [];
  List<List<AppUser?>> usercomment = [];

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
          likes.add(value.docs.length);

          posts.add(Post.fromMap(element.data()));
          postsids.add(element.id);
          print(element.data());
          print(posts);
          print("Number of posts = ${posts.length}");

          update();
        }).catchError((e) {
          print(e);
        });

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

  Future<String?> deletepost(index) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postsids[index])
        .delete()
        .then((value) {
      return 'ok';
    }).onError((error, stackTrace) {
      return 'error';
    });

    return 'null';
  }

  Future<void> getComments() async {
    var i = 0;
    QuerySnapshot postsSnapshot =
        await FirebaseFirestore.instance.collection('posts').get();
    for (DocumentSnapshot postDoc in postsSnapshot.docs) {
      comments.add([]);
      usercomment.add([]);
      QuerySnapshot commentsSnapshot =
          await postDoc.reference.collection('comments').get();
      for (DocumentSnapshot commentDoc in commentsSnapshot.docs) {
        String comment = commentDoc.get('comment');
        print('this is the document id ${commentDoc.id}');
        AppUser? appuser = await UserServices().getspecificuser(commentDoc.id);
        usercomment[i].add(appuser);
        comments[i].add(comment);
        print("i = $i");
        // print(comment[i].length);
        // int commentLength = comment[i].isEmpty ? 0 : comment[i].length;
        // print(
        //   "Comment Length: $commentLength, For $i post . Comment: $comment");

        print(
            "The user is: ${appuser!.email}, For $i post . Comment: $comment");
      }
      i = i + 1;
    }
  }

  void addcomment(String profileid, int index, String coment, AppUser appUser) {
    comments[index].add(coment);

    usercomment[index].add(appUser);
    update();
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
