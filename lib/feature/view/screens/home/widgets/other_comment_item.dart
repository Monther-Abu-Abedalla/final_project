import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/model/home/comment_model.dart';
import 'package:consulting_app/feature/view/screens/home/widgets/report_block_popup_item.dart';
import 'package:flutter/material.dart';

import '../../../widget/image_network.dart';

class AthorCommentItem extends StatelessWidget {
  const AthorCommentItem({Key? key, required this.comment}) : super(key: key);

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ReportBlockPopupItem(
            onReport: () {},
            onBlock: () {},
          ),
          Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.65,
            decoration: BoxDecoration(
              border: Border.all(color: ColorManger.instance.borderColor),
              borderRadius: BorderRadius.circular(16),
              color: ColorManger.instance.opcityPrimaryColor.withOpacity(0.2),
            ),
            child: Column(
              children: [
                SizedBox(
                    width: double.infinity,
                    child: Text(
                      comment.makerName ?? "",
                      style: Theme.of(context).textTheme.headlineSmall,
                    )),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  comment.content ?? "",
                )
              ],
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          ClipOval(
            child: CustomImageNetwork(
              url: comment.makerImageUrl,
            ),
          ),
        ],
      ),
    );
  }
}
