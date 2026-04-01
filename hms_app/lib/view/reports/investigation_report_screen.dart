import 'package:flutter/material.dart';
import 'package:hospitrack/widgets/app_back_button.dart';

class InvestigationReportScreen extends StatelessWidget {
  const InvestigationReportScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const AppBackButton(),
          title: const Text('Investigation Report')),
      body: const Center(
          child: Text('Investigation reports - see Reports screen')),
    );
  }
}
