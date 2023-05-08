import 'package:consulting_app/feature/core/theme/input_theme/app_text_field_theme.dart';
import 'package:consulting_app/feature/view/widget/secondery_button.dart';
import 'package:consulting_app/feature/view/widget/unselected_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ShowBottomSheet extends StatelessWidget {
  const ShowBottomSheet(
      {Key? key, required this.body, required this.shareRequestId})
      : super(key: key);

  final String body;
  final int shareRequestId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: AppTextFieldTheme.instance.bottomSheetDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 24,
          ),
          SvgPicture.asset(
            "assets/svgs/share_post.svg",
            height: 100,
            width: 100,
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            body,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(
            height: 40,
          ),
          SeconderyButton(
            textButton: "الموافقة",
            onClicked: () async {
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            height: 16,
          ),
          UnselectedButton(
            text: "الرفض",
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
