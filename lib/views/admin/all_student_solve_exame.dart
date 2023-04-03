import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../repositories/exam_repository.dart';

class StudentSolvedExamScreen extends StatefulWidget {
  final examId;
  final examTitle;
  const StudentSolvedExamScreen(
      {super.key, required this.examId, required this.examTitle});

  @override
  State<StudentSolvedExamScreen> createState() =>
      _StudentSolvedExamScreenState();
}

class _StudentSolvedExamScreenState extends State<StudentSolvedExamScreen> {
  late QuerySnapshot querySnapshot;

  bool _isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ExamRepository.getPaticipantsData(widget.examId).then((value) {
      querySnapshot = value;

      _isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.examTitle,
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: _isLoading
          ? Container(
              child: const Center(child: CircularProgressIndicator()),
            )
          : querySnapshot.docs == null
              ? Container(
                  child: const Center(
                    child: Text("No Question Available",
                        style: TextStyle(fontSize: 18, color: Colors.red)),
                  ),
                )
              : ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: querySnapshot.docs.length,
                  itemBuilder: (context, index) {
                    String name = querySnapshot.docs[index]['fName'] +
                        ' ' +
                        querySnapshot.docs[index]['lName'];
                    String score =
                        '${querySnapshot.docs[index]['score']} / ${querySnapshot.docs[index]['total']}';
                    return ListTile(
                      tileColor:
                          Theme.of(context).primaryColor.withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                          side: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      title: Text(
                        name,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        score,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.green),
                      ),
                    );
                  },
                ),
    );
  }
}
