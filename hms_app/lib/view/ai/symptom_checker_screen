// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hospitrack/widgets/app_back_button.dart';
import 'package:go_router/go_router.dart';
import 'package:hospitrack/app/theme.dart';

class SymptomCheckerScreen extends StatefulWidget {
  const SymptomCheckerScreen({super.key});

  @override
  State<SymptomCheckerScreen> createState() => _SymptomCheckerScreenState();
}

class _SymptomCheckerScreenState extends State<SymptomCheckerScreen> {
  final _ctrl = TextEditingController();
  String? _result;
  String? _specialist;
  String? _urgency;
  bool _loading = false;

  // Rule-based AI simulation
  void _analyze() async {
    if (_ctrl.text.trim().isEmpty) return;
    setState(() {
      _loading = true;
      _result = null;
    });
    await Future.delayed(const Duration(seconds: 1));

    final input = _ctrl.text.toLowerCase();
    String specialist = 'General Physician';
    String urgency = 'Low';
    String result = '';

    if (input.contains('chest') ||
        input.contains('heart') ||
        input.contains('palpitation')) {
      specialist = 'Cardiologist';
      urgency = 'Emergency';
      result =
          'Symptoms suggest possible cardiac issue. Seek immediate medical attention.';
    } else if (input.contains('headache') ||
        input.contains('migraine') ||
        input.contains('seizure')) {
      specialist = 'Neurologist';
      urgency = 'Moderate';
      result =
          'Neurological symptoms detected. Schedule a consultation with a neurologist.';
    } else if (input.contains('skin') ||
        input.contains('rash') ||
        input.contains('itch')) {
      specialist = 'Dermatologist';
      urgency = 'Low';
      result =
          'Skin-related symptoms detected. A dermatologist visit is recommended.';
    } else if (input.contains('fever') ||
        input.contains('cold') ||
        input.contains('flu') ||
        input.contains('cough')) {
      specialist = 'General Physician';
      urgency = 'Low';
      result =
          'Common cold or flu symptoms. Rest, hydration, and OTC medications may help.';
    } else if (input.contains('stomach') ||
        input.contains('vomit') ||
        input.contains('nausea') ||
        input.contains('diarrhea')) {
      specialist = 'Gastroenterologist';
      urgency = 'Moderate';
      result =
          'Digestive system symptoms. Consider seeing a gastroenterologist if persistent.';
    } else if (input.contains('breathe') ||
        input.contains('breath') ||
        input.contains('asthma') ||
        input.contains('lungs')) {
      specialist = 'Pulmonologist';
      urgency = 'Moderate';
      result =
          'Respiratory symptoms detected. Consult a pulmonologist promptly.';
    } else if (input.contains('ear') ||
        input.contains('throat') ||
        input.contains('nose')) {
      specialist = 'ENT Specialist';
      urgency = 'Low';
      result =
          'ENT-related symptoms. Book an appointment with an ENT specialist.';
    } else if (input.contains('eye') ||
        input.contains('vision') ||
        input.contains('blind')) {
      specialist = 'Ophthalmologist';
      urgency = 'Moderate';
      result =
          'Eye-related symptoms. Visit an ophthalmologist for proper evaluation.';
    } else {
      result =
          'Based on your symptoms, we recommend consulting a General Physician for proper diagnosis.';
    }

    setState(() {
      _loading = false;
      _result = result;
      _specialist = specialist;
      _urgency = urgency;
    });
  }

  Color get _urgencyColor {
    switch (_urgency) {
      case 'Emergency':
        return AppTheme.danger;
      case 'Moderate':
        return AppTheme.warning;
      default:
        return AppTheme.success;
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('AI Symptom Checker'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // AI banner
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.purple.shade700, Colors.indigo.shade600]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Icon(Icons.smart_toy, color: Color(0xFFFFE082), size: 32),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('AI Health Assistant',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      Text('Describe your symptoms and we\'ll analyze them',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('Describe Your Symptoms',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 8),
          TextField(
            controller: _ctrl,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText:
                  'e.g. I have severe chest pain and shortness of breath...',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _loading ? null : _analyze,
              icon: _loading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                  : const Icon(Icons.search),
              label: Text(_loading ? 'Analyzing...' : 'Analyze Symptoms'),
            ),
          ),
          if (_result != null) ...[
            const SizedBox(height: 24),
            // Result card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _urgencyColor.withOpacity(0.3)),
                boxShadow: const [
                  BoxShadow(color: Color(0x14000000), blurRadius: 8)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('AI Analysis Result',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _urgencyColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(_urgency!,
                            style: TextStyle(
                                color: _urgencyColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(_result!,
                      style: const TextStyle(
                          color: AppTheme.textMedium, fontSize: 14)),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.medical_services,
                          color: AppTheme.primaryTeal, size: 18),
                      const SizedBox(width: 8),
                      const Text('Suggested Specialist:',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      const Spacer(),
                      Text(_specialist!,
                          style: const TextStyle(
                              color: AppTheme.primaryTeal,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.go('/patient/choose-doctor'),
                      child: Text('Book $_specialist'),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 20),
          const Text('Common Symptoms',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              'Chest pain',
              'Headache',
              'Fever',
              'Cough',
              'Stomach ache',
              'Skin rash',
              'Shortness of breath',
              'Eye pain',
              'Ear pain',
              'Nausea',
            ]
                .map((s) => GestureDetector(
                      onTap: () {
                        _ctrl.text = s;
                        _analyze();
                      },
                      child: Chip(
                        label: Text(
                          s,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.textDark,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        backgroundColor: AppTheme.primaryTeal.withOpacity(0.14),
                        shape: StadiumBorder(
                          side: BorderSide(
                              color: AppTheme.primaryTeal.withOpacity(0.35)),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
