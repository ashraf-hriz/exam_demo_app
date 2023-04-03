import 'package:exam_demo_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          '${currentUser.fName} ${currentUser.lName}',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: (){
            Provider.of<AuthProvider>(context,listen: false).logOut();
          }, icon: const Icon(Icons.logout_outlined,color: Colors.white,)),
        ],
      ),
      body: Center(child: Text('Student')),
    );
  }
}
