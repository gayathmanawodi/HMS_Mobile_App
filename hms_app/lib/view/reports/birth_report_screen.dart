import 'package:flutter/material.dart';
import 'package:hospitrack/widgets/app_back_button.dart';

class BirthReportScreen extends StatelessWidget {
  const BirthReportScreen({super.key});
  @override
  Widget build(BuildContext context) => const _ReportBirthView();
}

class _ReportBirthView extends StatelessWidget {
  const _ReportBirthView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const AppBackButton(), title: const Text('Birth Report')),
      body: const Center(child: Text('Birth reports - see Reports screen')),
    );
  }
}
