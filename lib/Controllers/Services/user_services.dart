import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Modules/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserServices {
  AppUser theUser = AppUser(
      email: "azzouzmerw@gmail.com",
      bio: 'Bio',
      image:
          "https://img.freepik.com/vecteurs-libre/homme-affaires-caractere-avatar-isole_24877-60111.jpg?size=626&ext=jpg");

  Future<AppUser?> getTheUser() async {
    {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;

      if (user != null) {
        // User is signed in
        String uid = user.uid;
        print('User is signed in. UID: $uid');

        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc('${user.uid}')
            .get();
        if (documentSnapshot.exists) {
          print(
              "THE USEEEEEEEEEEEEEEEEEEEEEEEEEEER ID ${documentSnapshot.data()}}");
          var json = jsonEncode(documentSnapshot.data());
          theUser = AppUser.fromJson(json);

          // Do something with the retrieved data
          print(theUser.bio);
          print(theUser.email);
          print(theUser.name);
          print(theUser.phone);
          print(theUser.uid);
          return theUser;
        } else {
          print('Error Fetching your Data but you are signd in');
          return null;
        }
      } else {
        // User is not signed in
        print('User is not signed in');
        return null;
      }

      // ...
    }
  }
}
