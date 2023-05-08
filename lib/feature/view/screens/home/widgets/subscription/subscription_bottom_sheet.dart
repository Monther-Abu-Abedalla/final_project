import 'package:consulting_app/feature/core/theme/input_theme/app_text_field_theme.dart';
import 'package:consulting_app/feature/view/widget/primary_button.dart';
import 'package:flutter/material.dart';

class SubscriptionBottomSheet extends StatelessWidget {
  const SubscriptionBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
      decoration: AppTextFieldTheme.instance.bottomSheetDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "تمديد الاستشارة لمدة ${const Duration(milliseconds: 0).inMinutes} دقائق",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 32),
          Text(
            "سعر التمديد ",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 32),
          PrimaryButton(
            textButton: "تأكيد العملية",
            onClicked: () {},
          )
        ],
      ),
    );
  }
}
