import 'package:flutter/material.dart';
import 'package:hospitrack/widgets/app_back_button.dart';

class PrescriptionDetailsScreen extends StatelessWidget {
  final String prescriptionId;
  const PrescriptionDetailsScreen({super.key, required this.prescriptionId});

  @override
  Widget build(BuildContext context) {
    // This is handled within prescription_screen.dart
    // Redirect to that implementation
    return const PrescriptionDetailView();
  }
}

class PrescriptionDetailView extends StatelessWidget {
  const PrescriptionDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Prescription Details'),
      ),
      body: const Center(child: Text('View prescription details')),
    );
  }
}
