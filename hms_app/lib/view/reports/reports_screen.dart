import 'package:flutter/material.dart';
import 'package:hospitrack/widgets/app_back_button.dart';
import 'package:go_router/go_router.dart';
import 'package:hospitrack/app/theme.dart';
import 'package:hospitrack/models/report_model.dart';
import 'package:hospitrack/services/mock_data_service.dart';
import 'package:intl/intl.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reports = MockDataService().reports;
    return Scaffold(
      appBar: AppBar(
          leading: const AppBackButton(), title: const Text('Medical Reports')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryTeal,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                _QuickBtn('Investigation', Icons.science, AppTheme.primaryTeal,
                    () => context.go('/doctor/reports/investigation')),
                const SizedBox(width: 8),
                _QuickBtn('Birth', Icons.child_care, AppTheme.accentGreen,
                    () => context.go('/doctor/reports/birth')),
                const SizedBox(width: 8),
                _QuickBtn('Death', Icons.local_hospital, AppTheme.danger,
                    () => context.go('/doctor/reports/death')),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: reports.length,
              itemBuilder: (_, i) {
                final r = reports[i];
                final color = r.type == ReportType.investigation
                    ? AppTheme.primaryTeal
                    : r.type == ReportType.birth
                        ? AppTheme.accentGreen
                        : AppTheme.danger;
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        r.type == ReportType.investigation
                            ? Icons.science
                            : r.type == ReportType.birth
                                ? Icons.child_care
                                : Icons.local_hospital,
                        color: color,
                      ),
                    ),
                    title: Text(r.title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        '${r.patientName} · ${DateFormat('MMM d, yyyy').format(r.createdAt)}',
                        style: const TextStyle(fontSize: 12)),
                    trailing: Chip(
                      label: Text(r.type.name,
                          style: const TextStyle(fontSize: 10)),
                      // ignore: deprecated_member_use
                      backgroundColor: color.withOpacity(0.1),
                      labelStyle: TextStyle(color: color),
                    ),
                    onTap: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _QuickBtn(this.label, this.icon, this.color, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(height: 4),
              Text(label,
                  style: TextStyle(
                      color: color, fontSize: 11, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

class InvestigationReportScreen extends StatefulWidget {
  const InvestigationReportScreen({super.key});

  @override
  State<InvestigationReportScreen> createState() =>
      _InvestigationReportScreenState();
}

class _InvestigationReportScreenState extends State<InvestigationReportScreen> {
  final _db = MockDataService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const AppBackButton(),
          title: const Text('Investigation Reports')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: _db.reports
            .where((r) => r.type == ReportType.investigation)
            .map(
              (r) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(r.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(r.patientName,
                          style: const TextStyle(color: AppTheme.textMedium)),
                      const SizedBox(height: 12),
                      ...r.fields.entries.map((e) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(e.key,
                                    style: const TextStyle(
                                        color: AppTheme.textMedium,
                                        fontSize: 13)),
                                Text(e.value,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13)),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class BirthReportScreen extends StatefulWidget {
  const BirthReportScreen({super.key});

  @override
  State<BirthReportScreen> createState() => _BirthReportScreenState();
}

class _BirthReportScreenState extends State<BirthReportScreen> {
  final _babyName = TextEditingController();
  final _weight = TextEditingController();
  final _mother = TextEditingController();

  @override
  void dispose() {
    _babyName.dispose();
    _weight.dispose();
    _mother.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final births = MockDataService()
        .reports
        .where((r) => r.type == ReportType.birth)
        .toList();
    return Scaffold(
      appBar: AppBar(
          leading: const AppBackButton(), title: const Text('Birth Reports')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Existing Records',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          ...births.map((r) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.child_care,
                              color: AppTheme.accentGreen),
                          const SizedBox(width: 8),
                          Text(r.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ...r.fields.entries.map((e) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(e.key,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.textMedium)),
                              Text(e.value,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500)),
                            ],
                          )),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class DeathReportScreen extends StatelessWidget {
  const DeathReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const AppBackButton(), title: const Text('Death Reports')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.note_add, size: 64, color: AppTheme.textLight),
            SizedBox(height: 12),
            Text('No death reports recorded',
                style: TextStyle(color: AppTheme.textMedium)),
          ],
        ),
      ),
    );
  }
}
