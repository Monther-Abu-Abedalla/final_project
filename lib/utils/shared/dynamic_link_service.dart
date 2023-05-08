import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:logger/logger.dart';

class DynamicLinkService {
  Future<void> retrieveDynamicLink(BuildContext context) async {
    try {
      final PendingDynamicLinkData? data =
          await FirebaseDynamicLinks.instance.getInitialLink();

      FirebaseDynamicLinks.instance.onLink.listen((event) {
        Logger().e("MSG_LISTEN_DATA ${data?.link}");
        Logger().e("MSG_LISTEN ${event.link.toString()}");
        Logger().e("MSG_PARAMETER ${event.utmParameters}");
        Logger().e("MSG_PARAMETER ${event.link.queryParameters}");
      });
    } catch (e) {
      print(e.toString());
    }
  }

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  final String dynamicLink = '1';
// "https://ex.amp.le/?link=https://example.com/my-resource"
  // Future<void> createDynamicLink({required String title}) async {
  //   final DynamicLinkParameters parameters = DynamicLinkParameters(
  //     uriPrefix:
  //         'https://consuliting.page.link/Tbeh/?link=https://example.com/my-resource',
  //     link: Uri.parse(dynamicLink),
  //     androidParameters: const AndroidParameters(
  //       packageName: 'com.consulting.app',
  //       minimumVersion: 19,
  //     ),
  //     navigationInfoParameters:
  //         const NavigationInfoParameters(forcedRedirectEnabled: true),
  //   );

  //   Uri url = await dynamicLinks.buildLink(parameters);
  //   Logger().e(url);
  //   share(title: "مشاركة استشارة", text: title, urlLink: url.toString());
  // }

  Future<void> createDynamicLink({required String title}) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://consuliting.page.link/Tbeh',
      link: Uri.parse('https://www.compound.com/post?title=$title'),
      androidParameters: const AndroidParameters(
        packageName: 'com.consulting.app',
      ),
      googleAnalyticsParameters: const GoogleAnalyticsParameters(
        campaign: 'example-promo',
        medium: 'social',
        source: 'orkut',
      ),
      socialMetaTagParameters: const SocialMetaTagParameters(
        title: 'Example of a Dynamic Link',
        description: 'This link works whether app is installed or not!',
      ),
    );
    Uri url = await dynamicLinks.buildLink(parameters);
    share(title: "مشاركة استشارة", text: title, urlLink: url.toString());
  }

  Future<void> share(
      {required String title,
      required String text,
      required String urlLink}) async {
    await FlutterShare.share(title: title, text: text, linkUrl: urlLink);
  }
}
