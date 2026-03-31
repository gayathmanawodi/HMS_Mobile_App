// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hospitrack/app/theme.dart';
import 'package:hospitrack/controllers/appointment_controller.dart';
import 'package:hospitrack/controllers/token_controller.dart';
import 'package:hospitrack/services/mock_data_service.dart';
import 'package:hospitrack/widgets/app_drawer.dart';
import 'package:hospitrack/widgets/shared_widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReceptionDashboard extends StatelessWidget {
  const ReceptionDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final appts = context.watch<AppointmentController>();
    final tokens = context.watch<TokenController>();
    final db = MockDataService();
    final today = appts.todayAppointments;

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
            tooltip: 'Menu',
          ),
        ),
        title: const Text('Reception Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.go('/patient/notifications'),
          ),
        ],
      ),
      drawer: const AppDrawer(currentRoute: '/reception/dashboard'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Stats
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.15,
            children: [
              StatCard(
                title: "Today's Appts",
                value: '${today.length}',
                icon: Icons.calendar_today,
                color: AppTheme.primaryTeal,
                isSmall: true,
                onTap: () => context.go('/patient/appointments'),
              ).animate().fadeIn(delay: 100.ms),
              StatCard(
                title: 'Active Tokens',
                value: '${tokens.active.length}',
                icon: Icons.confirmation_number,
                color: AppTheme.accentGreen,
                isSmall: true,
                onTap: () => context.go('/reception/active-token'),
              ).animate().fadeIn(delay: 200.ms),
              StatCard(
                title: 'Available Beds',
                value: '${db.getAvailableBeds().length}',
                icon: Icons.bed,
                color: AppTheme.info,
                isSmall: true,
                onTap: () => context.go('/billing/bed-assign'),
              ).animate().fadeIn(delay: 300.ms),
              StatCard(
                title: 'Waiting',
                value: '${tokens.waitingCount}',
                icon: Icons.hourglass_empty,
                color: AppTheme.warning,
                isSmall: true,
                onTap: () => context.go('/reception/active-token'),
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
              _RxAction(
                'Generate\nToken',
                Icons.confirmation_number,
                AppTheme.primaryTeal,
                () => context.go('/reception/generate-token'),
              ),
              const SizedBox(width: 10),
              _RxAction(
                'Active\nToken',
                Icons.how_to_reg,
                AppTheme.accentGreen,
                () => context.go('/reception/active-token'),
              ),
              const SizedBox(width: 10),
              _RxAction(
                'Generate\nBill',
                Icons.receipt_long,
                AppTheme.warning,
                () => context.go('/billing/generate-bill'),
              ),
              const SizedBox(width: 10),
              _RxAction(
                'Bed\nAssign',
                Icons.bed,
                AppTheme.info,
                () => context.go('/billing/bed-assign'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Today's Appointments
          SectionHeader(
            title: "Today's Registrations",
            actionLabel: 'View all',
            onAction: () => context.go('/admin/patients'),
          ),
          const SizedBox(height: 8),
          if (today.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'No appointments today',
                  style: TextStyle(color: AppTheme.textMedium),
                ),
              ),
            )
          else
            ...today
                .take(4)
                .map(
                  (a) => AppointmentCard(
                    patientName: a.patientName,
                    doctorName: a.doctorName,
                    specialization: a.doctorSpecialization,
                    time:
                        '${DateFormat('MMM d').format(a.appointmentDate)} · ${a.timeSlot}',
                    status: a.status.name,
                    onView: () {},
                  ),
                ),
        ],
      ),
    );
  }
}

class _RxAction extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _RxAction(this.label, this.icon, this.color, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
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
      ),
    );
  }
}
