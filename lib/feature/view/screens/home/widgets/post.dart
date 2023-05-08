// ignore_for_file: deprecated_member_use
import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/view/screens/home/widgets/report_block_popup_item.dart';
import 'package:consulting_app/feature/view/widget/secondery_button.dart';
import 'package:consulting_app/utils/date/date_time_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../widget/image_network.dart';
import '../post_details_screen.dart';

// ignore: must_be_immutable
class PostItem extends StatelessWidget {
  PostItem({
    Key? key,
  }) : super(key: key);

  GlobalKey previewContainer = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: previewContainer,
      child: Container(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: ColorManger.instance.backgroundColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: ColorManger.instance.postBackgroundColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const ClipOval(
                    child: CustomImageNetwork(
                      url: "",
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text("Monther Abu Abedallah"),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        "assets/svgs/star.svg",
                      )),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
                  ReportBlockPopupItem(
                    onReport: () {},
                    onBlock: () {},
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 24,
                  ),
                  Text(DateUtility.getChatTime(
                          DateTime.fromMillisecondsSinceEpoch(0).toString())
                      .toString()),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: ColorManger.instance.backgroundColor,
                    borderRadius: BorderRadius.circular(16)),
               
                child: const Text("نص افتراضي"),
              ),
              const SizedBox(
                height: 16,
              ),
              SeconderyButton(
                  height: 40,
                  textButton: "تفاصيل الاستشارة",
                  onClicked: () {
                    Get.to(() => const PostDetailsScreen(
                          postId: -1,
                          isFromNotification: false,
                        ));
                  }),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
