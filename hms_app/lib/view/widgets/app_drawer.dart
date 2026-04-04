// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hospitrack/app/theme.dart';
import 'package:hospitrack/controllers/auth_controller.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  final String currentRoute;
  const AppDrawer({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();
    final user = auth.currentUser;
    final role = user?.role.name ?? 'patient';

    return Drawer(
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16,
              left: 20,
              right: 20,
              bottom: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.white24,
                  backgroundImage: role == 'admin'
                      ? const AssetImage('assets/images/profileadmin.png')
                      : role == 'doctor'
                      ? const AssetImage('assets/images/receptionprofile.png')
                      : role == 'receptionist'
                      ? const AssetImage('assets/images/receptionprofile.png')
                      : role == 'patient'
                      ? const AssetImage('assets/images/profileadmin.png')
                      : null,
                  child:
                      role == 'admin' ||
                          role == 'doctor' ||
                          role == 'receptionist' ||
                          role == 'patient'
                      ? null
                      : Text(
                          user?.firstName.substring(0, 1).toUpperCase() ?? 'U',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
                const SizedBox(height: 12),
                Text(
                  user?.fullName ?? 'User',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    role.toUpperCase(),
                    style: const TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
          // Menu items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: _buildMenuItems(context, role),
            ),
          ),
          _DrawerItem(
            icon: Icons.settings,
            label: 'Settings',
            route: '/settings',
            context: context,
            current: currentRoute,
          ),
          const Divider(),
          _DrawerItem(
            icon: Icons.logout,
            label: 'Log Out',
            color: AppTheme.danger,
            onTap: () {
              context.read<AuthController>().logout();
              context.go('/login');
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  List<Widget> _buildMenuItems(BuildContext context, String role) {
    switch (role) {
      case 'admin':
        return [
          _DrawerItem(
            icon: Icons.dashboard,
            label: 'Dashboard',
            route: '/admin/dashboard',
            context: context,
            current: currentRoute,
          ),
          _DrawerItem(
            icon: Icons.medical_services,
            label: 'Doctors',
            route: '/admin/doctors',
            context: context,
            current: currentRoute,
          ),
          _DrawerItem(
            icon: Icons.people,
            label: 'Patients',
            route: '/admin/patients',
            context: context,
            current: currentRoute,
          ),
          _DrawerItem(
            icon: Icons.person_add,
            label: 'Add Doctor',
            route: '/admin/add-doctor',
            context: context,
            current: currentRoute,
          ),
          _DrawerItem(
            icon: Icons.person_add_alt_1,
            label: 'Add Patient',
            route: '/admin/add-patient',
            context: context,
            current: currentRoute,
          ),
          _DrawerItem(
            icon: Icons.account_circle,
            label: 'Profile',
            route: '/admin/profile',
            context: context,
            current: currentRoute,
          ),
        ];
      case 'doctor':
        return [
          _DrawerItem(
            icon: Icons.dashboard,
            label: 'Dashboard',
            route: '/doctor/dashboard',
            context: context,
            current: currentRoute,
          ),
          _DrawerItem(
            icon: Icons.account_circle,
            label: 'Doctor Profile',
            route: '/doctor/profile',
            context: context,
            current: currentRoute,
          ),
          _DrawerItem(
            icon: Icons.calendar_today,
            label: 'Appointments',
            route: '/doctor/appointments',
            context: context,
            current: currentRoute,
          ),
          _DrawerItem(
            icon: Icons.description,
            label: 'Prescriptions',
            route: '/doctor/prescriptions',
            context: context,
            current: currentRoute,
          ),
          _DrawerItem(
            icon: Icons.folder_shared,
            label: 'Reports',
            route: '/doctor/reports',
            context: context,
            current: currentRoute,
          ),
          _DrawerItem(
            icon: Icons.local_hospital,
            label: 'Hospitals',
            route: '/admin/patients',
            context: context,
            current: currentRoute,
          ),
          _DrawerItem(
            icon: Icons.payment,
            label: 'Payments',
            route: '/patient/payment',
            context: context,
            current: currentRoute,
          ),
        ];
      case 'receptionist':
        return [
          _DrawerItem(
            icon: Icons.dashboard,
            label: 'Dashboard',
            route: '/reception/dashboard',
            context: context,
            current: currentRoute,
          ),
          _DrawerItem(
            icon: Icons.confirmation_number,
            label: 'Generate Token',
            route: '/reception/generate-token',
            context: context,
            current: currentRoute,
          ),
          _DrawerItem(
            icon: Icons.how_to_reg,
            label: 'Active Token',
            route: '/reception/active-token',
            context: context,
            current: currentRoute,
          ),
          _DrawerItem(
            icon: Icons.receipt_long,
            label: 'Generate Bill',
            route: '/billing/generate-bill',
            context: context,
            current: currentRoute,
          ),
          _DrawerItem(
            icon: Icons.bed,
            label: 'Bed Management',
            route: '/billing/bed-assign',
            context: context,
            current: currentRoute,
          ),
          _DrawerItem(
            icon: Icons.account_circle,
            label: 'Profile',
            route: '/reception/profile',
            context: context,
            current: currentRoute,
          ),
        ];
      default: // patient
        return [
          _DrawerItem(
            icon: Icons.dashboard,
            label: 'Dashboard',
            route: '/patient/dashboard',
            context: context,
            current: currentRoute,
          ),
          _DrawerItem(
            icon: Icons.account_circle,
            label: 'Patient Profile',
            route: '/patient/profile',
            context: context,
            current: currentRoute,
          ),
          _DrawerItem(
            icon: Icons.calendar_today,
            label: 'My Appointments',
            route: '/patient/appointments',
            context: context,
            current: currentRoute,
          ),
          _DrawerItem(
            icon: Icons.medical_services,
            label: 'Book Appointment',
            route: '/patient/choose-doctor',
            context: context,
            current: currentRoute,
          ),
          _DrawerItem(
            icon: Icons.chat,
            label: 'Chat with Doctor',
            route: '/patient/chat',
            context: context,
            current: currentRoute,
          ),
          _DrawerItem(
            icon: Icons.folder_shared,
            label: 'Medical Records',
            route: '/patient/medical-form',
            context: context,
            current: currentRoute,
          ),
          _DrawerItem(
            icon: Icons.payment,
            label: 'Payments',
            route: '/patient/payment',
            context: context,
            current: currentRoute,
          ),
        ];
    }
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? route;
  final BuildContext? context;
  final String? current;
  final VoidCallback? onTap;
  final Color? color;

  const _DrawerItem({
    required this.icon,
    required this.label,
    this.route,
    this.context,
    this.current,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext ctx) {
    final isActive = route != null && current == route;
    final itemColor =
        color ?? (isActive ? AppTheme.primaryTeal : AppTheme.textMedium);

    return ListTile(
      leading: Icon(icon, color: itemColor, size: 22),
      title: Text(
        label,
        style: TextStyle(
          color: itemColor,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          fontSize: 14,
        ),
      ),
      tileColor: isActive ? AppTheme.primaryTeal.withOpacity(0.08) : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      onTap:
          onTap ??
          () {
            Navigator.pop(ctx);
            if (route != null && context != null) context!.go(route!);
          },
    );
  }
}
