// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase/Modules/post.dart';
import 'package:firebase/Views/Compenents/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class Postitem extends StatelessWidget {
  const Postitem(this.post, {super.key});
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 5, color: Colors.black.withOpacity(0.5))
          ]),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Profile picture
              ClipOval(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.network(
                    post.photo,
                    scale: 10,
                    fit: BoxFit.cover,
                  ),
                ),
              )
              //username + date
              ,
              SizedBox(
                width: 20,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment
                    .start, // Align elements to start from the same point on the right
                children: [
                  Text(
                    post.name,
                    style: Get.textTheme.titleSmall,
                  ),
                  Text(
                    post.date,
                    style: Get.textTheme.bodySmall,
                  ),
                ],
              ),

              Column(
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset(
                      'assets/ver.png',
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              //three dots
              Icon(Iconsax.more)
            ],
          ),
          Divider(
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              post.text,
              style: Get.textTheme.titleSmall!.copyWith(fontSize: 13),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              post.tags,
              style: Get.textTheme.titleSmall!
                  .copyWith(fontSize: 13, color: Colors.blue),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: post.postImage == null
                ? Container()
                : Image.network(
                    post.postImage!,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
          ),
          SizedBox(
            height: 5,
          ),
          //LIKES AND COMMENTS
          Row(
            children: [
              Icon(
                Iconsax.lovely,
                color: Colors.red,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '1200',
                style: TextStyle(color: Colors.grey),
              ),
              Expanded(child: Container()),
              Icon(
                Iconsax.messages_25,
                color: Colors.red,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '1200 Comments',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            thickness: 1,
          ),
          //PUT IN COMMENT
          Row(
            children: [
              //Profile picture
              ClipOval(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.network(
                    post.photo,
                    scale: 10,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: TextField(
                  style: Get.textTheme.bodySmall,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Write a comment ...'),
                ),
              ),
              Icon(
                Iconsax.lovely1,
                color: Colors.red,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Like',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
