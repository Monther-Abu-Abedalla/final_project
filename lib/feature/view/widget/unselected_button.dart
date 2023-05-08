import 'package:consulting_app/feature/view/widget/three_size_dot.dart';
import 'package:flutter/material.dart';

import '../../core/theme/button_theme/button_theme_manger.dart';
import '../../core/theme/color/color_manger.dart';

class UnselectedButton extends StatelessWidget {
  const UnselectedButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.isLoading = false,
      this.height,
      this.width})
      : super(key: key);

  final Function onPressed;
  final String text;
  final bool isLoading;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50,
      child: ElevatedButton(
        style: ButtonThemeManger.instance.unselectedButtonStyle,
        onPressed: () {
          onPressed();
        },
        child: isLoading
            ? ThreeSizeDot(
                color_1: ColorManger.instance.blackColor,
                color_2: ColorManger.instance.blackColor,
                color_3: ColorManger.instance.blackColor,
              )
            : Text(
                text,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: ColorManger.instance.blackColor,
                  fontWeight: FontWeight.bold
                ),
              ),
      ),
    );
  }
}
