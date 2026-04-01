// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hospitrack/widgets/app_back_button.dart';
import 'package:hospitrack/app/constants.dart';
import 'package:hospitrack/app/theme.dart';

class HealthGuidanceScreen extends StatefulWidget {
  const HealthGuidanceScreen({super.key});

  @override
  State<HealthGuidanceScreen> createState() => _HealthGuidanceScreenState();
}

class _HealthGuidanceScreenState extends State<HealthGuidanceScreen> {
  String? _selected;

  static const Map<String, Map<String, dynamic>> _guidance = {
    'Cold & Flu': {
      'medicines': ['Paracetamol 500mg', 'Cetirizine 10mg', 'Vitamin C 500mg'],
      'remedies': [
        'Drink warm liquids (ginger tea/broth)',
        'Rest for at least 8 hours',
        'Steam inhalation',
        'Honey + lemon in warm water'
      ],
      'warning':
          'If fever exceeds 39°C or symptoms persist beyond 5 days, see a doctor.',
    },
    'Headache / Migraine': {
      'medicines': ['Ibuprofen 400mg', 'Paracetamol 500mg', 'Aspirin 325mg'],
      'remedies': [
        'Rest in a dark, quiet room',
        'Apply cold compress to forehead',
        'Stay hydrated',
        'Gentle neck massage'
      ],
      'warning':
          'Sudden severe headache or headache with fever/stiff neck requires emergency care.',
    },
    'Fever': {
      'medicines': ['Paracetamol 500mg every 6 hours', 'Ibuprofen 400mg'],
      'remedies': [
        'Stay hydrated with oral rehydration solution',
        'Cool compress to forehead',
        'Dress lightly',
        'Rest completely'
      ],
      'warning':
          'Fever above 39.5°C or lasting more than 3 days – seek medical help.',
    },
    'Stomach Ache': {
      'medicines': ['Antacid (Ranitidine)', 'ORS sachets', 'Probiotics'],
      'remedies': [
        'BRAT diet (Banana, Rice, Applesauce, Toast)',
        'Ginger tea',
        'Avoid spicy/fatty food',
        'Rest'
      ],
      'warning':
          'Severe abdominal pain, vomiting blood, or pain lasting > 24 hours – see a doctor.',
    },
    'Back Pain': {
      'medicines': [
        'Ibuprofen 400mg',
        'Diclofenac gel (topical)',
        'Muscle relaxant (if prescribed)'
      ],
      'remedies': [
        'Apply ice or heat pack',
        'Gentle stretching exercises',
        'Maintain good posture',
        'Sleep on firm mattress'
      ],
      'warning':
          'If pain radiates to legs or causes weakness/numbness, seek medical attention.',
    },
    'Allergies': {
      'medicines': ['Cetirizine 10mg', 'Loratadine 10mg', 'Nasal saline spray'],
      'remedies': [
        'Identify and avoid allergen triggers',
        'Keep windows closed during pollen season',
        'Use air purifier'
      ],
      'warning':
          'Severe allergic reaction (swelling, difficulty breathing) – Emergency care immediately.',
    },
    'Insomnia': {
      'medicines': [
        'Melatonin 3-5mg (before bed)',
        'Antihistamine (short term only)'
      ],
      'remedies': [
        'Maintain consistent sleep schedule',
        'Avoid screens 1 hour before bed',
        'Warm milk or chamomile tea',
        'Relaxation techniques'
      ],
      'warning':
          'Chronic insomnia (> 3 weeks) should be evaluated by a doctor.',
    },
    'Skin Rash': {
      'medicines': [
        'Hydrocortisone cream 1%',
        'Antihistamine (Cetirizine)',
        'Calamine lotion'
      ],
      'remedies': [
        'Avoid scratching',
        'Cool compress on affected area',
        'Wear loose, breathable clothing',
        'Avoid known irritants'
      ],
      'warning':
          'Rash spreading rapidly, with fever, or difficulty breathing – Emergency care.',
    },
    'Anxiety': {
      'medicines': ['Consult doctor before any medication'],
      'remedies': [
        'Deep breathing exercises (4-7-8 technique)',
        'Progressive muscle relaxation',
        'Regular physical exercise',
        'Limit caffeine and alcohol'
      ],
      'warning':
          'Persistent anxiety or panic attacks should be evaluated by a mental health professional.',
    },
    'Fatigue': {
      'medicines': [
        'Vitamin B complex',
        'Iron supplement (if deficient)',
        'Vitamin D3'
      ],
      'remedies': [
        'Maintain regular sleep schedule',
        'Balanced diet rich in iron and vitamins',
        'Light aerobic exercise',
        'Stay well hydrated'
      ],
      'warning':
          'Extreme fatigue with unexplained weight loss or fever requires medical evaluation.',
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const AppBackButton(),
          title: const Text('Minor Health Guidance')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select Your Condition',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: AppConstants.commonConditions.map((c) {
                    final isSelected = c == _selected;
                    return GestureDetector(
                      onTap: () => setState(() => _selected = c),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color:
                              isSelected ? AppTheme.primaryTeal : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: isSelected
                                  ? AppTheme.primaryTeal
                                  : AppTheme.divider),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                      color:
                                          AppTheme.primaryTeal.withOpacity(0.3),
                                      blurRadius: 8)
                                ]
                              : [],
                        ),
                        child: Text(c,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected
                                  ? Colors.white
                                  : AppTheme.textMedium,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            )),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          if (_selected != null)
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _GuidanceSection(
                    title: '💊 Recommended OTC Medicines',
                    items:
                        List<String>.from(_guidance[_selected]!['medicines']),
                    color: AppTheme.primaryTeal,
                  ),
                  const SizedBox(height: 12),
                  _GuidanceSection(
                    title: '🏠 Home Remedies',
                    items: List<String>.from(_guidance[_selected]!['remedies']),
                    color: AppTheme.accentGreen,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppTheme.danger.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                      border:
                          Border.all(color: AppTheme.danger.withOpacity(0.3)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.warning_amber,
                            color: AppTheme.danger, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _guidance[_selected]!['warning'] as String,
                            style: const TextStyle(
                                color: AppTheme.danger, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          else
            const Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.health_and_safety,
                        size: 64, color: AppTheme.textLight),
                    SizedBox(height: 12),
                    Text('Select a condition to see guidance',
                        style: TextStyle(color: AppTheme.textMedium)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _GuidanceSection extends StatelessWidget {
  final String title;
  final List<String> items;
  final Color color;

  const _GuidanceSection(
      {required this.title, required this.items, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: color, fontSize: 14)),
          const SizedBox(height: 8),
          ...items
              .map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.circle, size: 6, color: color),
                        const SizedBox(width: 8),
                        Expanded(
                            child: Text(item,
                                style: const TextStyle(
                                    fontSize: 13, color: AppTheme.textMedium))),
                      ],
                    ),
                  ))
              // ignore: unnecessary_to_list_in_spreads
              .toList(),
        ],
      ),
    );
  }
}
