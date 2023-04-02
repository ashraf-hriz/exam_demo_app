

import 'package:flutter/material.dart';

import '../../core/enums.dart';
import '../../core/theme_helper.dart';
import '../widgets/header_widget.dart';

class SignUpScreen extends StatefulWidget {
  final UserType userType;
  const SignUpScreen({super.key,required this.userType});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 250,
              child: HeaderWidget(250, true, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                       
                        const SizedBox(height: 30,),
                        Container(
                          decoration: ThemeHelper.inputBoxDecorationShaddow(),
                          child: TextFormField(
                            decoration: ThemeHelper.textInputDecoration('First Name', 'Enter your first name'),
                          ),
                        ),
                        const SizedBox(height: 30,),
                        Container(
                          decoration: ThemeHelper.inputBoxDecorationShaddow(),
                          child: TextFormField(
                            decoration: ThemeHelper.textInputDecoration('Last Name', 'Enter your last name'),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper.inputBoxDecorationShaddow(),
                          child: TextFormField(
                            decoration: ThemeHelper.textInputDecoration("E-mail address", "Enter your email"),
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if(!(val!.isEmpty) && !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                                return "Enter a valid email address";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper.inputBoxDecorationShaddow(),
                          child: TextFormField(
                            decoration: ThemeHelper.textInputDecoration(
                                "Mobile Number",
                                "Enter your mobile number"),
                            keyboardType: TextInputType.phone,
                            validator: (val) {
                              if(!(val!.isEmpty) && !RegExp(r"^(\d+)*$").hasMatch(val)){
                                return "Enter a valid phone number";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper.inputBoxDecorationShaddow(),
                          child: TextFormField(
                            obscureText: true,
                            decoration: ThemeHelper.textInputDecoration(
                                "Password*", "Enter your password"),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                          ),
                        ),
                        
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper.buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper.buttonStyle(),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Register".toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                               /*  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => ProfilePage()
                                    ),
                                        (Route<dynamic> route) => false
                                ); */
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        
                       
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}