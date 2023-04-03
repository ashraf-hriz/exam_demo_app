import 'package:exam_demo_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants.dart';
import '../../core/enums.dart';
import '../../core/helper.dart';
import '../../core/theme_helper.dart';
import '../widgets/header_widget.dart';

class SignUpScreen extends StatefulWidget {
  final UserType userType;
  const SignUpScreen({super.key, required this.userType});

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
                  Consumer<AuthProvider>(builder: (context, authProvider, _) {
                    return Form(
                      key: authProvider.signUpFormKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            decoration: ThemeHelper.inputBoxDecorationShaddow(),
                            child: TextFormField(
                              controller: authProvider.fNameController,
                              decoration: ThemeHelper.textInputDecoration(
                                  'First Name', 'Enter your first name'),
                              validator: validateName,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            decoration: ThemeHelper.inputBoxDecorationShaddow(),
                            child: TextFormField(
                              controller: authProvider.lNameController,
                              decoration: ThemeHelper.textInputDecoration(
                                  'Last Name', 'Enter your last name'),
                              validator: validateName,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            decoration: ThemeHelper.inputBoxDecorationShaddow(),
                            child: TextFormField(
                              controller: authProvider.emailController,
                              decoration: ThemeHelper.textInputDecoration(
                                  "Email address", "Enter your email"),
                              keyboardType: TextInputType.emailAddress,
                              validator: validateEmail,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            decoration: ThemeHelper.inputBoxDecorationShaddow(),
                            child: TextFormField(
                                controller: authProvider.passwordController,
                                obscureText: true,
                                decoration: ThemeHelper.textInputDecoration(
                                    "Password", "Enter your password"),
                                validator: validatePassword),
                          ),
                          if (widget.userType == UserType.student)
                            const SizedBox(height: 20.0),
                          if (widget.userType == UserType.student)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                               decoration: ThemeHelper.inputBoxDecorationShaddowBorder(),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  hint: const Text(
                                    'Select Group',
                                    style: TextStyle(
                                      fontSize: 17,
                                      //fontWeight: FontWeight.w600,
                                     
                                    ),
                                  ),
                                  value: authProvider.selectedGroup,
                                  isExpanded: true,
                                  items: groupsList.map((String group) {
                                    return DropdownMenuItem<String>(
                                      value: group,
                                      child: Text(group),
                                    );
                                  }).toList(),
                                  onChanged: (newVal) {
                                    authProvider.changeGroup(newVal!);
                                  },
                                ),
                              ),
                            ),
                          
                          const SizedBox(height: 20.0),
                          Container(
                            decoration:
                                ThemeHelper.buttonBoxDecoration(context),
                            child: ElevatedButton(
                              style: ThemeHelper.buttonStyle(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 10, 40, 10),
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
                                if (widget.userType == UserType.student && authProvider.selectedGroup == null){
                                  print('select group');
                                }
                                else if (authProvider.signUpFormKey.currentState!
                                    .validate()) {
                                  authProvider.signUp(widget.userType.name);
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 30.0),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
