import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../Modules/user.dart';

class UsersController extends GetxController {
  bool isloading = true;
  RxList appusers = [].obs;
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getallusers();
  }
}
