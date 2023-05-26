import 'package:consulting_app/feature/view/screens/notifications/widgets/notification_item.dart';
import 'package:consulting_app/feature/view_model/home_view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/color/color_manger.dart';
import '../../widget/circle_loading.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeViewModel>(context , listen: false).getNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الاشعارات"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          
        },
        child: ListView(
          primary: true,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(
              height: 24,
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
                } else if (home.notifications.isNotEmpty) {
                  return ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: home.notifications.length,
                    itemBuilder: (context, index) => NotificationItem(
                      notification: home.notifications[index],
                    ),
                    separatorBuilder: (context, index) => const Divider(
                      thickness: 1,
                    ),
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
