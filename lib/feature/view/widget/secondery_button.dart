import 'package:consulting_app/feature/core/theme/button_theme/button_theme_manger.dart';
import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/core/theme/text_theme/text_manger.dart';
import 'package:consulting_app/feature/view/widget/three_size_dot.dart';
import 'package:flutter/material.dart';

class SeconderyButton extends StatelessWidget {
  const SeconderyButton({
    Key? key,
    required this.textButton,
    required this.onClicked,
    this.height = 55,
    this.width,
    this.isLoading = false,
  }) : super(key: key);

  final String textButton;
  final Function onClicked;
  final double height;
  final double? width;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: height,
          width: width??double.infinity,
          child: ElevatedButton(
              style: ButtonThemeManger.instance.seconderyButtonStyle,
              onPressed: isLoading
                  ? () {}
                  : () {
                      onClicked();
                    },
              child: isLoading
                  ? const ThreeSizeDot()
                  : Text(
                      textButton,
                      style: TextManger.instance.textStyleh5.copyWith(
                          color: ColorManger.instance.primaryDarkColor),
                    )),
        ),
      ],
    );
  }
}
