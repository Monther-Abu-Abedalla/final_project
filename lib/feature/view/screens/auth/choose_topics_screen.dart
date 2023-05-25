import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/core/theme/text_theme/text_manger.dart';
import 'package:consulting_app/feature/view/widget/circle_loading.dart';
import 'package:consulting_app/feature/view/widget/secondery_button.dart';
import 'package:consulting_app/feature/view/widget/secondery_un_selected_button.dart';
import 'package:consulting_app/feature/view_model/auth_view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ChooseTopicsScreen extends StatelessWidget {
  const ChooseTopicsScreen({Key? key}) : super(key: key);

  static AuthViewModel authViewModel = Get.find<AuthViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: ColorManger.instance.homeGradient),
            color: ColorManger.instance.primaryColor),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(0),
          primary: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              SvgPicture.asset("assets/svgs/choose_topics.svg"),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "اختر المجالات التي تقدمها في الاستشارات الخاصة بك",
                  style: TextManger.instance.textStyleWhiteColorh4,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder<void>(
                  future: authViewModel.getTopics(),
                  builder: (context, snapshot) {
                    return Consumer<AuthViewModel>(
                      builder: (context, logic, child) {
                        if (logic.isLoading) {
                          return const CircleLoading();
                        } else {
                          return GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            primary: false,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 115,
                                    childAspectRatio: 3 / 2,
                                    crossAxisSpacing: 4,
                                    mainAxisSpacing: 4),
                            itemBuilder: (_, index) => logic.selectedTopics
                                    .contains(logic.topics[index])
                                // todo Change unselected Widget Color::
                                ? SeconderyButton(
                                    textButton: logic.topics[index].name ?? "",
                                    onClicked: () {
                                      logic.addNewTopic(
                                          topic: logic.topics[index]);
                                    })
                                : SeconderyUnSelectedButton(
                                    textButton: logic.topics[index].name ?? "",
                                    onClicked: () {
                                      logic.addNewTopic(
                                          topic: logic.topics[index]);
                                    }),
                            itemCount: logic.topics.length,
                          );
                        }
                      },
                    );
                  }),
              const SizedBox(
                height: 24,
              ),
              Consumer<AuthViewModel>(
                builder: (context, log, child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: log.selectedTopics.isEmpty
                        ? SeconderyButton(
                            textButton: "اختر مجال ", onClicked: () {})
                        : SeconderyButton(
                            textButton: "ابدأ الأن",
                            onClicked: () {
                              log.onClickStart();
                            },
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
