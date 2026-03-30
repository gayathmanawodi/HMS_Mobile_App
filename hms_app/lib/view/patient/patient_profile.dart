import 'package:flutter/material.dart';
import 'package:hospitrack/widgets/app_back_button.dart';
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
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/profileadmin.png',
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Text(
                        user?.firstName.substring(0, 1) ?? 'P',
                        style: const TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
        ],
      ),
    );
  }
}
