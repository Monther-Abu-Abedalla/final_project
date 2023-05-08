import 'package:consulting_app/fcm/app_fcm.dart';
import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/core/theme/text_theme/text_manger.dart';
import 'package:consulting_app/feature/view/screens/auth/choose_topics_screen.dart';
import 'package:consulting_app/feature/view/screens/auth/choose_user_type_screen.dart';
import 'package:consulting_app/feature/view/screens/auth/login_screen.dart';
import 'package:consulting_app/feature/view/screens/home/home_screen.dart';
import 'package:consulting_app/utils/constance/constance.dart';
import 'package:consulting_app/utils/shared/sh_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () => _routeMethod(context));

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

  _routeMethod(BuildContext context) async {
    await AppFcm.fcmInstance.getTokenFCM();

    if ((SharedPref.instance.getUserLoginState() ==
        Constance.instance.userEnterdState)) {
      //Go to Auth

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else if (SharedPref.instance.getUserLoginState() ==
        Constance.instance.userLoginedState) {
      //Go to Home
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else if (SharedPref.instance.getUserLoginState() ==
        Constance.instance.chooseTopicsState) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const ChooseTopicsScreen()));
    } else if (SharedPref.instance.getUserLoginState() ==
        Constance.instance.userAddCertificates) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      //Go to Intro
      //to do Put Intro For First Open :
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const ChooseUserTypeScreen()));
    }
  }
}
