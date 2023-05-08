import 'package:consulting_app/feature/core/theme/button_theme/button_theme_manger.dart';
import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/view/widget/three_size_dot.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key,
      required this.textButton,
      required this.onClicked,
      this.height = 55,
      this.color,
      this.isLoading = false})
      : super(key: key);

  final String textButton;
  final Function onClicked;
  final double height;
  final bool isLoading;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonThemeManger.instance.prmiayButtonStyle.copyWith(
            backgroundColor: MaterialStateProperty.all(
              color ?? ColorManger.instance.primaryColor,
            ),
          ),
          onPressed: () {
            onClicked();
          },
          child: isLoading ? const ThreeSizeDot() : Text(textButton)),
    );
  }
}
