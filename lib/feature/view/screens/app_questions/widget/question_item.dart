import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class QuestionItem extends StatelessWidget {
  const QuestionItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ExpandablePanel(
        theme: const ExpandableThemeData(
            useInkWell: false, animationDuration: Duration(milliseconds: 500)),
        expanded: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            )),
        collapsed: const SizedBox(
          height: 16,
        ),
        header: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "نص افتراضي",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}
