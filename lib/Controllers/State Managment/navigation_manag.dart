import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Controllers/Services/user_services.dart';
import 'package:firebase/Modules/user.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NavController extends GetxController {
  RxBool isloading = false.obs;

  AppUser? profile = AppUser(
      email: 'azz',
      bio: 'bio',
      image: 'image',
      isEmailV: false,
      name: "Unknown",
      phone: 'Unknown',
      uid: 'Unkown');

  RxString appbartitle = 'Home'.obs;

  List<Color> currentpageclr = [
    Colors.blue,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
  ].obs;

  RxInt selectedIndex = 0.obs;

  Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
    2: GlobalKey<NavigatorState>(),
    3: GlobalKey<NavigatorState>(),
  };

  Future<void> gotopage(int i) async {
    isloading.value = true;
    if (i >= 0 && i < 5) {
      selectedIndex.value = i;
      colorchange(i);
      print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii = $i");
      appbartitle.value = i == 0
          ? 'Home'
          : i == 1
              ? 'Messeges'
              : i == 2
                  ? "Add Post"
                  : "Settings";

      i == 0 ? Get.offAllNamed('/home') : null;
      i == 1 ? Get.toNamed('/chats') : null;
      i == 2 ? Get.toNamed('/addpost') : null;
      if (i == 3) {
        Get.toNamed('/settings');
        profile = await getUser();
        if (profile == null) {
          Get.snackbar('Error getting Your info ', 'Error getting Your info ');
        }
      }
    }
    isloading.value = false;
  }

  File? selectedImage;

  final storage = firebase_storage.FirebaseStorage.instance;
////////////////////////////////////////////////////////////////////////////
  colorchange(int index) {
    for (var i = 0; i <= currentpageclr.length - 1; i++) {
      if (index == i) {
        currentpageclr[i] = Colors.blue;
      } else {
        currentpageclr[i] = Colors.grey;
      }
    }
  }

  Future<void> pickImage() async {
    try {
      final ImagePicker _imagePicker = ImagePicker();
      final XFile? image =
          await _imagePicker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        print(
            "THIS IS IMAGE PAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAATH${image.path}");
        print(selectedImage);
        selectedImage = File(image.path);
        print(selectedImage);
        update();
      } else {
        print('You didnt pick any image');
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  String imageUrl = '';
  void uploadImage({required name, required bio, required phone}) async {
    print('name =========== $name');
    print(bio);
    print(phone);
    isloading.value = true;
    update();
    await storage
        .ref()
        .child('users/${Uri.file(selectedImage!.path).pathSegments.last}')
        .putFile(selectedImage!)
        .then((p0) {
      print(p0);
      p0.ref.getDownloadURL().then((value) {
        print(value);
        imageUrl = value;
        profile!.image = imageUrl;
        FirebaseFirestore.instance
            .collection('users')
            .doc(profile!.uid)
            .update(profile!.toMap())
            .then((value) {
          print('OK Photo User Updated');
          updatuser(name: name, bio: bio, phone: phone);
          isloading.value = false;

          Get.toNamed('/settings');
          imageUrl = '';
        }).onError((error, stackTrace) {
          print(e);
          isloading.value = false;
          update();
        });
      });
    }).onError((error, stackTrace) {
      print(e);
      isloading.value = false;
      update();
    });
  }

  void updatuser({required name, required bio, required phone}) {
    if (name != '') {
      profile!.name = name;
    }
    if (bio != '') {
      profile!.bio = bio;
    }
    if (phone != '') {
      profile!.phone = phone;
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(profile!.uid)
        .update(profile!.toMap())
        .then((value) {
      print('OK User Updated');
      imageUrl = '';
    }).onError((error, stackTrace) {
      print(e);
    });
  }

  Future<AppUser?> getUser() async {
    return await UserServices().getTheUser();
  }

  @override
  void onInit() async {
    super.onInit();
    isloading.value = true;
    profile = await getUser();
    isloading.value = false;
    // Perform initialization tasks here

    // ...
  }
}
