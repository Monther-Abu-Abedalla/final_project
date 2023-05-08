// ignore_for_file: must_be_immutable

import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/view/widget/primary_button.dart';
import 'package:flutter/material.dart';

class IncraesesForm extends StatelessWidget {
  IncraesesForm({Key? key}) : super(key: key);

  GlobalKey<FormState> myKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: ColorManger.instance.borderColor),
            borderRadius: BorderRadius.circular(16),
            color: ColorManger.instance.postBackgroundColor,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ColorManger.instance.backgroundColor,
            ),
            child: Form(
              key: myKey,
              child: Row(
                children: [
                  const SizedBox(
                    width: 12,
                  ),
                  const Text("زيادة"),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                      child: TextFormField(
                    validator: (e) {
                      if (e!.trim().isEmpty) {
                        return 'هذا الحقل فارغ';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(
                            color: ColorManger.instance.errorColor,
                            fontSize: 10),
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none),
                  )),
                  const Text("دقائق"),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text(":"),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                      child: TextFormField(
                    validator: (e) {
                      if (e!.trim().isEmpty) {
                        return 'هذا الحقل فارغ';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(
                            color: ColorManger.instance.errorColor,
                            fontSize: 10),
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none),
                  )),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text("ريال"),
                  const SizedBox(
                    width: 12,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        PrimaryButton(
          textButton: "تأكيد",
          onClicked: () {},
        )
      ],
    );
  }
}
