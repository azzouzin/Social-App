import 'package:firebase/Controllers/State%20Managment/auth_manag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../Compenents/utils.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/logo1.png',
                        scale: 12,
                      ),
                    ),
                    defaultTextField(
                      hint: 'Write Your Name',
                      icons: Iconsax.user,
                      label: 'Name',
                      controller: _nameController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultTextField(
                        controller: _emailController,
                        icons: Iconsax.message,
                        hint: 'Email',
                        label: 'Email'),
                    const SizedBox(height: 10.0),
                    defaultTextField(
                        controller: _passwordController,
                        label: 'Password',
                        hint: 'Password',
                        icons: Iconsax.password_check),
                    const SizedBox(height: 10.0),
                    defaultTextField(
                        controller: _passwordController2,
                        icons: Iconsax.password_check,
                        hint: "Confirme Password",
                        label: "Password"),
                    defaultTextField(
                        controller: _phoneController,
                        icons: Iconsax.clock,
                        hint: "Phone",
                        label: "Phone Number"),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_passwordController.text !=
                            _passwordController2.text) {
                          Get.snackbar('The Passwords Dosent Match',
                              "The Passwords Dosent Match");
                        } else {
                          authControl.register(
                              _emailController,
                              _passwordController,
                              _nameController,
                              _phoneController,
                              false);
                        }
                      },
                      child: Text(
                        'Sign Up',
                        style: Get.textTheme.titleSmall!
                            .copyWith(color: Colors.white, fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(Get.width * 0.9, 60),
                        primary: const Color.fromARGB(255, 33, 123, 158),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
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
                    const SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        Get.snackbar('Comming soon', '');
                      },
                      child: Image.asset("assets/gg.png"),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(Get.width * 0.9, 60),
                        primary: const Color.fromARGB(255, 206, 206, 206),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                return Center(
                    child: authControl.isloading.value == true
                        ? const CircularProgressIndicator()
                        : Container());
              }),
            ],
          ),
        ),
      ),
    );
  }
}
