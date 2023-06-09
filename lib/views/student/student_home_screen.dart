import 'package:exam_demo_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../repositories/exam_repository.dart';
import '../widgets/exam_tile.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {

  late Stream examStream;

  bool _isLoading = true;

  Widget quizList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
        stream: examStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Something went wrong",
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text(
                "Loading...",
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return ExamTile(
                      title: snapshot.data.docs[index].data()["examTitle"],
                      examId: snapshot.data.docs[index].data()["examId"], 
                      group: snapshot.data.docs[index].data()["examGroup"], 
                      );
                });
          }
          return Container(
            child: const Center(
                child: Text(
              "No Exams Available",
              style: TextStyle(fontSize: 18, color: Colors.red),
            )),
          );
        },
      ),
    );
  }

  @override
  void initState() {
     // TODO: implement initState
    super.initState();
    ExamRepository.getExamDataForStudent().then((value) {
      setState(() {
        examStream = value;
        _isLoading = false;
      });
    });
   
  }
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
      body:   _isLoading
          ? Container(
              child: const Center(child: CircularProgressIndicator()),
            )
          : quizList(),
    );
  }
}
