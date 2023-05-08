import 'package:consulting_app/feature/view/screens/home/widgets/app_drawer.dart';
import 'package:consulting_app/feature/view/screens/home/widgets/home_header.dart';
import 'package:consulting_app/feature/view/screens/home/widgets/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const NotificationsScreen()));
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
            ListView(
              primary: false,
              shrinkWrap: true,
              children: [
                PostItem(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
