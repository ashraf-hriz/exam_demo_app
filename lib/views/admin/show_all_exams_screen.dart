import 'package:flutter/material.dart';

import '../../repositories/exam_repository.dart';
import '../widgets/exam_tile.dart';

class AllExamsScreen extends StatefulWidget {
  const AllExamsScreen({super.key});

  @override
  State<AllExamsScreen> createState() => _AllExamsScreenState();
}

class _AllExamsScreenState extends State<AllExamsScreen> {
  late Stream quizStream;

  bool _isLoading = true;

  Widget quizList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
        stream: quizStream,
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
    ExamRepository.getExamData().then((value) {
      setState(() {
        quizStream = value;
        _isLoading = false;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Exams',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: _isLoading
          ? Container(
              child: const Center(child: CircularProgressIndicator()),
            )
          : quizList(),
    );
  }
}
