import 'package:flutter/material.dart';

class ColorManger {
  ColorManger._();
  static ColorManger instance = ColorManger._();

  final Color primaryColor = const Color(0xFF06447b);
  final Color primaryDarkColor = const Color(0xFF133954);
  final Color opcityPrimaryColor = const Color(0xFF245F9C);
  final Color alphaPrimaryColor = const Color(0xFF11467C);
  final Color strongOpacity = const Color(0xFF156CC6);
  final Color seconderyColor = const Color(0xFFF7cb4e);
  final Color seconderyDarkColor = const Color(0xFFE29E2A);
  final Color transColor = const Color(0x00000000);
  final Color backgroundColor = const Color(0xFFFFFFFF);
  final Color successColor = const Color(0xFF00C851);
  final Color errorColor = const Color(0xFFff4444);
  final Color unSelectedButton = const Color(0xFFF1F1F1);
  final Color infoColor = const Color(0xFF33b5e5);
  final Color blackColor = const Color(0xFF000000);
  final Color borderColor = const Color(0xFF707070).withOpacity(0.8);
  final Color contanierColor = const Color(0xFFF8F8F8);
  final Color postBackgroundColor = const Color(0xFF034080).withOpacity(0.1);
  final List<Color> homeGradient = [
    const Color(0xFF06447b),
    const Color(0xFF245F9C),
    const Color(0xFF11467C),
    const Color(0xFF156CC6)
    //ColorManger.instance.primaryColor,
    //ColorManger.instance.opcityPrimaryColor,
    //ColorManger.instance.alphaPrimaryColor,
    //ColorManger.instance.strongOpacity
  ];
}
