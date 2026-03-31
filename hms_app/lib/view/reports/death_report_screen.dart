import 'package:flutter/material.dart';
import 'package:hospitrack/widgets/app_back_button.dart';

class DeathReportScreen extends StatelessWidget {
  const DeathReportScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const AppBackButton(), title: const Text('Death Report')),
      body: const Center(child: Text('Death reports - see Reports screen')),
    );
  }
}
