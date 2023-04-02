import 'package:exam_demo_app/core/helper.dart';
import 'package:flutter/material.dart';

import '../../core/enums.dart';
import '../../core/theme_helper.dart';
import '../login/login_screen.dart';
import '../widgets/header_widget.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  double _headerHeight = 250;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        width: w,
        height: h,
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true,
                  Icons.login_rounded), //let's create a common header widget
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Hello',
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Signin into your account',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: w,
                    decoration: ThemeHelper.buttonBoxDecoration(context),
                    child: ElevatedButton(
                      style: ThemeHelper.buttonStyle(),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                        child: Text(
                          'Student'.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        //After successful login we will redirect to profile page. Let's create profile page now
                        push(
                            context,
                            const LoginPage(
                              userType: UserType.student,
                            ));
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: w,
                    decoration: ThemeHelper.buttonBoxDecoration(context),
                    child: ElevatedButton(
                      style: ThemeHelper.buttonStyle(),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                        child: Text(
                          'Admin'.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        //After successful login we will redirect to profile page. Let's create profile page now
                        push(
                            context,
                            const LoginPage(
                              userType: UserType.admin,
                            ));
                      },
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
