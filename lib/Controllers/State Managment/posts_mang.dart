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

  void getposts() {
    isloading = true;
    update();
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        posts.add(Post.fromMap(element.data()));

        print(posts);
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getposts();
  }
}
