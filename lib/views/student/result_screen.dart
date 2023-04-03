import 'package:exam_demo_app/core/helper.dart';
import 'package:exam_demo_app/views/student/student_home_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/app_button.dart';

class ResultsScreen extends StatefulWidget {

  final int correct, incorrect, total;
  ResultsScreen({required this.correct, required this.incorrect, required this.total});

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Correct Answer / Total : ${widget.correct}/${widget.total}", style: const TextStyle(fontSize: 25),),
                const SizedBox(height: 8,),
                Text("You answered correctly : ${widget.correct}", style: const TextStyle(fontSize: 16, color: Colors.green), textAlign: TextAlign.center,),
                const SizedBox(height: 8,),
                Text("Your incorrect answer : ${widget.incorrect}", style: const TextStyle(fontSize: 16, color: Colors.red), textAlign: TextAlign.center,),

                const SizedBox(height: 20,),
                GestureDetector(
                    onTap: (){
                      pushAndRemoveUntil(context, const StudentHomeScreen(), false);
                    },
                    child: appButton(context, "Go To Home", MediaQuery.of(context).size.width/2, Colors.blueAccent)
                ),
              ],
            ),
          ),
        ),
    );
  }
}
