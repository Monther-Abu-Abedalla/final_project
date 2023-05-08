import 'package:consulting_app/feature/view/screens/app_questions/widget/question_item.dart';
import 'package:flutter/material.dart';

class AppQuestionScreen extends StatelessWidget {
  const AppQuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الاسئلة الشائعة'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 20),
        itemCount: 3,
        itemBuilder: (context, index) => const QuestionItem(),
      ),
    );
  }
}
