// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hospitrack/app/theme.dart';
import 'package:hospitrack/controllers/appointment_controller.dart';
import 'package:hospitrack/controllers/auth_controller.dart';
import 'package:hospitrack/services/mock_data_service.dart';
import 'package:hospitrack/widgets/app_drawer.dart';
import 'package:hospitrack/widgets/shared_widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PatientDashboard extends StatelessWidget {
  const PatientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();
    final ctrl = context.watch<AppointmentController>();
    final db = MockDataService();
    final user = auth.currentUser;
    final myAppts = ctrl.forPatient('p1');
    final upcoming = myAppts.where((a) => a.isUpcoming || a.isToday).toList();

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
            tooltip: 'Menu',
          ),
        ),
        title: Text('Hi, ${user?.firstName ?? 'Patient'} 👋'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.go('/patient/notifications'),
          ),
        ],
      ),
      drawer: const AppDrawer(currentRoute: '/patient/dashboard'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Stats Row
          Row(
            children: [
              Expanded(
                child: StatCard(
                  title: 'Appointments',
                  value: '${myAppts.length}',
                  icon: Icons.calendar_today,
                  color: AppTheme.primaryTeal,
                  onTap: () => context.go('/patient/appointments'),
                ).animate().fadeIn(delay: 100.ms),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatCard(
                  title: 'Doctors',
                  value: '${db.doctors.length}',
                  icon: Icons.medical_services,
                  color: AppTheme.info,
                  onTap: () => context.go('/patient/choose-doctor'),
                ).animate().fadeIn(delay: 200.ms),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: StatCard(
                  title: 'Prescriptions',
                  value: '${db.prescriptions.length}',
                  icon: Icons.description,
                  color: AppTheme.accentGreen,
                  onTap: () => context.go('/doctor/prescriptions'),
                ).animate().fadeIn(delay: 300.ms),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatCard(
                  title: 'Reports',
                  value: '${db.reports.length}',
                  icon: Icons.folder_shared,
                  color: AppTheme.warning,
                  onTap: () => context.go('/doctor/reports'),
                ).animate().fadeIn(delay: 400.ms),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Quick Services
          const Text(
            'Quick Services',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.0,
            children: [
              _ServiceTile(
                'Book Appt',
                Icons.add_circle_outline,
                AppTheme.primaryTeal,
                () => context.go('/patient/choose-doctor'),
              ),
              _ServiceTile(
                'Chat',
                Icons.chat_bubble,
                AppTheme.info,
                () => context.go('/patient/chat?doctor=Doctor'),
              ),
              _ServiceTile(
                'AI Check',
                Icons.smart_toy,
                AppTheme.accentGreen,
                () => context.go('/ai/symptom-checker'),
              ),
              _ServiceTile(
                'My Records',
                Icons.folder,
                AppTheme.warning,
                () => context.go('/patient/medical-form'),
              ),
              _ServiceTile(
                'Payment',
                Icons.payment,
                AppTheme.danger,
                () => context.go('/patient/payment'),
              ),
              _ServiceTile(
                'Risk Check',
                Icons.monitor_heart,
                Colors.purple,
                () => context.go('/ai/health-risk'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // AI Module Banner
          GestureDetector(
            onTap: () => context.go('/ai/symptom-checker'),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade700, Colors.indigo.shade600],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  Icon(Icons.smart_toy, color: Colors.white, size: 36),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AI Health Assistant',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Check symptoms & get health insights',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white54,
                    size: 16,
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 500.ms),
          const SizedBox(height: 20),
          // Upcoming Appointments
          SectionHeader(
            title: 'Upcoming Appointments',
            actionLabel: 'See all',
            onAction: () => context.go('/patient/appointments'),
          ),
          const SizedBox(height: 8),
          if (upcoming.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Icon(
                      Icons.event_available,
                      size: 48,
                      color: AppTheme.textLight,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'No upcoming appointments',
                      style: TextStyle(color: AppTheme.textMedium),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => context.go('/patient/choose-doctor'),
                      child: const Text('Book Now'),
                    ),
                  ],
                ),
              ),
            )
          else
            ...upcoming
                .take(3)
                .map(
                  (a) => AppointmentCard(
                    patientName: a.patientName,
                    doctorName: a.doctorName,
                    specialization: a.doctorSpecialization,
                    time:
                        '${DateFormat('MMM d').format(a.appointmentDate)} · ${a.timeSlot}',
                    status: a.status.name,
                    onView: () => context.go('/patient/appointments'),
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryTeal,
        onPressed: () => context.go('/patient/choose-doctor'),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _ServiceTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ServiceTile(this.label, this.icon, this.color, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: color,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
