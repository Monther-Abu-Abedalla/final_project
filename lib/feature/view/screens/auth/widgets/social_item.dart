import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialItem extends StatelessWidget {
  const SocialItem({Key? key, required this.iconPath , required this.onPressed}) : super(key: key);

  final String iconPath;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: ColorManger.instance.borderColor)),
      child: CircleAvatar(
        radius: 22,
        backgroundColor: ColorManger.instance.transColor,
        child: IconButton(onPressed: () {
          onPressed();
        }, icon: SvgPicture.asset(iconPath)),
      ),
    );
  }
}
