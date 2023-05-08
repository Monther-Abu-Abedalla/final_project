import 'package:consulting_app/feature/core/theme/button_theme/button_theme_manger.dart';
import 'package:consulting_app/feature/core/theme/text_theme/text_manger.dart';
import 'package:consulting_app/feature/view/widget/three_size_dot.dart';
import 'package:flutter/material.dart';

class PrimaryBorderButton extends StatelessWidget {
  const PrimaryBorderButton(
      {Key? key,
      required this.textButton,
      required this.onClicked,
      this.height = 55,
      this.isLoading = false
      })
      : super(key: key);

  final String textButton;
  final Function onClicked;
  final double height;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonThemeManger.instance.prmiayBorderButtonStyle,
          onPressed: () {
            onClicked();
          },
          child: isLoading ? const ThreeSizeDot() : Text(
            textButton,
            style: TextManger.instance.textStylePrimaryColorh4
                .copyWith(fontWeight: FontWeight.normal),
          )),
    );
  }
}
