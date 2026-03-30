// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hospitrack/widgets/app_back_button.dart';
import 'package:go_router/go_router.dart';
import 'package:hospitrack/app/theme.dart';
import 'package:hospitrack/controllers/auth_controller.dart';
import 'package:hospitrack/controllers/theme_controller.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();
    final theme = context.watch<ThemeController>();
    final user = auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Setting'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _SectionCard(
            title: 'Profile',
            subtitle: 'Manage your profile information',
            icon: Icons.person_outline,
            onTap: () {
              final role = user?.role.name ?? 'patient';
              if (role == 'admin') {
                context.go('/admin/profile');
              } else if (role == 'doctor') {
                context.go('/doctor/profile');
              } else if (role == 'receptionist') {
                context.go('/reception/profile');
              } else {
                context.go('/patient/profile');
              }
            },
          ),
          _SectionCard(
            title: 'Change Password',
            subtitle: 'Update your password',
            icon: Icons.lock_outline,
            onTap: () => context.go('/change-password'),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryTeal.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.dark_mode,
                      color: AppTheme.primaryTeal,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dark Mode',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Choose dark mode',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.textMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: theme.isDarkMode,
                    onChanged: theme.setDarkMode,
                    activeColor: AppTheme.primaryTeal,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.info.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.language, color: AppTheme.info),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Language',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  DropdownButton<String>(
                    value: _language,
                    underline: const SizedBox(),
                    items: ['English', 'Sinhala', 'Tamil']
                        .map((l) => DropdownMenuItem(value: l, child: Text(l)))
                        .toList(),
                    onChanged: (v) => setState(() => _language = v!),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.logout),
            label: const Text('Log Out'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.danger,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              auth.logout();
              context.go('/login');
            },
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryTeal.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppTheme.primaryTeal),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.chevron_right, color: AppTheme.textLight),
        onTap: onTap,
      ),
    );
  }
}
