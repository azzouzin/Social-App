import 'package:firebase/Controllers/Services/auth_services.dart';
import 'package:firebase/Modules/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Views/Home Screens/home_page.dart';

class AuthControl extends GetxController {
  RxBool isloading = false.obs;
  AuthServices authServices = AuthServices();
  String response = 'ERROR';
  void changeloadingstate() {
    isloading.value = !isloading.value;
  }

  Future<void> login(_emailController, _passwordController) async {
    changeloadingstate();
    response = await authServices.login(_emailController, _passwordController);
    if (response == 'ok') {
      Get.to(Homepage());
    } else {
      Get.snackbar('Error', response);
    }
    changeloadingstate();
  }

  Future<void> loginwithgoogle() async {
    changeloadingstate();
    response = await authServices.loginWithGoogle();
    if (response == 'ok') {
      Get.to(Homepage());
    } else {
      Get.snackbar('Error', response);
    }
    changeloadingstate();
  }

  Future<void> register(
      TextEditingController emailController,
      TextEditingController passwordController,
      TextEditingController nameController,
      TextEditingController phoneController,
      bool withgoogle) async {
    changeloadingstate();
    if (withgoogle == true) {
      response = await authServices.registerWithGoogle();
    } else {
      response = await authServices.registerUserWithEmailAndPassword(
        emailController.text,
        passwordController.text,
        phoneController.text,
        nameController.text,
      );
    }
    if (response == 'ok') {
      Get.offAllNamed('/');
    } else {
      Get.snackbar('Error', response);
    }
    changeloadingstate();
  }

  Future<void> logout() async {
    changeloadingstate();

    response = await authServices.logout();

    if (response == 'ok') {
      Get.offAllNamed('/');
    } else {
      Get.snackbar('Error', response);
    }
    changeloadingstate();
  }
}
