import 'package:exam_demo_app/core/helper.dart';
import 'package:exam_demo_app/views/admin/add_quistions_screen.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

import '../../core/constants.dart';
import '../../core/theme_helper.dart';
import '../../repositories/exam_repository.dart';

class CreateExamScreen extends StatefulWidget {
  const CreateExamScreen({super.key});

  @override
  State<CreateExamScreen> createState() => _CreateExamScreenState();
}

class _CreateExamScreenState extends State<CreateExamScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedGroup;
  late String examImageUrl, examTitle, examDescription, examId;

  bool _isLoading = false;

  _createExam() async {
    if (_formKey.currentState!.validate() && selectedGroup != null) {
      setState(() {
        _isLoading = true;
      });

      examId = randomAlphaNumeric(16);
      Map<String, String> examData = {
        "examId": examId,
        "examTitle": examTitle,
        "examGroup": selectedGroup!,
      };

      await ExamRepository.addExamData(examData, examId).then((value) => {
            setState(() {
              _isLoading = false;

              pushReplacement(
                  context,
                  AddQuestionScreen(
                    examId: examId,
                  ));
            })
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Create Exam',
          style: TextStyle(color: Colors.white),
        ),
        /* actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => examList()));
              },
              icon: Icon(Icons.list_alt_sharp, color: Colors.black87,)
          )
        ], */
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Theme.of(context).primaryColor,
        //elevation: 0.0,
      ),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                width: w,
                height: h,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(hintText: "Exam Title"),
                      onChanged: (val) {
                        examTitle = val;
                      },
                      validator: (val) {
                        return val!.isEmpty ? "Enter Exam title" : null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
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
                          value: selectedGroup,
                          isExpanded: true,
                          items: groupsList.map((String group) {
                            return DropdownMenuItem<String>(
                              value: group,
                              child: Text(group),
                            );
                          }).toList(),
                          onChanged: (newVal) {
                            setState(() {
                              selectedGroup = newVal;
                            });
                          },
                        ),
                      ),
                    ),
                    Spacer(),
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
                          _createExam();
                        },
                      ),
                    ),
                    SizedBox(height: 40.0)
                  ],
                ),
              ),
            ),
    );
  }
}
