import 'package:flutter/material.dart';
import 'package:hospitrack/widgets/app_back_button.dart';
import 'package:go_router/go_router.dart';
import 'package:hospitrack/app/theme.dart';
import 'package:hospitrack/controllers/auth_controller.dart';
import 'package:hospitrack/widgets/shared_widgets.dart';
import 'package:provider/provider.dart';

class PatientProfile extends StatelessWidget {
  const PatientProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();
    final user = auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Patient Profile'),
        actions: [IconButton(icon: const Icon(Icons.edit), onPressed: () {})],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppTheme.cardGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white24,
                  child: Text(
                    user?.firstName.substring(0, 1) ?? 'P',
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  user?.fullName ?? 'Patient',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Patient ID: P-001',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  InfoTile(
                    icon: Icons.email,
                    label: 'Email',
                    value: user?.email ?? 'N/A',
                  ),
                  const Divider(),
                  InfoTile(
                    icon: Icons.phone,
                    label: 'Phone',
                    value: user?.phone ?? 'N/A',
                  ),
                  const Divider(),
                  const InfoTile(
                    icon: Icons.bloodtype,
                    label: 'Blood Group',
                    value: 'B+',
                  ),
                  const Divider(),
                  const InfoTile(
                    icon: Icons.cake,
                    label: 'Date of Birth',
                    value: 'March 15, 1990',
                  ),
                  const Divider(),
                  const InfoTile(
                    icon: Icons.location_on,
                    label: 'Address',
                    value: 'No. 12, Galle Road, Colombo',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Medical Info',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(height: 8),
                  InfoTile(
                    icon: Icons.warning_amber,
                    label: 'Allergies',
                    value: 'Penicillin',
                  ),
                  Divider(),
                  InfoTile(
                    icon: Icons.history,
                    label: 'Medical History',
                    value: 'Hypertension, Diabetes',
                  ),
                  Divider(),
                  InfoTile(
                    icon: Icons.emergency,
                    label: 'Emergency Contact',
                    value: '+94 71 999 8888',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PatientDetails extends StatelessWidget {
  const PatientDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const PatientProfile();
  }
}

class AppointmentCenter extends StatelessWidget {
  const AppointmentCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Appointment Center'),
      ),
      body: const Center(
        child: Text('Appointment Center - see Appointments screen'),
      ),
    );
  }
}

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
              onPressed: () => context.go('/patient/choose-doctor'),
            ),
          ],
        ),
      ),
    );
  }
}
