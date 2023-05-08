import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {Key? key,
      required this.iconPath,
      required this.title,
      required this.onTap})
      : super(key: key);

  final String iconPath;
  final String title;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,
          style: Theme.of(context).textTheme.headlineSmall!
              .copyWith(color: ColorManger.instance.primaryColor)),
      leading: SvgPicture.asset(
        iconPath,
        height: 20,
        width: 20,
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
