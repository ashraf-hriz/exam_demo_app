import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_demo_app/core/helper.dart';
import 'package:exam_demo_app/views/admin/all_student_solve_exame.dart';
import 'package:flutter/material.dart';

import '../../core/theme_helper.dart';
import '../../models/question_model.dart';
import '../../repositories/exam_repository.dart';
import '../widgets/play_exam_widget.dart';

class ExamInfoScreen extends StatefulWidget {
  final examId, examTilte;
  const ExamInfoScreen(
      {super.key, required this.examId, required this.examTilte});

  @override
  State<ExamInfoScreen> createState() => _ExamInfoScreenState();
}

class _ExamInfoScreenState extends State<ExamInfoScreen> {
  late QuerySnapshot querySnapshot;

  bool _isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ExamRepository.getQuestionData(widget.examId).then((value) {
      querySnapshot = value;
      /* _notAttempted = 0;
      _correct = 0;
      _incorrect = 0;
      total = querySnapshot.docs.length; */
      _isLoading = false;
      setState(() {});
    });
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
                      margin: const EdgeInsets.only(bottom: 15,left: 15,right: 15),
                      decoration: ThemeHelper.buttonBoxDecoration(context),
                      child: ElevatedButton(
                        style: ThemeHelper.buttonStyle(),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                          child: Text(
                            'students',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        onPressed: () {
                          push(context, StudentSolvedExamScreen(examId: widget.examId,examTitle: widget.examTilte,));
                        },
                      ),
                    ),
                ],
              ),
            ),
    );
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
    optionSelected = optionSelected = widget.questionModel.correctAnswer;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Q${widget.index + 1} ${widget.questionModel.question}",
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
            SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                /*  if(!widget.questionModel.answered){
                  if(widget.questionModel.option1 == widget.questionModel.correctOption){
      
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    // _correct = _correct + 1;
                    // _notAttempted = _notAttempted - 1;
                    setState(() {
      
                    });
      
                  }else{
      
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    // _incorrect = _incorrect + 1;
                    // _notAttempted = _notAttempted - 1;
                    setState(() {
      
                    });
      
                  }
                } */
              },
              child: OptionTile(
                  option: "A",
                  description: widget.questionModel.option1,
                  correctAnswer: widget.questionModel.correctAnswer,
                  optionSelected: optionSelected),
            ),
            SizedBox(
              height: 4,
            ),
            GestureDetector(
              onTap: () {
                /* if(!widget.questionModel.answered){
                  if(widget.questionModel.option2 == widget.questionModel.correctOption){
      
                    optionSelected = widget.questionModel.option2;
                    widget.questionModel.answered = true;
                    // _correct = _correct + 1;
                    // _notAttempted = _notAttempted - 1;
                    setState(() {
      
                    });
      
                  }else{
      
                    optionSelected = widget.questionModel.option2;
                    widget.questionModel.answered = true;
                    // _incorrect = _incorrect + 1;
                    // _notAttempted = _notAttempted - 1;
                    setState(() {
      
                    });
      
                  }
                } */
              },
              child: OptionTile(
                  option: "B",
                  description: widget.questionModel.option2,
                  correctAnswer: widget.questionModel.correctAnswer,
                  optionSelected: optionSelected),
            ),
            SizedBox(
              height: 4,
            ),
            GestureDetector(
              onTap: () {
                /* if(!widget.questionModel.answered){
                  if(widget.questionModel.option3 == widget.questionModel.correctOption){
      
                    optionSelected = widget.questionModel.option3;
                    widget.questionModel.answered = true;
                    //_correct = _correct + 1;
                    //_notAttempted = _notAttempted - 1;
                    setState(() {
      
                    });
      
                  }else{
      
                    optionSelected = widget.questionModel.option3;
                    widget.questionModel.answered = true;
                    //_incorrect = _incorrect + 1;
                    //_notAttempted = _notAttempted - 1;
                    setState(() {
      
                    });
      
                  }
                } */
              },
              child: OptionTile(
                  option: "C",
                  description: widget.questionModel.option3,
                  correctAnswer: widget.questionModel.correctAnswer,
                  optionSelected: optionSelected),
            ),
            SizedBox(
              height: 4,
            ),
            GestureDetector(
              onTap: () {
                /* if(!widget.questionModel.answered){
                  if(widget.questionModel.option4 == widget.questionModel.correctOption){
      
                    optionSelected = widget.questionModel.option4;
                    widget.questionModel.answered = true;
                    //_correct = _correct + 1;
                    //_notAttempted = _notAttempted - 1;
                    setState(() {
      
                    });
      
                  }else{
      
                    optionSelected = widget.questionModel.option4;
                    widget.questionModel.answered = true;
                    //_incorrect = _incorrect + 1;
                    //_notAttempted = _notAttempted - 1;
                    setState(() {
      
                    });
      
                  }
                }*/
              },
              child: OptionTile(
                  option: "D",
                  description: widget.questionModel.option4,
                  correctAnswer: widget.questionModel.correctAnswer,
                  optionSelected: optionSelected),
            ),
            SizedBox(
              height: 4,
            ),
            GestureDetector(
              onTap: () {
                /* if(!widget.questionModel.answered){
                  if(widget.questionModel.option4 == widget.questionModel.correctOption){
      
                    optionSelected = widget.questionModel.option5;
                    widget.questionModel.answered = true;
                    //_correct = _correct + 1;
                    //_notAttempted = _notAttempted - 1;
                    setState(() {
      
                    });
      
                  }else{
      
                    optionSelected = widget.questionModel.option5;
                    widget.questionModel.answered = true;
                    //_incorrect = _incorrect + 1;
                    //_notAttempted = _notAttempted - 1;
                    setState(() {
      
                    });
      
                  }
                } */
              },
              child: OptionTile(
                  option: "E",
                  description: widget.questionModel.option5,
                  correctAnswer: widget.questionModel.correctAnswer,
                  optionSelected: optionSelected),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
