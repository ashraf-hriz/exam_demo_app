import 'package:exam_demo_app/core/helper.dart';
import 'package:exam_demo_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';

import '../../core/constants.dart';
import '../admin/exam_info_screen.dart';
import '../student/exam_info_student_screen.dart';

class ExamTile extends StatelessWidget {
  //final String imageUrl = '';
  final String title;
  final String group;

  final String examId;

  ExamTile({required this.title, required this.examId, required this.group});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /* Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          //return PlayQuiz(quizId);
        })); */
        currentUser.type == 'admin'
            ? push(
                context,
                ExamInfoScreen(
                  examId: examId,
                  examTilte: title,
                ))
            : push(
                context,
                ExamInfoForStudentScreen(
                  examId: examId,
                  examTilte: title,
                ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        height: 150,
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  examImageUrl,
                  width: MediaQuery.of(context).size.width - 48,
                  fit: BoxFit.cover,
                )),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black26),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(group,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
