import 'package:exam_demo_app/views/splash/first_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../core/helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool _isVisible = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      if (firebaseAuth.currentUser != null) {
        //push(context, FirstScreen());
      } else {
        push(context, const FirstScreen());
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
    if (mounted){
      setState(() {
        _isVisible = true;
      });
    }
  });
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: w,
        height: h,
        alignment: Alignment.center,
        child: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [
                Theme.of(context).accentColor,
                Theme.of(context).primaryColor
              ],
              begin: const FractionalOffset(0, 0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0,
            duration: const Duration(milliseconds: 1200),
            child: Center(
              child: Container(
                height: 140.0,
                width: 140.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 2.0,
                        offset: const Offset(5.0, 3.0),
                        spreadRadius: 2.0,
                      )
                    ]),
                child:  const Center(
                  child: ClipOval(
                    child: Icon(
                      Icons.flutter_dash_outlined,
                      size: 128,
                    ), //put your logo here
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
