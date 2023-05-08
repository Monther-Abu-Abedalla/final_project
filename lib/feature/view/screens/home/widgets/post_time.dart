import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/date/date_time_util.dart';

class PostTime extends StatelessWidget {
  const PostTime({Key? key, required this.endDateTime}) : super(key: key);

  final num endDateTime;
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 0));
    return Container(
        width: double.infinity,
        height: 40,
        color: ColorManger.instance.opcityPrimaryColor.withOpacity(0.2),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            Text(
              'الوقت المتبقي : ',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TweenAnimationBuilder(
                duration: DateUtility().getDifference(
                    endDate: DateTime.fromMillisecondsSinceEpoch(
                        endDateTime.toInt())),
                tween: Tween(
                  begin: DateUtility().getDifference(
                      endDate: DateTime.fromMillisecondsSinceEpoch(
                          endDateTime.toInt())),
                  end: Duration.zero,
                ),
                onEnd: () {},
                builder: (BuildContext context, Duration value, Widget? child) {
                  final int minutes = value.inMinutes;
                  final int seconds = (value.inSeconds % 60);
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text('$minutes:$seconds',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge));
                }),
            const Spacer(),
            InkWell(
              onTap: () {},
              child: Text(
                'تمديد الوقت ؟',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      decoration: TextDecoration.underline,
                    ),
              ),
            ),
            const SizedBox(
              width: 16,
            )
          ],
        ));
  }
}
