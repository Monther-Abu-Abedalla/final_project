import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/model/home/comment_model.dart';
import 'package:flutter/material.dart';

import '../../../widget/image_network.dart';

class MyCommentItem extends StatelessWidget {
  const MyCommentItem({Key? key, required this.comment}) : super(key: key);

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: CustomImageNetwork(
              url: comment.makerImageUrl,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.65,
            decoration: BoxDecoration(
              border: Border.all(color: ColorManger.instance.borderColor),
              borderRadius: BorderRadius.circular(16),
              color: ColorManger.instance.backgroundColor,
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
        ],
      ),
    );
  }
}
