import 'package:consulting_app/feature/core/theme/text_theme/text_manger.dart';
import 'package:flutter/material.dart';

class AppTextTheme {
  static AppTextTheme instance = AppTextTheme._();
  AppTextTheme._();

  TextTheme get textAppTheme => TextTheme(
        displayLarge: TextManger.instance.textStyleh1,
        displayMedium: TextManger.instance.textStyleh2,
        displaySmall: TextManger.instance.textStyleh3,
        headlineMedium: TextManger.instance.textStyleh4,
        headlineSmall: TextManger.instance.textStyleh5,
        titleLarge: TextManger.instance.textStyleh6,
      );
}
