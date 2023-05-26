import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/view/screens/home/widgets/app_drawer.dart';
import 'package:consulting_app/feature/view/screens/home/widgets/home_header.dart';
import 'package:consulting_app/feature/view/screens/home/widgets/post.dart';
import 'package:consulting_app/feature/view/widget/circle_loading.dart';
import 'package:consulting_app/feature/view_model/home_view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../notifications/notifications_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const NotificationsScreen());
            },
            icon: SvgPicture.asset(
              "assets/svgs/notification.svg",
            ),
          ),
        ],
        title: const Text('الصفحة الرئيسية'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView(
          primary: true,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(
              height: 24,
            ),
            const HomeHeader(),
            const SizedBox(
              height: 20,
            ),
            Consumer<HomeViewModel>(
              builder: (_, home, __) {
                if (home.isLoading) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      CircleLoading(
                        background: ColorManger.instance.primaryColor,
                      ),
                    ],
                  );
                } else if (home.homePosts.isNotEmpty) {
                  return ListView(
                    primary: false,
                    shrinkWrap: true,
                    children: home.homePosts.map((post) {
                      return PostItem(post: post);
                    }).toList(),
                  );
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
