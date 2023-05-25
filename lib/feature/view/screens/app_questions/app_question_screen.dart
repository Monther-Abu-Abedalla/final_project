import 'package:consulting_app/feature/view/screens/app_questions/widget/question_item.dart';
import 'package:consulting_app/feature/view/screens/home/widgets/custom_loading.dart';
import 'package:consulting_app/feature/view_model/home_view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AppQuestionScreen extends StatelessWidget {
  const AppQuestionScreen({Key? key}) : super(key: key);

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الاسئلة الشائعة'),
      ),
      body: Consumer<HomeViewModel>(
        // initState: (_) {
        //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        //     await homeViewModel.getQuestions();
        //   });
        // },
        builder: (_, home, __) {
          if (home.isLoading) {
            return const CustomLoading();
          } else {
            return ListView.builder(
              padding: const EdgeInsets.only(top: 20),
              itemCount: home.commonQuestions.length,
              itemBuilder: (context, index) =>
                  QuestionItem(commonQuestion: home.commonQuestions[index]),
            );
          }
        },
      ),
    );
  }
}
