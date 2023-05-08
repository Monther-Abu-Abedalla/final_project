// ignore_for_file: must_be_immutable

import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/view/widget/primary_button.dart';
import 'package:flutter/material.dart';


class PersonItem extends StatelessWidget {
  PersonItem({
    Key? key,
    required this.myKey,
  }) : super(key: key);


  GlobalKey<FormState> myKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          height: 100,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: ColorManger.instance.backgroundColor,
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                Text(
            
                  "Monther Abu Abedallah",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: ColorManger.instance.primaryColor),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            bottom: 34,
            right: 10,
            left: 10,
            child: PrimaryButton(
              height: 36,
              onClicked: () {},
              textButton: "توجيه الاستشارة",
            ))
      ],
    );
  }
}
