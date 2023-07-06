import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    authControl.login(_emailController, _passwordController);
                  },
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(primary: Color(0xFF22577a)),
                ),
                SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () {
                    authControl.loginwithgoogle();
                  },
                  child: Text('Login with Google'),
                  style: ElevatedButton.styleFrom(primary: Color(0xFF22577a)),
                ),
                ElevatedButton(
                  onPressed: () => Get.toNamed('/register'),
                  child: Text('Register with Email/Password'),
                  style: ElevatedButton.styleFrom(primary: Color(0xFF80ed99)),
                ),
              ],
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
