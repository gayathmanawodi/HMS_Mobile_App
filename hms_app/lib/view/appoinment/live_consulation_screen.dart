import 'package:flutter/material.dart';
import 'package:hospitrack/widgets/app_back_button.dart';
import 'package:hospitrack/app/theme.dart';

class LiveConsultationScreen extends StatelessWidget {
  const LiveConsultationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Live Consultation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                gradient: AppTheme.cardGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.video_call,
                size: 64,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Live Consultation',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Connect with your doctor in real time',
              style: TextStyle(color: AppTheme.textMedium),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              icon: const Icon(Icons.videocam),
              label: const Text('Start Consultation'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
