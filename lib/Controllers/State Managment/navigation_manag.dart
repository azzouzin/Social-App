import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Controllers/Services/user_services.dart';
import 'package:firebase/Modules/user.dart';
import 'package:firebase/Views/Home%20Screens/home_page.dart';
import 'package:firebase/Views/Home%20Screens/messeg_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Views/Home Screens/settings_page.dart';
import '../../Views/Home Screens/users_page.dart';

class NavController extends GetxController {
  RxBool isloading = false.obs;

  AppUser? profile = AppUser(email: 'azz', bio: 'bio', image: 'image');

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
                  : i == 3
                      ? "Users"
                      : "Settings";

      i == 0 ? Get.offAllNamed('/home') : null;
      i == 1 ? Get.toNamed('/chats') : null;
      i == 2 ? Get.toNamed('/addpost') : null;
      i == 3 ? Get.toNamed('/users') : null;
      if (i == 4) {
        Get.toNamed('/settings');
        profile = await getUser();
        if (profile == null) {
          Get.snackbar('Error getting Your info ', 'Error getting Your info ');
        }
      }
    }
    isloading.value = false;
  }

  Rx<File?> selectedImage = null.obs;

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

  selectimage(File file) {}

  Future<void> pickImage() async {
    try {
      final ImagePicker _imagePicker = ImagePicker();
      final XFile? image =
          await _imagePicker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        selectedImage.value = File(image.path);
        print(image.path);
      } else {
        print('You didnt pick any image');
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<AppUser?> getUser() async {
    return await UserServices().getTheUser();
  }

  @override
  void onInit() {
    super.onInit();

    // Perform initialization tasks here

    // ...
  }
}
