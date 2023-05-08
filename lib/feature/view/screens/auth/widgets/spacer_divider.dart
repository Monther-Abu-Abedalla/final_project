import 'package:flutter/material.dart';

class SpacerDivider extends StatelessWidget {
  const SpacerDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: const [
      Expanded(
          child: Divider(
        thickness: 2,
        height: 5,
      )),
      SizedBox(
        width: 16,
      ),
      Text("أو باستخدام"),
      SizedBox(
        width: 16,
      ),
      Expanded(
          child: Divider(
        thickness: 2,
        height: 5,
      )),
    ]);
  }
}
