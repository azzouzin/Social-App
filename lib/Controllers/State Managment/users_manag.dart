import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../../Modules/messege.dart';
import '../../Modules/user.dart';

class UsersController extends GetxController {
  bool isloading = true;
  RxList appusers = [].obs;
  List<Messege> messegelist = [];
  File? selectedImage;
  String? imgurl;
  void getallusers() {
    isloading = true;
    update();

    FirebaseFirestore.instance.collection('users').get().then((value) async {
      value.docs.forEach((element) {
        appusers.add(AppUser.fromMap(element.data()));
      });

      print('The Users ${appusers}');
      isloading = false;
      update();
    }).onError((error, stackTrace) {
      print(error.toString());
      Get.showSnackbar(GetSnackBar(
          message: error.toString(),
          icon: const Icon(
            Iconsax.warning_2,
          )));
      isloading = false;
      update();
    });
  }

  void sendMessege(
    id, {
    required String senderid,
    required String recieverid,
    required String date,
    required String text,
  }) {
    isloading = true;
    update();
    var messege = Messege(
      senderid: senderid,
      date: date,
      recieverid: recieverid,
      text: text,
      imgurl: imgurl,
    );
    imgurl = null;
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('chats')
        .doc(recieverid)
        .collection('messeges')
        .add(messege.toMap())
        .then((value) {
      print(value.toString());
      isloading = false;
      update();
    }).catchError((e) {});

    FirebaseFirestore.instance
        .collection('users')
        .doc(recieverid)
        .collection('chats')
        .doc(id)
        .collection('messeges')
        .add(messege.toMap())
        .then((value) {
      print(value.toString());
      isloading = false;
    }).catchError((e) {});
  }

  Future<String?> uploadImage() async {
    String? msg;
    await pickImage();
    await FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(selectedImage!.path).pathSegments.last}')
        .putFile(selectedImage!)
        .then((p0) {
      print(p0);
      p0.ref.getDownloadURL().then((value) async {
        print("This is the value returned From Firebase Storage $value");
        imgurl = value;
        print("This is the value of ImgUrL Variable $value");
        msg = value;
      });
    }).onError((error, stackTrace) {
      print(error);
      msg = error.toString();
    });
    return msg;
  }

  Future<File?> pickImage() async {
    try {
      final ImagePicker _imagePicker = ImagePicker();
      final XFile? image =
          await _imagePicker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        print("THIS IS IMAGE Path${image.path}");
        selectedImage = File(image.path);
        print(selectedImage!.path);
      } else {
        print('You didnt pick any image');
      }
    } on Exception catch (e) {
      print(e);
    }
    return selectedImage;
  }

  void getMessege(String recieverid, String senderid) {
    isloading = true;
    update();
    FirebaseFirestore.instance
        .collection('users')
        .doc(senderid)
        .collection('chats')
        .doc(recieverid)
        .collection('messeges')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      messegelist = [];
      event.docs.forEach((element) {
        messegelist.add(Messege.fromMap(element.data()));
        print(element.data());

        print(messegelist);
        update();
      });
    });

    isloading = false;

    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getallusers();
  }
}
