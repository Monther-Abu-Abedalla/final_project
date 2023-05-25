import 'package:consulting_app/fcm/app_fcm.dart';
import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/core/theme/text_theme/text_manger.dart';
import 'package:consulting_app/feature/view/screens/auth/choose_topics_screen.dart';
import 'package:consulting_app/feature/view/screens/auth/choose_user_type_screen.dart';
import 'package:consulting_app/feature/view/screens/auth/login_screen.dart';
import 'package:consulting_app/feature/view/screens/home/home_screen.dart';
import 'package:consulting_app/feature/view_model/home_view_model/home_view_model.dart';
import 'package:consulting_app/utils/constance/constance.dart';
import 'package:consulting_app/utils/shared/sh_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {    
     Future.delayed(const Duration(seconds: 2), () => _routeMethod());

    return Scaffold(
      backgroundColor: ColorManger.instance.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundColor: ColorManger.instance.backgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: SvgPicture.asset(
                  "assets/svgs/logo.svg",
                  height: 140,
                  width: 140,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              "خبراء",
              style: TextManger.instance.textStyleh3
                  .copyWith(color: ColorManger.instance.backgroundColor),
            )
          ],
        ),
      ),
    );
  }

  _routeMethod() async {
   
    await AppFcm.fcmInstance.getTokenFCM();

    if ((SharedPref.instance.getUserLoginState() ==
        Constance.instance.userEnterdState)) {
      //Go to Auth
      Get.off(() => LoginScreen());
    } else if (SharedPref.instance.getUserLoginState() ==
        Constance.instance.userLoggedState) {
      //Go to Home
      Get.put(HomeViewModel(), permanent: true);
      Get.off(() => const HomeScreen());
      
    } else if (SharedPref.instance.getUserLoginState() ==
        Constance.instance.chooseTopicsState) {
      Get.off(() => const ChooseTopicsScreen());
    } else if (SharedPref.instance.getUserLoginState() ==
        Constance.instance.userAddCertificates) {
      Get.off(() => LoginScreen());
    } else {
      //Go to Intro
      //to do Put Intro For First Open :
      Get.off(() => const ChooseUserTypeScreen());
    }
  }
}
