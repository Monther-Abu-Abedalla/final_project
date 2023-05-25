import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/view/widget/secondery_button.dart';
import 'package:consulting_app/feature/view_model/home_view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/shared/sh_util.dart';
import '../add_post_screen.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: ColorManger.instance.contanierColor,
          boxShadow: [
            BoxShadow(
              color: ColorManger.instance.blackColor.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Consumer<HomeViewModel>(
            builder: (__,_,___) {
              return Column(
                children: [
                  Text(
                    "يمكنك الان طرح استشارتك\n بسهولة و امان",
                    style: Theme.of(context).textTheme.headlineSmall!
                        .copyWith(color: ColorManger.instance.primaryColor),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  if (SharedPref.instance.getCurrentUserData()?.isApproved ==
                      true)
                    SeconderyButton(
                      width: 150,
                      height: 30,
                      textButton: "اضافة",
                      onClicked: () {
                        // homeViewModel.startUri();
                        Get.to(() => const AddPostScreen());
                      },
                    )
                ],
              );
            },
          ),
          const Spacer(),
          SvgPicture.asset("assets/svgs/add_post.svg")
        ],
      ),
    );
  }
}
