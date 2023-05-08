import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/core/theme/text_theme/text_font_sizes.dart';
import 'package:consulting_app/utils/constance/constance.dart';
import 'package:flutter/material.dart';

class TextManger {
  TextManger._();
  static TextManger instance = TextManger._();

  final TextStyle textStyleh1 = TextStyle(
      color: ColorManger.instance.blackColor,
      fontSize: TextFontSizes.instance.fontSize32);

  final TextStyle textStyleh2 = TextStyle(
      color: ColorManger.instance.blackColor,
      fontSize: TextFontSizes.instance.fontSize28);

  final TextStyle textStyleh3 = TextStyle(
      color: ColorManger.instance.blackColor,
      fontSize: TextFontSizes.instance.fontSize24);

  final TextStyle textStyleh4 = TextStyle(
      color: ColorManger.instance.blackColor,
      fontSize: TextFontSizes.instance.fontSize20);

  final TextStyle textStyleh5 = TextStyle(
      color: ColorManger.instance.blackColor,
      fontSize: TextFontSizes.instance.fontSize16);

  final TextStyle textStyleh6 = TextStyle(
      color: ColorManger.instance.blackColor,
      fontSize: TextFontSizes.instance.fontSize12);    


final TextStyle textStylePrimaryColorh4 = TextStyle(
      color: ColorManger.instance.primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: TextFontSizes.instance.fontSize20);

  final TextStyle textStylePrimaryColorh5 = TextStyle(
      color: ColorManger.instance.primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: TextFontSizes.instance.fontSize16);

  final TextStyle textStylePrimaryColorh6 = TextStyle(
      color: ColorManger.instance.primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: TextFontSizes.instance.fontSize12);  


final TextStyle textStyleWhiteColorh4 = TextStyle(
      fontFamily: Constance.instance.tajawalFont,
      fontStyle: FontStyle.normal,
      color: ColorManger.instance.backgroundColor,
      fontSize: TextFontSizes.instance.fontSize20);

      final TextStyle textStyleWhiteColorh5 = TextStyle(
      color: ColorManger.instance.backgroundColor,
      fontSize: TextFontSizes.instance.fontSize16);
}
