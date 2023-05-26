import 'package:consulting_app/feature/view/screens/home/widgets/custom_loading.dart';
import 'package:consulting_app/feature/view_model/home_view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<HomeViewModel>(context , listen: false).getPrivacy();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سياسة الخصوصية'),
      ),
      body: Consumer<HomeViewModel>(
        builder: (_, home, __) {
          if (home.isLoading) {
            return const CustomLoading();
          } else if (GetUtils.isNull(home.privacyPolicy) ||
              home.privacyPolicy.trim().isEmpty) {
            return const SizedBox();
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: HtmlWidget(
                  home.privacyPolicy,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
