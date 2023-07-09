import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppUser {
  String? name;
  String email;
  String? phone;
  String? image;
  String? uid;
  String? bio;
  bool? isEmailV = false;
  AppUser({
    this.name,
    required this.email,
    this.phone,
    this.uid,
    required this.bio,
    required this.image,
    this.isEmailV,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'uid': uid,
      'isEmailV': isEmailV,
      'image': image,
      'bio': bio,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] as String,
      phone: map['phone'] != null ? map['phone'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      bio: map['bio'] != null ? map['bio'] as String : null,
      isEmailV: map['isEmailV'] != null ? map['isEmailV'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
