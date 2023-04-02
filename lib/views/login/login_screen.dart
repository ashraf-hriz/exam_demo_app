import 'package:exam_demo_app/core/theme_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../core/enums.dart';
import '../../core/helper.dart';
import '../forgot_password_screen.dart';
import '../signup/signUp_screen.dart';
import '../widgets/header_widget.dart';

class LoginPage extends StatefulWidget {
  final UserType userType;
  const LoginPage({
    Key? key,
    required this.userType,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true,
                  Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: const EdgeInsets.fromLTRB(
                      20, 10, 20, 10), 
                  child: Column(
                    children: [
                      
                      const Text(
                        'Signin into your account',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 30.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                decoration:
                                    ThemeHelper.inputBoxDecorationShaddow(),
                                child: TextFormField(
                                  decoration: ThemeHelper.textInputDecoration(
                                      'Email', 'Enter your email'),
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              Container(
                                decoration:
                                    ThemeHelper.inputBoxDecorationShaddow(),
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: ThemeHelper.textInputDecoration(
                                      'Password', 'Enter your password'),
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    //Navigator.push( context, MaterialPageRoute( builder: (context) => ForgotPasswordPage()), );
                                  push(context,ForgotPasswordPage(userType: widget.userType,));
                                  },
                                  child: const Text(
                                    "Forgot your password?",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration:
                                    ThemeHelper.buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper.buttonStyle(),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text(
                                      'Sign In'.toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () {
                                    //After successful login we will redirect to profile page. Let's create profile page now
                                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                //child: Text('Don\'t have an account? Create'),
                                child: Text.rich(TextSpan(children: [
                                  const TextSpan(text: "Don\'t have an account? "),
                                  TextSpan(
                                    text: 'Create',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                       push(context,SignUpScreen(userType: widget.userType,));
                                      },
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).accentColor),
                                  ),
                                ])),
                              ),
                            ],
                          )),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
