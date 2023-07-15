import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../Controllers/Services/auth_services.dart';
import '../../Controllers/State Managment/auth_manag.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AuthServices authServices = AuthServices();
  AuthControl authControl = Get.find();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Text(
                    "Hello Again!",
                    style: Get.textTheme.titleLarge!
                        .copyWith(color: const Color.fromARGB(255, 49, 49, 49)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Welcom back you've",
                    style: Get.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 49, 49, 49)),
                  ),
                  Text(
                    "been missed",
                    style: Get.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 49, 49, 49)),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        labelText: 'Enter Email ',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Recovery Password',
                        style: Get.textTheme.bodySmall!.copyWith(
                            color: const Color.fromARGB(255, 39, 39, 39)),
                      )
                    ],
                  ),
                  SizedBox(height: 40.0),
                  ElevatedButton(
                    onPressed: () {
                      authControl.login(_emailController, _passwordController);
                    },
                    child: Text(
                      'Sign In',
                      style: Get.textTheme.titleSmall!
                          .copyWith(color: Colors.white, fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(Get.width * 0.9, 60),
                      primary: Color.fromARGB(255, 255, 96, 96),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Get.width * 0.3,
                        height: 2,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.5)
                        ])),
                      ),
                      Text(
                        'Or continue with',
                        style: Get.textTheme.bodySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: Get.width * 0.3,
                        height: 2,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Colors.black.withOpacity(0.5),
                          Colors.transparent,
                        ])),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      authControl.loginwithgoogle();
                    },
                    child: Container(
                      width: Get.width * 0.2,
                      height: Get.width * 0.12,
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white, width: 2.5)),
                      child: Image.asset('assets/gg.png'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                        onPressed: () {
                          Get.toNamed('/register');
                        },
                        child: Text(
                          'not a member ? Register now',
                          style: Get.textTheme.titleSmall!
                              .copyWith(fontWeight: FontWeight.w600),
                        )),
                  ),
                ],
              ),
            ),
            Obx(() {
              return Center(
                  child: authControl.isloading.value == true
                      ? CircularProgressIndicator()
                      : Container());
            }),
          ],
        ),
      ),
    );
  }
}
