

import 'package:exam_demo_app/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier{
  final AuthRipository authRepository;
  AuthProvider({required this.authRepository});

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool val){
    _loading = val;
    notifyListeners();
  }

  signIn(){
    loading = true;
    
    loading = false;
  }

  signUp(){

  }

  getUserData(){

  }

  bool isSignIn(){
    return authRepository.isSignIn();
  }
}