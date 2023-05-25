import 'package:cached_network_image/cached_network_image.dart';
import 'package:consulting_app/utils/constance/constance.dart';
import 'package:flutter/material.dart';

class CustomImageNetwork extends StatelessWidget {
  const CustomImageNetwork({ Key? key  , this.url , this.height , this.width}) : super(key: key);

  final String? url;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
  
  return CachedNetworkImage(
    imageBuilder: (context, imageProvider) {
      return Container(
        decoration: BoxDecoration(
          // border: Border.all(color: colorBorderLight),
          image: DecorationImage(
            image: CachedNetworkImageProvider(url ?? Constance.instance.imagePlaceHolder),
            fit: BoxFit.contain,
          ),
        ),
      );
    },
    imageUrl: Constance.instance.imagePlaceHolder,
    errorWidget: (context, url, error) {
      return CachedNetworkImage(
          imageUrl: Constance.instance.imagePlaceHolder, fit: BoxFit.contain);
    },
    width: width ?? 50,
    height: height ?? 50,
    fit: BoxFit.cover,
    placeholder: (context, String? url) {
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/gifs/loading_shimmer.gif") /* CachedNetworkImageProvider(url ?? urlUserPlacholder!)*/,
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              )),
        ),
      );
    },
  );
}
}