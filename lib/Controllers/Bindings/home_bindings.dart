import 'package:firebase/Controllers/State%20Managment/navigation_manag.dart';
import 'package:firebase/Controllers/State%20Managment/theme_manag.dart';
import 'package:get/get.dart';

import '../State Managment/auth_manag.dart';
import '../State Managment/posts_mang.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<ThemeController>(ThemeController());
    Get.put<NavController>(NavController());
    Get.put<PostController>(PostController());
  }
}
