import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:flutter/material.dart';

import '../../../widget/image_network.dart';

class MyCommentItem extends StatelessWidget {
  const MyCommentItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ClipOval(
            child: CustomImageNetwork(
              url: "",
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
                      "Monther Abu Abedallah",
                      style: Theme.of(context).textTheme.headlineSmall,
                    )),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "So nice",
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
