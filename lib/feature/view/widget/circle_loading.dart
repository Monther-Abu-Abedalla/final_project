import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:flutter/material.dart';

class CircleLoading extends StatelessWidget {
  const CircleLoading({Key? key, this.background}) : super(key: key);

  final Color? background;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: background ?? ColorManger.instance.backgroundColor,
      ),
    );
  }
}
