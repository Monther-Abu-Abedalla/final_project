import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:flutter/material.dart';

class AppTextFieldTheme {
  static AppTextFieldTheme instance = AppTextFieldTheme._();
  AppTextFieldTheme._();

  InputDecorationTheme get inputDecorationTheme {
    return InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusColor: ColorManger.instance.primaryColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20));
  }

  BoxDecoration get bottomSheetDecoration {
    return BoxDecoration(
        color: ColorManger.instance.backgroundColor,
        borderRadius: const BorderRadius.vertical(top : Radius.circular(20)));
  }
}
