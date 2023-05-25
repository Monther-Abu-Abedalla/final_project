import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/core/theme/input_theme/app_text_field_theme.dart';
import 'package:flutter/material.dart';

import 'incrases_form.dart';

class IncreaseTimeBottomSheet extends StatelessWidget {
  const IncreaseTimeBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: AppTextFieldTheme.instance.bottomSheetDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          Text(
            'تمديد وقت الاستشارة ',
            style: Theme.of(context).textTheme.headlineMedium!
                .copyWith(color: ColorManger.instance.primaryColor),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "لزيادة وقت جلسة الاستشارة يجب ادخال الخيار المناسب لك ",
            style: Theme.of(context).textTheme.headlineSmall!
                .copyWith(color: ColorManger.instance.primaryColor),
          ),
          const SizedBox(
            height: 16,
          ),
          IncraesesForm(),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
