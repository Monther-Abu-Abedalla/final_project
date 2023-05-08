import 'package:consulting_app/feature/core/theme/input_theme/app_text_field_theme.dart';
import 'package:consulting_app/feature/core/theme/text_theme/app_text_theme.dart';
import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/core/theme/text_theme/text_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static AppTheme instance = AppTheme._();
  AppTheme._();

  ThemeData get materialLightTheme {
    return ThemeData(
      primaryColor: ColorManger.instance.primaryColor,
      fontFamily: 'Tajawal',
      secondaryHeaderColor: ColorManger.instance.seconderyColor,
      scaffoldBackgroundColor: ColorManger.instance.backgroundColor,
      textTheme: AppTextTheme.instance.textAppTheme,
      // errorColor: ColorManger.instance.errorColor,
      inputDecorationTheme: AppTextFieldTheme.instance.inputDecorationTheme,
      appBarTheme: AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextManger.instance.textStyleWhiteColorh4,
          backgroundColor: ColorManger.instance.primaryColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManger.instance.transColor,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: ColorManger.instance.primaryColor,
          )),
    );
  }
}
