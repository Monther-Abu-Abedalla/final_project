import 'package:consulting_app/feature/view/widget/secondery_button.dart';
import 'package:flutter/material.dart';

class TopicItem extends StatelessWidget {
  const TopicItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SeconderyButton(
          textButton: "نص افتراضي",
          onClicked: () {},
        ),
        const SizedBox(
          height: 12,
        )
      ],
    );
  }
}
