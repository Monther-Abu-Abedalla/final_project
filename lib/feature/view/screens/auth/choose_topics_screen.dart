import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/core/theme/text_theme/text_manger.dart';
import 'package:consulting_app/feature/view/widget/secondery_button.dart';
import 'package:consulting_app/feature/view/widget/secondery_un_selected_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChooseTopicsScreen extends StatelessWidget {
  const ChooseTopicsScreen({Key? key}) : super(key: key);

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
              GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                primary: false,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 115,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4),
                itemBuilder: (_, index) =>
                    SeconderyUnSelectedButton(textButton: "", onClicked: () {}),
                itemCount: 3,
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child:
                    SeconderyButton(textButton: "ابدأ الأن", onClicked: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
