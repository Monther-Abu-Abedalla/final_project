import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/model/home/post_model.dart';
import 'package:consulting_app/feature/view/screens/home/widgets/my_comment_item.dart';
import 'package:consulting_app/feature/view_model/home_view_model/home_view_model.dart';
import 'package:consulting_app/utils/date/date_time_util.dart';
import 'package:consulting_app/utils/shared/sh_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../widget/image_network.dart';
import 'other_comment_item.dart';

class PostDetailsItem extends StatelessWidget {
  const PostDetailsItem({Key? key, required this.post}) : super(key: key);

  final Post post;

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
            ClipOval(
              child: CustomImageNetwork(
                url: post.makerImageUrl,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              post.makerName ?? "",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Spacer(),
            Text(DateUtility.getChatTime(DateTime.fromMillisecondsSinceEpoch(
                        post.createdAt?.toInt() ?? 0)
                    .toString())
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
          child: Text(post.content ?? ""),
        ),
        const SizedBox(
          height: 24,
        ),
        Consumer<HomeViewModel>(
          builder: (_, home, __) {
            if (GetUtils.isNull(post.comments) || post.comments!.isEmpty) {
              return const SizedBox();
            } else {
              return ListView(
                  primary: false,
                  shrinkWrap: true,
                  controller: home.commentsController,
                  children: post.comments!.map((e) {
                    if (e.makerId ==
                        SharedPref.instance.getCurrentUserData()?.id) {
                      return MyCommentItem(comment: e);
                    } else {
                      return AthorCommentItem(
                        comment: e,
                      );
                    }
                  }).toList());
            }
          },
        ),
      ],
    );
  }
}
