import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_demo_app/providers/auth_provider.dart';

import '../models/question_model.dart';

class ExamRepository {
  ExamRepository._();
  static Future<void> addExamData(
      Map<String, dynamic> examData, String examId) async {
    await FirebaseFirestore.instance
        .collection("Exam")
        .doc(examId)
        .set(examData)
        .catchError((e) {
      print(e.toString());
    });
  }

  static Future<void> addQuestionData(Map<String, dynamic> questionData,
      String examId, String questionId) async {
    await FirebaseFirestore.instance
        .collection("Exam")
        .doc(examId)
        .collection("QNA")
        .doc(questionId)
        .set(questionData)
        .catchError((e) {
      print(e.toString());
    });
  }

  static getExamData() async {
    return await FirebaseFirestore.instance.collection("Exam").snapshots();
  }

  static getExamDataForStudent() async {
    return await FirebaseFirestore.instance
        .collection("Exam")
        .where('examGroup', isEqualTo: currentUser.group)
        .snapshots();
  }

  static getQuestionData(String examId) async {
    return await FirebaseFirestore.instance
        .collection("Exam")
        .doc(examId)
        .collection("QNA")
        .get();
  }

  static QuestionModel getQuestionModelFromSnapshot(
      DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = QuestionModel();
    questionModel.question = questionSnapshot["question"];

    List<String> options = [
      questionSnapshot["option1"],
      questionSnapshot["option2"],
      questionSnapshot["option3"],
      questionSnapshot["option4"],
      questionSnapshot["option5"],
    ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.option5 = options[4];

    questionModel.correctOption = questionSnapshot["correctAnswer"];
    questionModel.correctAnswer = questionSnapshot["correctAnswer"];
    questionModel.answered = false;

    return questionModel;
  }

  static Future<void> submitExamForStudent(Map<String, dynamic> studentData,
      String examId) async {
    await FirebaseFirestore.instance
        .collection("Exam")
        .doc(examId)
        .collection("participants")
        .doc(currentUser.uId)
        .set(studentData)
        .catchError((e) {
      print(e.toString());
    });
  }

  static getPaticipantsData(String examId) async {
    return await FirebaseFirestore.instance
        .collection("Exam")
        .doc(examId)
        .collection("participants")
        .get();
  }
}
