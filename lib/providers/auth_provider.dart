import 'package:exam_demo_app/repositories/auth_repository.dart';
import 'package:exam_demo_app/views/splash/first_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants.dart';
import '../core/enums.dart';
import '../core/helper.dart';
import '../models/user_model.dart';
import '../views/admin/admin_home_screen.dart';
import '../views/student/student_home_screen.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();

  final loginFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();
  String? selectedGroup;

  final AuthRipository authRepository;
  AuthProvider({required this.authRepository});
  UserModel? userModel;
  bool _loading = true;

  bool get loading => _loading;

  set loading(bool val) {
    _loading = val;
    notifyListeners();
  }

  signIn() async {
    loading = true;
    var res = await authRepository.signIn(
        emailController.text, passwordController.text);
    if (res != null) {
      userModel = res;

       currentUser.type!.toLowerCase() == 'admin'
            ? pushAndRemoveUntil(navigatorKey.currentState!.context, const AdminHomeScreen(),false)
            : pushAndRemoveUntil(
                navigatorKey.currentState!.context, const StudentHomeScreen(),false);
    }
    loading = false;
  }

  signUp(String type) async {
    loading = true;
    var res = await authRepository.signUp(
        fNameController.text,
        lNameController.text,
        emailController.text,
        passwordController.text,
        type,
        selectedGroup);
    if (res != null) {
      userModel = res;
      currentUser.type!.toLowerCase() == 'admin'
            ? pushAndRemoveUntil(navigatorKey.currentState!.context, const AdminHomeScreen(),false)
            : pushAndRemoveUntil(
                navigatorKey.currentState!.context, const StudentHomeScreen(),false);
    }
    loading = false;
  }


  getUserData() async {
    userModel = await authRepository.getUserData();
    print('user id ${userModel!.uId}');
  }

  bool isSignIn() {
    return authRepository.isSignIn();
  }

  changeGroup(String value) {
    selectedGroup = value;
    notifyListeners();
  }

  logOut()async{
     await FirebaseAuth.instance.signOut();
     pushAndRemoveUntil(
                navigatorKey.currentState!.context, const FirstScreen(),false);
  }
}

UserModel get currentUser =>
    Provider.of<AuthProvider>(navigatorKey.currentState!.context, listen: false)
        .userModel!;
