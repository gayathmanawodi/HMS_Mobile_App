// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hospitrack/app/theme.dart';
import 'package:hospitrack/controllers/appointment_controller.dart';
import 'package:hospitrack/controllers/doctor_controller.dart';
import 'package:hospitrack/controllers/patient_controller.dart';
import 'package:hospitrack/services/mock_data_service.dart';
import 'package:hospitrack/widgets/app_drawer.dart';
import 'package:hospitrack/widgets/shared_widgets.dart';
import 'package:provider/provider.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final doctors = context.watch<DoctorController>().all;
    final patients = context.watch<PatientController>().all;
    final appts = context.watch<AppointmentController>();
    final db = MockDataService();

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
            tooltip: 'Menu',
          ),
        ),
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.go('/patient/notifications'),
          ),
        ],
      ),
      drawer: const AppDrawer(currentRoute: '/admin/dashboard'),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          /// Welcome Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppTheme.cardGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.admin_panel_settings, color: Colors.white, size: 40),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hospital Admin',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                      Text(
                        'HospiTrack Medical',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'Manage doctors, patients & operations',
                        style: TextStyle(color: Colors.white60, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(),

          const SizedBox(height: 20),

          /// Stats Grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,

            // FIXED (height eka wadi kala)
            childAspectRatio: 1.1,

            children: [
              StatCard(
                title: 'Total Doctors',
                value: '${doctors.length}',
                icon: Icons.medical_services,
                color: AppTheme.primaryTeal,
                onTap: () => context.go('/admin/doctors'),
              ).animate().fadeIn(delay: 100.ms),
              StatCard(
                title: 'Total Patients',
                value: '${patients.length}',
                icon: Icons.people,
                color: AppTheme.info,
                onTap: () => context.go('/admin/patients'),
              ).animate().fadeIn(delay: 200.ms),
              StatCard(
                title: 'Appointments',
                value: '${appts.all.length}',
                icon: Icons.calendar_today,
                color: AppTheme.accentGreen,
                onTap: () => context.go('/patient/appointments'),
              ).animate().fadeIn(delay: 300.ms),
              StatCard(
                title: 'Available Beds',
                value: '${db.getAvailableBeds().length}',
                icon: Icons.bed,
                color: AppTheme.warning,
                onTap: () => context.go('/billing/bed-details'),
              ).animate().fadeIn(delay: 400.ms),
            ],
          ),

          const SizedBox(height: 20),

          /// Management Section
          const Text(
            'Management',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          _ManageCard(
            icon: Icons.person_add,
            title: 'Add New Doctor',
            subtitle: 'Register a new doctor to the system',
            color: AppTheme.primaryTeal,
            onTap: () => context.push('/admin/add-doctor'),
          ),

          _ManageCard(
            icon: Icons.person_add_alt_1,
            title: 'Add New Patient',
            subtitle: 'Register a new patient',
            color: AppTheme.info,
            onTap: () => context.push('/admin/add-patient'),
          ),

          _ManageCard(
            icon: Icons.manage_accounts,
            title: 'Doctor Management',
            subtitle: 'View, edit, or remove doctors',
            color: AppTheme.accentGreen,
            onTap: () => context.go('/admin/doctors'),
          ),

          _ManageCard(
            icon: Icons.people_outline,
            title: 'Patient Management',
            subtitle: 'Manage all patient records',
            color: AppTheme.warning,
            onTap: () => context.go('/admin/patients'),
          ),
        ],
      ),
    );
  }
}

class _ManageCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ManageCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.chevron_right, color: AppTheme.textLight),
        onTap: onTap,
      ),
    );
  }
}
