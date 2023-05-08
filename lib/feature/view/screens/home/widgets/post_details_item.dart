import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/view/screens/home/widgets/my_comment_item.dart';
import 'package:consulting_app/utils/date/date_time_util.dart';
import 'package:flutter/material.dart';
import '../../../widget/image_network.dart';

class PostDetailsItem extends StatelessWidget {
  const PostDetailsItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: false,
      shrinkWrap: true,
      children: [
        Row(
          children: [
            // if (post.makerViewingType == Constance.instance.isHide)
            //   ClipOval(
            //     child: CustomImageNetwork(
            //       url: Constance.instance.imagePlaceHolder,
            //     ),
            //   ),
            // if (post.makerViewingType == Constance.instance.isViwer)
            const ClipOval(
              child: CustomImageNetwork(
               
                url: "",
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Spacer(),
            Text(DateUtility.getChatTime(
                    DateTime.fromMillisecondsSinceEpoch(0).toString())
                .toString()),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: ColorManger.instance.borderColor),
            borderRadius: BorderRadius.circular(16),
            color: ColorManger.instance.backgroundColor,
          ),
          child: const Text(""),
        ),
        const SizedBox(
          height: 24,
        ),
        ListView(primary: false, shrinkWrap: true, children: const [
          MyCommentItem(),
          MyCommentItem(),
        ])
      ],
    );
  }
}
