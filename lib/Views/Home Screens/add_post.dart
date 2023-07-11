import 'package:firebase/Views/Compenents/bottomnavbar.dart';
import 'package:firebase/Views/Compenents/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../Controllers/State Managment/navigation_manag.dart';

class AddPost extends StatelessWidget {
  AddPost({super.key});
  NavController navController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'POST',
              style: TextStyle(
                fontSize: 17,
                color: Colors.blue,
              ),
            ),
          )
        ],
        automaticallyImplyLeading: false,
        title: Text("Creat Post"),
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
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
            //Profile
            Row(
              children: [
                Container(
                  height: Get.size.width * 0.2,
                  width: Get.size.width * 0.2,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Get.theme.scaffoldBackgroundColor),
                  child: ClipOval(
                    child: Image.network(
                      navController.profile!.image!,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                    height: Get.size.width * 0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          navController.profile!.name!,
                          style: Get.textTheme.titleSmall,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'public',
                          style: Get.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: TextFormField(
              decoration: InputDecoration(
                  hintText:
                      "What's on your mind ? ${navController.profile!.name!}"),
            )),

            Row(
              children: [
                defaultbutton(
                    witdh: Get.size.width * 0.45,
                    child: 'Add Photos',
                    onTap: () {
                      print('hihhihi');
                    }),
                defaultbutton(
                    witdh: Get.size.width * 0.45,
                    child: 'Add tags #',
                    onTap: () {
                      print('hihhihi');
                    }),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
