

import 'package:exam_demo_app/core/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class  AuthRipository {

  Future<void> signIn(String email,String password);
  Future<void> signUp(String fName,lName,String email,String password);
  bool isSignIn();
  Future<bool> isAdmin();
  
}

class AuthRepositoryImp implements AuthRipository{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  bool isSignIn() {
    if (firebaseAuth.currentUser !=null){
      return true;
    }
    return false;
  }

  @override
  Future<void> signIn(String email, String password) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(String fName, lName, String email, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
  
  @override
  Future<bool> isAdmin() {
    // TODO: implement isAdmin
    throw UnimplementedError();
  }

}