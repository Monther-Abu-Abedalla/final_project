import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/view/screens/home/widgets/add_post/person_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("إضافة استشارة"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "عنوان الاستشارة",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: ColorManger.instance.primaryColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (e) {
                    if (e!.trim().isEmpty) {
                      return "هذا الحقل فارغ";
                    } else if (e.length < 2) {
                      return "عنوان غير صالح";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: ColorManger.instance.postBackgroundColor,
                      label: Text(
                        "عنوان الاستشارة",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: ColorManger.instance.primaryColor),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text("نوع الاستشارة ",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: ColorManger.instance.primaryColor)),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  readOnly: true,
                  onTap: () {},
                  validator: (e) {
                    if (e!.trim().isEmpty) {
                      return "هذا الحقل فارغ";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset("assets/svgs/dropdown.svg"),
                    ),
                    fillColor: ColorManger.instance.backgroundColor,
                    label: const Text("نوع الاستشارة"),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "تفاصيل الاستشارة",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: ColorManger.instance.primaryColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (e) {
                    if (e!.trim().isEmpty) {
                      return "هذا الحقل فارغ";
                    }
                    return null;
                  },
                  maxLines: 6,
                  minLines: 6,
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: const EdgeInsets.all(20),
                    fillColor: ColorManger.instance.postBackgroundColor,
                    label: const Text("تفاصيل الاستشارة"),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  " افضل المستشارين",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: ColorManger.instance.primaryColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "يمكن تحديد مستشار  واحد فقط لارسال الاستشارة",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: ColorManger.instance.primaryColor),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    InkWell(
                        onTap: () {},
                        child: SvgPicture.asset("assets/svgs/uncheck.svg")),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      "اخفاء اسمي",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: ColorManger.instance.primaryColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    InkWell(
                        onTap: () {},
                        child: SvgPicture.asset("assets/svgs/uncheck.svg")),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      "استشارة عامة",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: ColorManger.instance.primaryColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: 200,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(12),
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) => PersonItem(
                      myKey: formKey,
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 12,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
