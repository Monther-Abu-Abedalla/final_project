// ignore_for_file: unused_field, prefer_final_fields

import 'package:consulting_app/feature/view/screens/auth/widgets/social_item.dart';
import 'package:consulting_app/feature/view_model/auth_view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({Key? key, required this.isLogin}) : super(key: key);

  static AuthViewModel _homeViewModel = Get.find<AuthViewModel>();
  final bool isLogin;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          width: 32,
        ),
        SocialItem(
          onPressed: () {
            _homeViewModel.signupWithGoogle(isLogin: isLogin);
          },
          iconPath: "assets/svgs/google.svg",
        ),
        const SizedBox(
          width: 16,
        ),
        SocialItem(
            onPressed: () {
              _homeViewModel.signInWithFacebook(isLogin: isLogin);
            },
            iconPath: "assets/svgs/facebook.svg"),
        const SizedBox(
          width: 16,
        ),
        SocialItem(
            onPressed: () {
              _homeViewModel.signInWithTwitter(isLogin: isLogin);
            },
            iconPath: "assets/svgs/twitter.svg"),
        const SizedBox(
          width: 32,
        ),
      ],
    );
  }
}
