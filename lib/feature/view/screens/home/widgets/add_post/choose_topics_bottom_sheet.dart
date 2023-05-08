import 'package:consulting_app/feature/core/theme/input_theme/app_text_field_theme.dart';
import 'package:consulting_app/feature/view/screens/home/widgets/add_post/topic_item.dart';
import 'package:flutter/material.dart';

class ChooseTopicsBottomSheet extends StatelessWidget {
  const ChooseTopicsBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
        decoration: AppTextFieldTheme.instance.bottomSheetDecoration,
        child: Column(
            mainAxisSize: MainAxisSize.min, children: const [TopicItem()]));
  }
}
