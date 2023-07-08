import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavController extends GetxController {
  List<Color> currentpageclr = [
    Colors.blue,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
  ].obs;
  RxInt selectedIndex = 0.obs;

  void gotopage(i) {
    if (i == 2) {
      Get.toNamed('/addpost');
    } else {
      selectedIndex.value = i;
      colorchange(i);
    }
  }

  colorchange(int index) {
    for (var i = 0; i <= currentpageclr.length - 1; i++) {
      if (index == i) {
        currentpageclr[i] = Colors.blue;
      } else {
        currentpageclr[i] = Colors.grey;
      }
    }
  }
}
