import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Controllers/Services/user_services.dart';
import 'package:firebase/Modules/post.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../Modules/user.dart';

class PostsServices {
  File? selectedImage;
  final storage = FirebaseStorage.instance;
  String? imageUrl;

  Future<String?> uploadImage({
    required String text,
    required String date,
    required String tags,
  }) async {
    String? msg;
    await storage
        .ref()
        .child('posts/${Uri.file(selectedImage!.path).pathSegments.last}')
        .putFile(selectedImage!)
        .then((p0) {
      print(p0);
      p0.ref.getDownloadURL().then((value) async {
        print("This is the value returned From Firebase Storage $value");
        msg = value;
        AppUser? user = await UserServices().getTheUser();
        var post = Post(
          date: date,
          name: user?.name ?? 'NULL',
          text: text,
          photo: user?.image ?? 'NULL',
          tags: tags,
          postImage: value,
          uid: user?.uid ?? 'NULL',
        );
        await creatpost(post);
      });
    }).onError((error, stackTrace) {
      print(error);
      msg = error.toString();
    });
    return msg;
  }

  Future<String?> creatpost(Post post) async {
    String msg = 'ok';

    try {
      FirebaseFirestore.instance
          .collection('posts')
          .add(post.toMap())
          .then((value) async {
        print("Post Created ");
        return "Post Created ";
      }).catchError((e) {
        print('Creat post error : $e');
        msg = e.toString();
        return msg;
      });

      return msg;
    } catch (e) {
      // Log out failed
      print('Post creat error: $e');
      return e.toString();
    }
  }

  Future<File?> pickImage() async {
    try {
      final ImagePicker _imagePicker = ImagePicker();
      final XFile? image =
          await _imagePicker.pickImage(source: ImageSource.camera);

      if (image != null) {
        print("THIS IS IMAGE Path${image.path}");
        selectedImage = File(image.path);
        print(selectedImage!.path);
      } else {
        print('You didnt pick any image');
      }
    } on Exception catch (e) {
      print(e);
    }
    return selectedImage;
  }
}
