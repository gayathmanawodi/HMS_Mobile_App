import 'package:flutter/material.dart';
import 'package:hospitrack/widgets/app_back_button.dart';
import 'package:hospitrack/app/theme.dart';

class HealthRiskScreen extends StatefulWidget {
  const HealthRiskScreen({super.key});

  @override
  State<HealthRiskScreen> createState() => _HealthRiskScreenState();
}

class _HealthRiskScreenState extends State<HealthRiskScreen> {
  final _formKey = GlobalKey<FormState>();
  // ignore: unused_field
  double? _age, _weight, _height, _systolicBP, _diastolicBP;
  bool _smoker = false, _diabetic = false, _familyHistory = false;
  Map<String, Map<String, dynamic>>? _risks;

  void _predict() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    final bmi = _weight! / ((_height! / 100) * (_height! / 100));
    final risks = <String, Map<String, dynamic>>{};

    // Diabetes risk
    int diabetesScore = 0;
    if (bmi > 30) diabetesScore += 2;
    if (bmi > 25) diabetesScore += 1;
    if (_age! > 45) diabetesScore += 2;
    if (_familyHistory) diabetesScore += 2;
    if (_diabetic) diabetesScore += 3;
    risks['Diabetes'] = _riskLevel(diabetesScore, 8);

    // Hypertension risk
    int bpScore = 0;
    if ((_systolicBP ?? 120) > 140) {
      bpScore += 3;
      // ignore: curly_braces_in_flow_control_structures
    } else if ((_systolicBP ?? 120) > 130) bpScore += 2;
    if (_age! > 50) bpScore += 1;
    if (_smoker) bpScore += 2;
    if (_familyHistory) bpScore += 1;
    risks['Hypertension'] = _riskLevel(bpScore, 6);

    // Heart disease risk
    int heartScore = 0;
    if (_smoker) heartScore += 3;
    if (bmi > 30) heartScore += 2;
    if ((_systolicBP ?? 120) > 140) heartScore += 2;
    if (_age! > 50) heartScore += 2;
    if (_familyHistory) heartScore += 2;
    risks['Heart Disease'] = _riskLevel(heartScore, 9);

    // Obesity
    int obesityScore = 0;
    if (bmi > 30) {
      obesityScore = 5;
    } else if (bmi > 25)
      // ignore: curly_braces_in_flow_control_structures
      obesityScore = 3;
    else
      // ignore: curly_braces_in_flow_control_structures
      obesityScore = 1;
    risks['Obesity'] = _riskLevel(obesityScore, 5);

    setState(() {
      _risks = risks;
    });
  }

  Map<String, dynamic> _riskLevel(int score, int max) {
    final pct = (score / max).clamp(0.0, 1.0);
    String level;
    Color color;
    if (pct < 0.33) {
      level = 'Low';
      color = AppTheme.success;
    } else if (pct < 0.66) {
      level = 'Moderate';
      color = AppTheme.warning;
    } else {
      level = 'High';
      color = AppTheme.danger;
    }
    return {'percent': pct, 'level': level, 'color': color};
  }

  Widget _field(String label, Function(double?) onSave, {String? suffix}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label, suffixText: suffix),
      validator: (v) => v!.isEmpty ? 'Required' : null,
      onSaved: (v) => onSave(double.tryParse(v!)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const AppBackButton(),
          title: const Text('Health Risk Prediction')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.teal.shade600, Colors.teal.shade400]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Icon(Icons.monitor_heart, color: Colors.white, size: 32),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Health Risk Analyzer',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      Text('Enter your vitals to predict health risks',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: _field('Age', (v) => _age = v, suffix: 'yrs')),
                    const SizedBox(width: 12),
                    Expanded(
                        child:
                            _field('Weight', (v) => _weight = v, suffix: 'kg')),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                        child:
                            _field('Height', (v) => _height = v, suffix: 'cm')),
                    const SizedBox(width: 12),
                    Expanded(
                        child: _field('Systolic BP', (v) => _systolicBP = v,
                            suffix: 'mmHg')),
                  ],
                ),
                const SizedBox(height: 12),
                _field('Diastolic BP', (v) => _diastolicBP = v, suffix: 'mmHg'),
                const SizedBox(height: 8),
                SwitchListTile(
                  title: const Text('Smoker', style: TextStyle(fontSize: 14)),
                  value: _smoker,
                  onChanged: (v) => setState(() => _smoker = v),
                  activeThumbColor: AppTheme.primaryTeal,
                ),
                SwitchListTile(
                  title: const Text('Diabetic', style: TextStyle(fontSize: 14)),
                  value: _diabetic,
                  onChanged: (v) => setState(() => _diabetic = v),
                  activeThumbColor: AppTheme.primaryTeal,
                ),
                SwitchListTile(
                  title: const Text('Family History of Heart Disease',
                      style: TextStyle(fontSize: 14)),
                  value: _familyHistory,
                  onChanged: (v) => setState(() => _familyHistory = v),
                  activeThumbColor: AppTheme.primaryTeal,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.analytics),
                    label: const Text('Analyze Health Risk'),
                    onPressed: _predict,
                  ),
                ),
              ],
            ),
          ),
          if (_risks != null) ...[
            const SizedBox(height: 24),
            const Text('Risk Analysis Results',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            ..._risks!.entries.map((e) => _RiskBar(
                  condition: e.key,
                  percent: e.value['percent'] as double,
                  level: e.value['level'] as String,
                  color: e.value['color'] as Color,
                )),
          ],
        ],
      ),
    );
  }
}

class _RiskBar extends StatelessWidget {
  final String condition;
  final double percent;
  final String level;
  final Color color;

  const _RiskBar(
      {required this.condition,
      required this.percent,
      required this.level,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(condition,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(level,
                    style: TextStyle(
                        color: color,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: percent,
              // ignore: deprecated_member_use
              backgroundColor: color.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 4),
          Text('Risk Level: ${(percent * 100).toInt()}%',
              style: const TextStyle(fontSize: 11, color: AppTheme.textLight)),
        ],
      ),
    );
  }
}
