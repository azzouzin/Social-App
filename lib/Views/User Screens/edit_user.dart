import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../Controllers/State Managment/navigation_manag.dart';
import '../Compenents/utils.dart';

class EditProfilePage extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  EditProfilePage({super.key});
  NavController navController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: () {
              navController.uploadImage(
                  name: nameController.text,
                  bio: bioController.text,
                  phone: phoneController.text);
            },
            child: Text(
              'UPDATE',
              style: TextStyle(
                fontSize: 17,
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          GetBuilder<NavController>(builder: (controller) {
            return controller.isloading.value
                ? LinearProgressIndicator()
                : Container();
          }),
          GetBuilder<NavController>(builder: (controller) {
            return Container(
              height: Get.size.height * 0.24,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          height: Get.size.height * 0.2,
                          width: Get.size.width * 0.99,
                          padding: EdgeInsets.all(5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4)),
                            child: controller.selectedImage == null
                                ? Image.network(
                                    navController.profile!.image!,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }
                                    },
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: FileImage(
                                                controller.selectedImage!),
                                            fit: BoxFit.cover)),
                                  ),
                          ))),
                  Container(
                    padding: EdgeInsets.all(5),
                    height: Get.size.width * 0.3,
                    width: Get.size.width * 0.3,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Get.theme.scaffoldBackgroundColor),
                    child: ClipOval(
                      child: controller.selectedImage == null
                          ? Image.network(
                              navController.profile!.image!,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          FileImage(controller.selectedImage!),
                                      fit: BoxFit.cover)),
                            ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: ClipOval(
                        child: InkWell(
                          onTap: () async {
                            await navController.pickImage();
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            color: Colors.blue,
                            child: Icon(
                              Iconsax.camera,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
          SizedBox(
            height: 20,
          ),
          defaultTextField(
              controller: nameController,
              hint: 'update your name ... ',
              icons: Iconsax.user,
              label: 'UserName'),
          defaultTextField(
              controller: bioController,
              hint: 'update your bio ... ',
              label: 'Bio',
              icons: Iconsax.user),
          defaultTextField(
              controller: phoneController,
              hint: 'update your phone ... ',
              icons: Iconsax.user,
              label: 'Phone'),

          /*    Text(
            navController.profile!.name!,
            style: Get.textTheme.titleSmall,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            navController.profile!.bio!,
            style: Get.textTheme.bodySmall,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: InkWell(
                onTap: () {},
                child: Column(
                  children: [
                    Text(
                      '100',
                      style: Get.textTheme.titleSmall,
                    ),
                    Text(
                      'Post',
                      style: Get.textTheme.bodySmall,
                    ),
                  ],
                ),
              )),
              Expanded(
                  child: InkWell(
                onTap: () {},
                child: Column(
                  children: [
                    Text(
                      '782',
                      style: Get.textTheme.titleSmall,
                    ),
                    Text(
                      'Friends',
                      style: Get.textTheme.bodySmall,
                    ),
                  ],
                ),
              )),
              Expanded(
                  child: InkWell(
                onTap: () {},
                child: Column(
                  children: [
                    Text(
                      '25k',
                      style: Get.textTheme.titleSmall,
                    ),
                    Text(
                      'Followrs',
                      style: Get.textTheme.bodySmall,
                    ),
                  ],
                ),
              )),
              Expanded(
                  child: InkWell(
                onTap: () {},
                child: Column(
                  children: [
                    Text(
                      '125',
                      style: Get.textTheme.titleSmall,
                    ),
                    Text(
                      'following',
                      style: Get.textTheme.bodySmall,
                    ),
                  ],
                ),
              ))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: Get.size.width * 0.75,
                  height: 40,
                  child: OutlinedButton(
                      onPressed: () {},
                      child: Center(
                        child: Text(
                          'Add Photos',
                          style: Get.textTheme.headlineLarge
                              ?.copyWith(color: Colors.blue),
                        ),
                      )),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Icon(Iconsax.edit),
                  ),
                ),
              )
            ],
          )
       */
        ],
      ),
    );
  }
}
