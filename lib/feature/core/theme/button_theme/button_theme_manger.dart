import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/core/theme/text_theme/text_font_sizes.dart';
import 'package:flutter/material.dart';

class ButtonThemeManger {
  ButtonThemeManger._();
  static ButtonThemeManger instance = ButtonThemeManger._();

  ButtonStyle get prmiayButtonStyle => ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all(ColorManger.instance.primaryColor),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      )),
      textStyle: MaterialStateProperty.all(TextStyle(
          color: ColorManger.instance.backgroundColor,
          fontSize: TextFontSizes.instance.fontSize20)));

  ButtonStyle get prmiayBorderButtonStyle => ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all(ColorManger.instance.backgroundColor),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: ColorManger.instance.primaryColor))),
      textStyle: MaterialStateProperty.all(TextStyle(
          color: ColorManger.instance.primaryColor,
          fontSize: TextFontSizes.instance.fontSize20)));

  ButtonStyle get seconderyButtonStyle => ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all(ColorManger.instance.seconderyColor),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      )),
     );

  ButtonStyle get seconderyunSelectedButtonStyle => ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all(ColorManger.instance.infoColor),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      )),
     );


  ButtonStyle get unSelectedButtonStyle => ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all(ColorManger.instance.errorColor),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      )),
     );


  ButtonStyle get unselectedButtonStyle => ButtonStyle(
      side: MaterialStateProperty.all(
        BorderSide(
          color: ColorManger.instance.transColor
        )
      ),
      padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 24, vertical: 8)),
      backgroundColor:
          MaterialStateProperty.all(ColorManger.instance.unSelectedButton),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), 
      ),
      textStyle: MaterialStateProperty.all(TextStyle(
          color: ColorManger.instance.blackColor,
          fontSize: TextFontSizes.instance.fontSize20)));


}
