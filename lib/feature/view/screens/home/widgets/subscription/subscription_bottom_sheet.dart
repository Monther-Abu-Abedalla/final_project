import 'package:consulting_app/feature/core/theme/input_theme/app_text_field_theme.dart';
import 'package:consulting_app/feature/view/widget/primary_button.dart';
import 'package:consulting_app/feature/view_model/home_view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../model/home/subscription_model.dart';

class SubscriptionBottomSheet extends StatelessWidget {
  const SubscriptionBottomSheet({Key? key, required this.subscription})
      : super(key: key);

  final Subscription subscription;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
      decoration: AppTextFieldTheme.instance.bottomSheetDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "تمديد الاستشارة لمدة ${Duration(milliseconds: subscription.exteaTime?.toInt() ?? 0).inMinutes} دقائق",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 32),
          Text(
            "سعر التمديد ${subscription.extraTimePrice}",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 32),
          Consumer<HomeViewModel>(
            builder: (_ , build , __) {
              return PrimaryButton(
                isLoading: build.isLoading,
                textButton: "تأكيد العملية",
                onClicked: () {
                  build.makePayment(
                    subscription: subscription,
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
