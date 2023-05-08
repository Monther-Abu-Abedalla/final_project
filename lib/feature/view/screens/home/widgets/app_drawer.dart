import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/view/screens/account_status/account_status_screen.dart';
import 'package:consulting_app/feature/view/screens/app_questions/app_question_screen.dart';
import 'package:consulting_app/feature/view/screens/app_summary/app_summary_screen.dart';
import 'package:consulting_app/feature/view/screens/favorite_posts/favorite_posts_screen.dart';
import 'package:consulting_app/feature/view/screens/my_posts/my_posts_screen.dart';
import 'package:consulting_app/feature/view/screens/privacy_policy/privacy_policy_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'drawer_item.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Container(
            width: double.infinity,
            height: 160,
            color: ColorManger.instance.primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Monther Abu Abedallah",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: ColorManger.instance.backgroundColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text("montherabedallah@gmail.com",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: ColorManger.instance.backgroundColor)),
              ],
            ),
          ),
          DrawerItem(
            onTap: () {
              Get.back();
            },
            iconPath: "assets/svgs/home_icon.svg",
            title: "الصفحة الرئيسية",
          ),
          DrawerItem(
            onTap: () {
              Get.back();
              Get.to(() => const FavoriteScreen());
            },
            iconPath: "assets/svgs/star.svg",
            title: "المفضلة",
          ),
          DrawerItem(
            onTap: () {
              Get.back();
              Get.to(() => const MyPostsScreen());
            },
            iconPath: "assets/svgs/consuliting_icon.svg",
            title: "استشاراتي",
          ),
          DrawerItem(
            onTap: () {},
            iconPath: "assets/svgs/share.svg",
            title: "مشاركة التطبيق",
          ),
          DrawerItem(
            onTap: () {
              Get.back();
              Get.to(() => const AppQuestionScreen());
            },
            iconPath: "assets/svgs/questions_icon.svg",
            title: " الأسئلة الشائعة",
          ),
          DrawerItem(
            onTap: () {
              Get.back();
              Get.to(() => const PrivacyPolicyScreen());
            },
            iconPath: "assets/svgs/terms_icon.svg",
            title: "سياسة الخصوصية",
          ),
          DrawerItem(
            onTap: () {
              Get.back();
              Get.to(() => const AppSummaryScreen());
            },
            iconPath: "assets/svgs/about_us_icon.svg",
            title: "نبذة عن التطبيق",
          ),
          // DrawerItem(
          //   onTap: () {},
          //   iconPath: "assets/svgs/contact_us.svg",
          //   title: "تواصل معنا ",
          // ),
          // DrawerItem(
          //   onTap: () {},
          //   iconPath: "assets/svgs/settings.svg",
          //   title: "الاعدادات",
          // ),
          DrawerItem(
            onTap: () {
              Get.to(() => const AccountStatusScreen(
                    isFromNotification: false,
                  ));
            },
            iconPath: "assets/svgs/status_bar.svg",
            title: "حالة حسابي",
          ),
          DrawerItem(
            onTap: () {},
            iconPath: "assets/svgs/sign_out.svg",
            title: "تسجيل خروج",
          ),
        ],
      ),
    );
  }
}
