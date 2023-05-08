import 'package:flutter/material.dart';
import '../../../../core/theme/color/color_manger.dart';

class ReportBlockPopupItem extends StatelessWidget {
  const ReportBlockPopupItem(
      {Key? key, required this.onReport, required this.onBlock})
      : super(key: key);

  final Function onReport;
  final Function onBlock;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (ctx) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              Icon(
                Icons.report,
                color: ColorManger.instance.primaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "الإبلاغ عن محتوى",
                style: TextStyle(color: ColorManger.instance.primaryColor),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Icon(
                Icons.block,
                color: ColorManger.instance.primaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "حظر المستخدم",
                style: TextStyle(color: ColorManger.instance.primaryColor),
              ),
            ],
          ),
        ),
      ],
      onSelected: (value) {},
    );
  }
}
