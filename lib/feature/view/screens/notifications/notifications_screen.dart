import 'package:consulting_app/feature/view/screens/notifications/widgets/notification_item.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الاشعارات"),
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
            ListView.separated(
              primary: false,
              shrinkWrap: true,
              reverse: true,
              itemCount: 3,
              itemBuilder: (context, index) => const NotificationItem(),
              separatorBuilder: (context, index) => const Divider(
                thickness: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
