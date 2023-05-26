import 'package:consulting_app/feature/view/screens/home/widgets/custom_loading.dart';
import 'package:consulting_app/feature/view_model/home_view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AppSummaryScreen extends StatefulWidget {
  const AppSummaryScreen({Key? key}) : super(key: key);

  @override
  State<AppSummaryScreen> createState() => _AppSummaryScreenState();
}

class _AppSummaryScreenState extends State<AppSummaryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<HomeViewModel>(context, listen: false).getAppSummary();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نبذة عن التطبيق'),
      ),
      body: Consumer<HomeViewModel>(
        builder: (_, home, __) {
          if (home.isLoading) {
            return const CustomLoading();
          } else if (GetUtils.isNull(home.appSummary) ||
              home.appSummary.trim().isEmpty) {
            return const SizedBox();
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  home.appSummary,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.start,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
