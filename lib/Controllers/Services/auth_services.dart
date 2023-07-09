import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../Modules/user.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> login(_emailController, _passwordController) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      User? user = FirebaseAuth.instance.currentUser;
      print("Signed in seccsecfully ${user!.displayName}");
      print("Signed in seccsecfully ${user!.email}");
      print("Signed in seccsecfully ${user!.photoURL}");
      // Handle successful login
      return 'ok';
    } catch (e) {
      // Handle login error
      return e.toString();
    }
  }

  Future<String> loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        // Handle successful login

        print("Signed in seccsecfully ${googleSignInAccount!.displayName}");
        print("Signed in seccsecfully ${googleSignInAccount!.email}");
        print("Signed in seccsecfully ${googleSignInAccount!.photoUrl}");
      }
      return 'ok';
    } catch (e) {
      // Handle login error
      return e.toString();
    }
  }

  Future<String> registerUserWithEmailAndPassword(
      String email, String password, String phone, String name) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Registration successful, you can access the newly registered user from userCredential.user
      User? user = userCredential.user;

      if (user != null) {
        // User registration successful, perform any additional tasks
        print('User registration successful. User ID: ${user.uid}');
        var response = await creatuser(AppUser(
            email: email,
            name: name,
            phone: phone,
            uid: user.uid,
            isEmailV: false,
            bio: "Write Your bio",
            image:
                'https://img.freepik.com/vecteurs-libre/homme-affaires-caractere-avatar-isole_24877-60111.jpg?size=626&ext=jpg'));
        return response == 'ok' ? 'ok' : 'Error';
      } else {
        // User registration failed
        print('User registration failed.');
        return 'User registration failed.';
      }
    } catch (e) {
      // Registration failed
      print('Registration error: $e');
      return e.toString();
    }
  }

  Future<String> registerWithGoogle() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        // Handle successful registration

        if (_googleSignIn.isSignedIn() == true) {
          print(
              "Registred in seccsecfully ${googleSignInAccount!.displayName}");
          print("Registred in seccsecfully ${googleSignInAccount!.email}");
          print("Registred in seccsecfully ${googleSignInAccount!.photoUrl}");

          await creatuser(AppUser(
              email: googleSignInAccount!.email,
              bio: 'This is google sign in bio',
              image: googleSignInAccount!.photoUrl,
              isEmailV: false,
              name: googleSignInAccount!.displayName,
              phone: '+210 54823321',
              uid: googleSignInAccount!.id));
        }
        return 'ok';
      } else {
        return 'Unkown Error';
      }
    } catch (e) {
      print('Thee is an ERROR = ' + e.toString());
      return e.toString();
    }
  }

  Future<String> logout() async {
    try {
      await FirebaseAuth.instance.signOut();

      // Log out successful
      print('User logged out successfully.');
      return 'ok';
    } catch (e) {
      // Log out failed
      print('Logout error: $e');
      return e.toString();
    }
  }

  Future<String> creatuser(AppUser? appUser) async {
    String msg = 'ok';
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(appUser!.uid)
          .set(appUser.toMap())
          .then((value) async {
        appUser = await getuserdata(appUser!);
        if (appUser?.isEmailV == true) {
          print("YOUR EMAIL IS VERIFIED");
        } else {
          print("YOUR EMAIL IS NOT VERIFIED");
        }
      }).catchError((e) {
        print('Creat user error : $e');
        msg = e.toString();
      });

      return msg;
    } catch (e) {
      // Log out failed
      print('Logout error: $e');
      return e.toString();
    }
  }

  Future<AppUser?> getuserdata(AppUser appUser) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(appUser.uid)
        .get();

    if (documentSnapshot.exists) {
      // Access individual fields using documentSnapshot['field_name']
      var isEmailV = documentSnapshot['isEmailV'];

      // Do something with the retrieved data
      print('The State of verified email is : $isEmailV');
      return appUser;
    } else {
      print('Document does not exist.');
      return null;
    }
  }
}
