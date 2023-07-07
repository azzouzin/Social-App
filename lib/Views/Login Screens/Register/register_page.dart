import 'package:firebase/Controllers/State%20Managment/auth_manag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
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
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'phone',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    authControl.register(_emailController, _passwordController,
                        _nameController, _phoneController, false);
                  },
                  child: Text('Register with Email/Password'),
                  style: ElevatedButton.styleFrom(primary: Color(0xFF80ed99)),
                ),
                SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () {
                    authControl.register(_emailController, _passwordController,
                        _nameController, _phoneController, true);
                  },
                  child: Text('Register with Google'),
                  style: ElevatedButton.styleFrom(primary: Color(0xFF80ed99)),
                ),
                SizedBox(height: 8.0),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Back to login',
                    style: TextStyle(color: Colors.black),
                  ),
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
