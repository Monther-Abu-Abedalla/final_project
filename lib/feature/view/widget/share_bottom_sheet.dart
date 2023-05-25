import 'package:consulting_app/feature/core/theme/input_theme/app_text_field_theme.dart';
import 'package:consulting_app/feature/view/widget/secondery_button.dart';
import 'package:consulting_app/feature/view/widget/unselected_button.dart';
import 'package:consulting_app/feature/view_model/home_view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ShowBottomSheet extends StatelessWidget {
  const ShowBottomSheet(
      {Key? key, required this.body, required this.shareRequestId})
      : super(key: key);

  final String body;
  final int shareRequestId;
  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

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
          Consumer<HomeViewModel>(
            builder: (_, home, __) {
              return SeconderyButton(
                isLoading: home.isLoadingSharePost,
                textButton: "الموافقة",
                onClicked: () async {
                  await homeViewModel.updateShareRequestNotification(
                      shareRequestId: shareRequestId, status: 2);
                  Get.back();
                },
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
          Consumer<HomeViewModel>(
            builder: (_, home, __) {
              return UnselectedButton(
                isLoading: home.isLoadingDelete,
                text: "الرفض",
                onPressed: () async {
                  await homeViewModel.updateShareRequestNotification(
                      shareRequestId: shareRequestId, status: 0);
                  Get.back();
                },
              );
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
