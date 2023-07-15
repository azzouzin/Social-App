import 'package:firebase/Controllers/State%20Managment/navigation_manag.dart';
import 'package:firebase/Controllers/State%20Managment/users_manag.dart';
import 'package:firebase/Modules/messege.dart';
import 'package:firebase/Modules/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen(this.appUser);
  final AppUser appUser;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textEditingController = TextEditingController();

  NavController navController = Get.find();

  UsersController userController = Get.find();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text(widget.appUser.name!),
        leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipOval(
              child: SizedBox(
                width: 50,
                height: 50,
                child: Image.network(
                  widget.appUser.image ??
                      'https://img.freepik.com/photos-gratuite/lapin-dessin-anime-mignon-genere-par-ai_23-2150288877.jpg?size=626&ext=jpg',
                  scale: 10,
                  fit: BoxFit.cover,
                ),
              ),
            )),
      ),
      body: Builder(builder: (context) {
        userController.getMessege(
            widget.appUser.uid!, navController.profile!.uid!);
        return GetBuilder<UsersController>(builder: (controller) {
          return controller.messegelist.isEmpty && controller.isloading == true
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          controller: scrollController,
                          reverse: false,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var messege = controller.messegelist[index];

                            if (messege.senderid ==
                                navController.profile!.uid!) {
                              return mymessege(messege);
                            } else {
                              return (yourmessege(messege));
                            }
                          },
                          itemCount: controller.messegelist.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 15);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextField(
                              controller: textEditingController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Write a messege'),
                            )),
                            InkWell(
                              onTap: () {
                                controller.uploadImage();
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Icon(
                                  Iconsax.camera,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                userController.sendMessege(
                                    navController.profile!.uid!,
                                    senderid: navController.profile!.uid!,
                                    recieverid: widget.appUser.uid!,
                                    date: DateTime.now().toString(),
                                    text: textEditingController.text);
                                textEditingController.clear();
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(15)),
                                child: GetBuilder<UsersController>(
                                    builder: (controller) {
                                  return controller.isloading == true
                                      ? Center(
                                          child: CircularProgressIndicator(
                                              color: Colors.white),
                                        )
                                      : Icon(
                                          Iconsax.send1,
                                          color: Colors.white,
                                          size: 30,
                                        );
                                }),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
        });
      }),
    );
  }

  Align mymessege(Messege messege) {
    double raduis = messege.imgurl == null ? 10 : 20;
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue[300],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(raduis),
                bottomLeft: Radius.circular(raduis),
                topRight: Radius.circular(raduis))),
        padding: EdgeInsets.all(10),
        child: messege.imgurl != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    messege.text,
                    style:
                        Get.textTheme.titleSmall!.copyWith(color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(messege.imgurl!))
                ],
              )
            : Text(
                messege.text,
                style: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
              ),
      ),
    );
  }

  Align yourmessege(Messege messege) {
    double raduis = messege.imgurl == null ? 10 : 20;
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(raduis),
                bottomRight: Radius.circular(raduis),
                topRight: Radius.circular(raduis))),
        padding: EdgeInsets.all(5),
        child: messege.imgurl != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    messege.text,
                    style:
                        Get.textTheme.titleSmall!.copyWith(color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(messege.imgurl!))
                ],
              )
            : Text(
                messege.text,
                style: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
              ),
      ),
    );
  }
}
