

import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

import '../../repositories/exam_repository.dart';
import '../widgets/app_button.dart';

class AddQuestionScreen extends StatefulWidget {
  final String examId;
  const AddQuestionScreen({super.key,required this.examId});

  @override
  State<AddQuestionScreen> createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
final _formKey = GlobalKey<FormState>();
  String? question, option1, option2, option3, option4,option5, correctAnswer, questionId;

  bool _isLoading = false;

  

  _uploadQuestionData() async{
    if(_formKey.currentState!.validate()){

      setState(() {
        _isLoading = true;
      });

      questionId = randomAlphaNumeric(16);

      Map<String, String> questionData = {
        "question" : question!,
        "option1" : option1!,
        "option2" : option2!,
        "option3" : option3!,
        "option4" : option4!,
        "option5" : option5!,
        "correctAnswer" : correctAnswer!,
        "questionId" : questionId!
      };

      await ExamRepository.addQuestionData(questionData, widget.examId, questionId!).then((value) => {
        setState(() {
          _isLoading = false;
        })
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Add Questions',
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
        iconTheme: const IconThemeData(color: Colors.black87),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: _isLoading ? Container(
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ) : Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    hintText: "Question"
                ),
                onChanged: (val){
                  question = val;
                },
                validator: (val){
                  return val!.isEmpty ? "Enter question" : null;
                },
              ),
              const SizedBox(height: 6,),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: "Option one"
                ),
                onChanged: (val){
                  option1 = val;
                },
                validator: (val){
                  return val!.isEmpty ? "Enter option one" : null;
                },
              ),
              const SizedBox(height: 6,),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: "Option two"
                ),
                onChanged: (val){
                  option2 = val;
                },
                validator: (val){
                  return val!.isEmpty ? "Enter option two" : null;
                },
              ),
              const SizedBox(height: 6,),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: "Option three"
                ),
                onChanged: (val){
                  option3 = val;
                },
                validator: (val){
                  return val!.isEmpty ? "Enter option three" : null;
                },
              ),
              const SizedBox(height: 6,),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: "Option four"
                ),
                onChanged: (val){
                  option4 = val;
                },
                validator: (val){
                  return val!.isEmpty ? "Enter option four" : null;
                },
              ),
              const SizedBox(height: 6,),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: "Option five"
                ),
                onChanged: (val){
                  option5 = val;
                },
                validator: (val){
                  return val!.isEmpty ? "Enter option five" : null;
                },
              ),
              const SizedBox(height: 6,),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: "Correct answer"
                ),
                onChanged: (val){
                  correctAnswer = val;
                },
                validator: (val){
                  return val!.isEmpty ? "Enter correct answer" : null;
                },
              ),
              const Spacer(),

              Row(
                children: [
                  GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: appButton(context, "Submit", MediaQuery.of(context).size.width/2 - 36, Colors.deepOrangeAccent)
                  ),
                  const SizedBox(width: 24,),
                  GestureDetector(
                      onTap: (){
                        _uploadQuestionData();
                      },
                      child: appButton(context, "Add Question", MediaQuery.of(context).size.width/2 - 36, Colors.blueAccent)
                  ),
                ]
              ),
              const SizedBox(height: 40.0)
            ],
          ),
        ),
      ),
    );
  } 
}