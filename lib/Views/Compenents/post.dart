// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  const Post({
    Key? key,
    required this.name,
    required this.desc,
    required this.photo,
    required this.hashtags,
  }) : super(key: key);
  final String name;
  final String desc;
  final String photo;
  final String hashtags;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
