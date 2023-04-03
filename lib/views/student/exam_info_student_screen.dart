import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_demo_app/core/helper.dart';
import 'package:exam_demo_app/providers/auth_provider.dart';
import 'package:exam_demo_app/views/student/result_screen.dart';
import 'package:flutter/material.dart';

import '../../core/theme_helper.dart';
import '../../models/question_model.dart';
import '../../repositories/exam_repository.dart';
import '../widgets/play_exam_widget.dart';

int total = 0;
int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;

Stream? infoStream;

class ExamInfoForStudentScreen extends StatefulWidget {
  final examId, examTilte;
  const ExamInfoForStudentScreen(
      {super.key, required this.examId, required this.examTilte});

  @override
  State<ExamInfoForStudentScreen> createState() =>
      _ExamInfoForStudentScreenState();
}

class _ExamInfoForStudentScreenState extends State<ExamInfoForStudentScreen> {
  late QuerySnapshot querySnapshot;

  bool _isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ExamRepository.getQuestionData(widget.examId).then((value) {
      querySnapshot = value;
      _notAttempted = 0;
      _correct = 0;
      _incorrect = 0;
      total = querySnapshot.docs.length;
      _isLoading = false;
      setState(() {});
    });

    infoStream ??=
        Stream<List<int>>.periodic(const Duration(milliseconds: 100), (x) {
      return [_correct, _incorrect];
    });
  }

  _submitResutls() {
    Map<String, dynamic> userData = {
      'uid': currentUser.uId,
      'fName': currentUser.fName,
      'lName': currentUser.lName,
      'score': _correct,
      'total': total,
    };
    ExamRepository.submitExamForStudent(userData, widget.examId).then((value) {
      pushReplacement(
        context,
        ResultsScreen(correct: _correct, incorrect: _incorrect, total: total),
      );
    });
  }

  @override
  void dispose() {
    infoStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.examTilte.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: _isLoading
          ? Container(
              child: const Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  if (querySnapshot.docs != null)
                    InfoHeader(
                      length: querySnapshot.docs.length,
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  querySnapshot.docs == null
                      ? Container(
                          child: const Center(
                            child: Text("No Question Available",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red)),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: querySnapshot.docs.length,
                          itemBuilder: (context, index) {
                            return QuizPlayTile(
                              questionModel:
                                  ExamRepository.getQuestionModelFromSnapshot(
                                      querySnapshot.docs[index]),
                              index: index,
                            );
                          },
                        ),
                  Container(
                    width: double.infinity,
                    margin:
                        const EdgeInsets.only(bottom: 15, left: 15, right: 15),
                    decoration: ThemeHelper.buttonBoxDecoration(context),
                    child: ElevatedButton(
                      style: ThemeHelper.buttonStyle(),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        _submitResutls();
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class InfoHeader extends StatefulWidget {
  final int length;

  InfoHeader({required this.length});

  @override
  _InfoHeaderState createState() => _InfoHeaderState();
}

class _InfoHeaderState extends State<InfoHeader> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: infoStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Container(
                  height: 40,
                  margin: const EdgeInsets.only(left: 14),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: <Widget>[
                      NumberOfQuestionTile(
                        text: "Total",
                        number: widget.length,
                      ),
                      NumberOfQuestionTile(
                        text: "Correct",
                        number: _correct,
                      ),
                      NumberOfQuestionTile(
                        text: "Incorrect",
                        number: _incorrect,
                      ),
                    ],
                  ),
                )
              : Container();
        });
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  QuizPlayTile({required this.questionModel, required this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Q${widget.index + 1} ${widget.questionModel.question}",
              style: const TextStyle(fontSize: 18, color: Colors.black87),
            ),
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                if (!widget.questionModel.answered) {
                  if (widget.questionModel.option1 ==
                      widget.questionModel.correctOption) {
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted - 1;
                    setState(() {});
                  } else {
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                    setState(() {});
                  }
                }
              },
              child: OptionTile(
                  option: "A",
                  description: widget.questionModel.option1,
                  correctAnswer: widget.questionModel.correctAnswer,
                  optionSelected: optionSelected),
            ),
            const SizedBox(
              height: 4,
            ),
            GestureDetector(
              onTap: () {
                if (!widget.questionModel.answered) {
                  if (widget.questionModel.option2 ==
                      widget.questionModel.correctOption) {
                    optionSelected = widget.questionModel.option2;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted - 1;
                    setState(() {});
                  } else {
                    optionSelected = widget.questionModel.option2;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                    setState(() {});
                  }
                }
              },
              child: OptionTile(
                  option: "B",
                  description: widget.questionModel.option2,
                  correctAnswer: widget.questionModel.correctAnswer,
                  optionSelected: optionSelected),
            ),
            const SizedBox(
              height: 4,
            ),
            GestureDetector(
              onTap: () {
                if (!widget.questionModel.answered) {
                  if (widget.questionModel.option3 ==
                      widget.questionModel.correctOption) {
                    optionSelected = widget.questionModel.option3;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted - 1;
                    setState(() {});
                  } else {
                    optionSelected = widget.questionModel.option3;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                    setState(() {});
                  }
                }
              },
              child: OptionTile(
                  option: "C",
                  description: widget.questionModel.option3,
                  correctAnswer: widget.questionModel.correctAnswer,
                  optionSelected: optionSelected),
            ),
            const SizedBox(
              height: 4,
            ),
            GestureDetector(
              onTap: () {
                if (!widget.questionModel.answered) {
                  if (widget.questionModel.option4 ==
                      widget.questionModel.correctOption) {
                    optionSelected = widget.questionModel.option4;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted - 1;
                    setState(() {});
                  } else {
                    optionSelected = widget.questionModel.option4;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                    setState(() {});
                  }
                }
              },
              child: OptionTile(
                  option: "D",
                  description: widget.questionModel.option4,
                  correctAnswer: widget.questionModel.correctAnswer,
                  optionSelected: optionSelected),
            ),
            const SizedBox(
              height: 4,
            ),
            GestureDetector(
              onTap: () {
                if (!widget.questionModel.answered) {
                  if (widget.questionModel.option4 ==
                      widget.questionModel.correctOption) {
                    optionSelected = widget.questionModel.option5;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted - 1;
                    setState(() {});
                  } else {
                    optionSelected = widget.questionModel.option5;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                    setState(() {});
                  }
                }
              },
              child: OptionTile(
                  option: "E",
                  description: widget.questionModel.option5,
                  correctAnswer: widget.questionModel.correctAnswer,
                  optionSelected: optionSelected),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
