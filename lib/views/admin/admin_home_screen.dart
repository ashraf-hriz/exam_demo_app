import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme_helper.dart';
import '../../providers/auth_provider.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
     var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          '${currentUser.fName} ${currentUser.lName}',
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: (){
            Provider.of<AuthProvider>(context,listen: false).logOut();
          }, icon: const Icon(Icons.logout_outlined,color: Colors.white,)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                      width: w,
                      decoration: ThemeHelper.buttonBoxDecoration(context),
                      child: ElevatedButton(
                        style: ThemeHelper.buttonStyle(),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                          child: Text(
                            'Show Exams',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        onPressed: () {
                          //After successful login we will redirect to profile page. Let's create profile page now
                          /* push(
                              context,
                              const LoginPage(
                                userType: UserType.student,
                              )); */
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
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                          child: Text(
                            'Create Exam',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        onPressed: () {
                          //After successful login we will redirect to profile page. Let's create profile page now
                          /* push(
                              context,
                              const LoginPage(
                                userType: UserType.admin,
                              )); */
                        },
                      ),
                    ),
                  
          ],
        ),
      ),
    );
  }
}