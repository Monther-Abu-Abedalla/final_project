import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/core/theme/text_theme/text_manger.dart';
import 'package:consulting_app/feature/view/screens/auth/register_screen.dart';
import 'package:consulting_app/feature/view/widget/primary_border_button.dart';
import 'package:consulting_app/feature/view/widget/primary_button.dart';
import 'package:consulting_app/utils/constance/constance.dart';
import 'package:consulting_app/utils/shared/sh_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:logger/logger.dart';

class ChooseUserTypeScreen extends StatelessWidget {
  const ChooseUserTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: ColorManger.instance.homeGradient),
            color: ColorManger.instance.primaryColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            SvgPicture.asset("assets/svgs/choose_type.svg"),
            const SizedBox(
              height: 60,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height / 1.9,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(32)),
                color: ColorManger.instance.backgroundColor,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "مرحبا بك في خبرات",
                    style: TextManger.instance.textStylePrimaryColorh4,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    "من أنت ؟",
                    style: TextManger.instance.textStylePrimaryColorh5,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  PrimaryButton(
                      textButton: "صاحب استشارة",
                      onClicked: () {
                        SharedPref.instance.setUserType(
                            userType: Constance.instance.questionerUserType);
                        Logger().e(SharedPref.instance.getUserType());
                        Get.off(() => RegisterScreen());
                      }),
                  const SizedBox(
                    height: 32,
                  ),
                  PrimaryBorderButton(
                      textButton: "مقدم استشارة",
                      onClicked: () {
                        SharedPref.instance.setUserType(
                            userType: Constance.instance.consultantUserType);
                        Logger().e(SharedPref.instance.getUserType());
                        Get.off(() => RegisterScreen());
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
