// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hospitrack/app/theme.dart';
import 'package:hospitrack/controllers/appointment_controller.dart';
import 'package:hospitrack/controllers/auth_controller.dart';
import 'package:hospitrack/controllers/patient_controller.dart';
import 'package:hospitrack/services/mock_data_service.dart';
import 'package:hospitrack/widgets/app_drawer.dart';
import 'package:hospitrack/widgets/shared_widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DoctorDashboard extends StatelessWidget {
  const DoctorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<AuthController>();
    final apptCtrl = context.watch<AppointmentController>();
    final patCtrl = context.watch<PatientController>();
    final db = MockDataService();
    final today = apptCtrl.todayAppointments;

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
            tooltip: 'Menu',
          ),
        ),
        title: const Text('Doctor Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.go('/patient/notifications'),
          ),
        ],
      ),
      drawer: const AppDrawer(currentRoute: '/doctor/dashboard'),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          // Stats Grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.1,
            children: [
              StatCard(
                title: 'Today Appts',
                value: '${today.length}',
                icon: Icons.calendar_today,
                color: AppTheme.primaryTeal,
                onTap: () => context.go('/doctor/appointments'),
              ).animate().fadeIn(delay: 100.ms),
              StatCard(
                title: 'My Patients',
                value: '${patCtrl.all.length}',
                icon: Icons.people,
                color: AppTheme.info,
                onTap: () => context.go('/admin/patients'),
              ).animate().fadeIn(delay: 200.ms),
              StatCard(
                title: 'Pending Reports',
                value: '${db.reports.length}',
                icon: Icons.folder_open,
                color: AppTheme.warning,
                onTap: () => context.go('/doctor/reports'),
              ).animate().fadeIn(delay: 300.ms),
              StatCard(
                title: 'Notifications',
                value: '4',
                icon: Icons.notifications,
                color: AppTheme.accentGreen,
                onTap: () => context.go('/patient/notifications'),
              ).animate().fadeIn(delay: 400.ms),
            ],
          ),
          const SizedBox(height: 20),
          // Quick Actions
          const Text(
            'Quick Actions',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _QuickAction(
                label: 'View Appts',
                icon: Icons.calendar_month,
                color: AppTheme.primaryTeal,
                onTap: () => context.go('/doctor/appointments'),
              ),
              const SizedBox(width: 10),
              _QuickAction(
                label: 'AI Summary',
                icon: Icons.smart_toy,
                color: AppTheme.info,
                onTap: () => context.go('/ai/symptom-checker'),
              ),
              const SizedBox(width: 10),
              _QuickAction(
                label: 'Diagnosis',
                icon: Icons.medical_information,
                color: AppTheme.warning,
                onTap: () => context.go('/doctor/diagnosis'),
              ),
              const SizedBox(width: 10),
              _QuickAction(
                label: 'Prescription',
                icon: Icons.description,
                color: AppTheme.accentGreen,
                onTap: () => context.go('/doctor/prescriptions'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Upcoming Appointments
          SectionHeader(
            title: 'Upcoming Appointments',
            actionLabel: 'See all',
            onAction: () => context.go('/doctor/appointments'),
          ),
          const SizedBox(height: 8),
          if (today.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'No appointments today',
                  style: TextStyle(color: AppTheme.textLight),
                ),
              ),
            )
          else
            ...today
                .take(3)
                .map(
                  (a) => AppointmentCard(
                    patientName: a.patientName,
                    doctorName: a.doctorName,
                    specialization: a.doctorSpecialization,
                    time:
                        '${DateFormat('MMM d').format(a.appointmentDate)} · ${a.timeSlot}',
                    status: a.status.name.toUpperCase(),
                    onView: () => context.go('/doctor/appointments'),
                  ),
                ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickAction({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
