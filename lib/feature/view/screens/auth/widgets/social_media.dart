// ignore_for_file: unused_field, prefer_final_fields

import 'package:consulting_app/feature/view/screens/auth/widgets/social_item.dart';
import 'package:flutter/material.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({Key? key, required this.isLogin}) : super(key: key);

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
          onPressed: () {},
          iconPath: "assets/svgs/google.svg",
        ),
        const SizedBox(
          width: 16,
        ),
        SocialItem(onPressed: () {}, iconPath: "assets/svgs/facebook.svg"),
        const SizedBox(
          width: 16,
        ),
        SocialItem(onPressed: () {}, iconPath: "assets/svgs/twitter.svg"),
        const SizedBox(
          width: 32,
        ),
      ],
    );
  }
}
