import 'package:firebase/Views/Compenents/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddPost extends StatelessWidget {
  const AddPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Add post"),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Iconsax.arrow_left,
            color: const Color.fromARGB(255, 8, 8, 8),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
