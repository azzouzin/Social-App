// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Post {
  Post({
    required this.date,
    required this.uid,
    required this.name,
    required this.text,
    required this.photo,
    required this.tags,
    required this.postImage,
  });

  final String name;
  final String text;
  final String photo;
  final String tags;
  final String date;
  final String uid;
  String? postImage;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'text': text,
      'photo': photo,
      'tags': tags,
      'date': date,
      'postImage': postImage,
      'uid': uid,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      name: map['name'] as String,
      text: map['text'] as String,
      photo: map['photo'] as String,
      tags: map['tags'] as String,
      date: map['date'] as String,
      uid: map['uid'] as String,
      postImage: map['postImage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);
}
