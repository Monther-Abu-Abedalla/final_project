import 'package:flutter/material.dart';

class AppSummaryScreen extends StatelessWidget {
  const AppSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نبذة عن التطبيق'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            "",
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }
}
