import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyPlaceHolder extends StatelessWidget {
  const EmptyPlaceHolder(
      {Key? key, required this.imagePath, required this.title})
      : super(key: key);

  final String imagePath;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            imagePath,
            height: 200,
            width: 200,
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
