import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_demo_app/core/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

abstract class AuthRipository {
  Future<UserModel?> signIn(String email, String password);
  Future<UserModel?> signUp(String fName, lName, String email, String password,
      String type, String? group);
  bool isSignIn();
  Future<bool> isAdmin();
  Future<UserModel?> getUserData();
}

class AuthRepositoryImp implements AuthRipository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  bool isSignIn() {
    if (_auth.currentUser != null) {
      return true;
    }
    return false;
  }

  @override
  Future<UserModel?> signIn(String email, String password) async {
    try {
      UserModel? userModel;
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('User')
          .doc(user!.uid)
          .get();
      if (documentSnapshot.exists) {
        userModel =
            UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
      }

      return userModel;

      return userModel!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  @override
  Future<UserModel?> signUp(String fName, lName, String email, String password,
      String type, String? group) async {
    UserModel? userModel;
    try {
      /*
      json['firstname'] ?? '',
      lName: json['lastname'] ?? '',
      type: json['type'] ?? '',
      email: json['email'] ?? '',
      uId: json['uid'] ?? '',
      */

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      Map<String, dynamic> data = {
        'firstname': fName,
        'lastname': lName,
        'type': type,
        'email': email,
        'uid': user!.uid,
        if (group != null) 'group': group,
      };
      await FirebaseFirestore.instance
          .collection("User")
          .doc(user.uid)
          .set(data); // user data adding
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('User')
          .doc(user.uid)
          .get();
      if (documentSnapshot.exists) {
        userModel =
            UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
      }

      return userModel;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  @override
  Future<bool> isAdmin() {
    // TODO: implement isAdmin
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> getUserData() async {
    try {
      print('user uid ${_auth.currentUser?.uid}');
      var documentSnapshot = await FirebaseFirestore.instance
          .collection('User')
          .doc(_auth.currentUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        print('user uid2 ${_auth.currentUser?.uid}');
        return UserModel.fromJson(
            documentSnapshot.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print('error currentuser ${e.toString()}');
      return null;
    }
    return null;
  }
}
