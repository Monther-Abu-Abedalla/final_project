import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/model/home/notification_model.dart';
import 'package:consulting_app/feature/view/widget/primary_button.dart';
import 'package:consulting_app/feature/view/widget/secondery_button.dart';
import 'package:consulting_app/feature/view_model/home_view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({Key? key, required this.notification})
      : super(key: key);

  final NotificationModel notification;
  static final HomeViewModel homeViewModel =
      Get.put(HomeViewModel(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(notification.notificationAr ?? ""),
        ),
        const SizedBox(
          height: 8,
        ),
        if (notification.shareStatus == 1) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SeconderyButton(
                  height: 34,
                  textButton: "سماح",
                  onClicked: () async {
                    await homeViewModel.updateShareRequestNotification(
                        shareRequestId: notification.shareRequestId ?? -1,
                        status: 2);
                    await homeViewModel.getNotifications();
                  },
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: PrimaryButton(
                  color: ColorManger.instance.errorColor,
                  height: 34,
                  textButton: "رفض",
                  onClicked: () async {
                    await homeViewModel.updateShareRequestNotification(
                        shareRequestId: notification.shareRequestId ?? -1,
                        status: 0);
                    await homeViewModel.getNotifications();
                  },
                ),
              ),
            ],
          ),
        ],
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
