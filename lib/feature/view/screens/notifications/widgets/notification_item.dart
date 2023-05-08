import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/view/widget/primary_button.dart';
import 'package:consulting_app/feature/view/widget/secondery_button.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ListTile(
          title: Text("نص افتراضي"),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SeconderyButton(
                height: 34,
                textButton: "سماح",
                onClicked: () {},
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: PrimaryButton(
                color: ColorManger.instance.errorColor,
                height: 34,
                textButton: "رفض",
                onClicked: () {},
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
