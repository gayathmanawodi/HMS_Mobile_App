// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hospitrack/widgets/app_back_button.dart';
import 'package:hospitrack/app/constants.dart';
import 'package:hospitrack/app/theme.dart';
import 'package:hospitrack/controllers/token_controller.dart';
import 'package:hospitrack/controllers/patient_controller.dart';
import 'package:hospitrack/models/token_model.dart';
import 'package:provider/provider.dart';

class GenerateTokenScreen extends StatefulWidget {
  const GenerateTokenScreen({super.key});

  @override
  State<GenerateTokenScreen> createState() => _GenerateTokenScreenState();
}

class _GenerateTokenScreenState extends State<GenerateTokenScreen> {
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  String _department = 'General OPD';
  String? _selectedPatientId;
  TokenModel? _generatedToken;
  bool _isNew = true;

  final departments = [
    'General OPD',
    'Cardiology',
    'ENT',
    'Dermatology',
    'Pediatrics',
    'Neurology',
    'Emergency',
  ];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _generate() {
    if (_nameCtrl.text.isEmpty || _phoneCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter patient name and phone')),
      );
      return;
    }
    final tok = context.read<TokenController>().generateToken(
      patientId: _selectedPatientId ?? 'walk-in',
      patientName: _nameCtrl.text.trim(),
      patientPhone: _phoneCtrl.text.trim(),
      department: _department,
    );
    setState(() => _generatedToken = tok);
  }

  @override
  Widget build(BuildContext context) {
    final patients = context.watch<PatientController>().all;

    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Generate Token'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Walk-in or existing patient
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() {
                    _isNew = true;
                    _selectedPatientId = null;
                  }),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: _isNew ? AppTheme.primaryTeal : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.primaryTeal),
                    ),
                    child: Text(
                      'Walk-in Patient',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _isNew ? Colors.white : AppTheme.primaryTeal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _isNew = false),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: !_isNew ? AppTheme.primaryTeal : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.primaryTeal),
                    ),
                    child: Text(
                      'Existing Patient',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: !_isNew ? Colors.white : AppTheme.primaryTeal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (!_isNew) ...[
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Select Patient'),
              items: patients
                  .map(
                    (p) => DropdownMenuItem(value: p.id, child: Text(p.name)),
                  )
                  .toList(),
              onChanged: (v) {
                setState(() => _selectedPatientId = v);
                final p = patients.firstWhere((p) => p.id == v);
                _nameCtrl.text = p.name;
                _phoneCtrl.text = p.phone;
              },
            ),
            const SizedBox(height: 12),
          ],
          TextField(
            controller: _nameCtrl,
            decoration: const InputDecoration(
              labelText: 'Patient Name',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _phoneCtrl,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              prefixIcon: Icon(Icons.phone),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _department,
            decoration: const InputDecoration(labelText: 'Department'),
            items: departments
                .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                .toList(),
            onChanged: (v) => setState(() => _department = v!),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            icon: const Icon(Icons.confirmation_number),
            label: const Text('Generate Token'),
            onPressed: _generate,
          ),
          if (_generatedToken != null) ...[
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: AppTheme.cardGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text(
                    'Token Generated!',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_generatedToken!.tokenNumber}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _generatedToken!.department,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _generatedToken!.patientName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () => setState(() => _generatedToken = null),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                    ),
                    child: const Text('Generate Another'),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class ActiveTokenScreen extends StatelessWidget {
  const ActiveTokenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<TokenController>();
    final active = ctrl.active;

    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Active Tokens'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ctrl.serveNext,
        backgroundColor: AppTheme.primaryTeal,
        icon: const Icon(Icons.skip_next, color: Colors.white),
        label: const Text('Serve Next', style: TextStyle(color: Colors.white)),
      ),
      body: active.isEmpty
          ? const Center(
              child: Text(
                'No active tokens',
                style: TextStyle(color: AppTheme.textMedium),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: active.length,
              itemBuilder: (_, i) {
                final t = active[i];
                final isServing = t.status == TokenStatus.serving;
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isServing
                          ? AppTheme.primaryTeal
                          : AppTheme.divider,
                      width: isServing ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: isServing ? AppTheme.cardGradient : null,
                          color: isServing ? null : AppTheme.backgroundLight,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${t.tokenNumber}',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: isServing
                                  ? Colors.white
                                  : AppTheme.textDark,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.patientName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              t.department,
                              style: const TextStyle(
                                color: AppTheme.textMedium,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              t.patientPhone,
                              style: const TextStyle(
                                color: AppTheme.textLight,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isServing
                              ? AppTheme.success.withOpacity(0.12)
                              : AppTheme.warning.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          isServing ? 'SERVING' : 'WAITING',
                          style: TextStyle(
                            color: isServing
                                ? AppTheme.success
                                : AppTheme.warning,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
