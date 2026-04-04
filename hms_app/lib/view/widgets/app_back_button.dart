import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hospitrack/controllers/auth_controller.dart';
import 'package:provider/provider.dart';

class AppBackButton extends StatelessWidget {
  final String? fallbackRoute;

  const AppBackButton({super.key, this.fallbackRoute});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const BackButtonIcon(),
      onPressed: () {
        if (context.canPop()) {
          context.pop();
          return;
        }
        context.go(fallbackRoute ?? _defaultRoute(context));
      },
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
    );
  }

  String _defaultRoute(BuildContext context) {
    try {
      final role = context.read<AuthController>().currentUser?.role.name;
      switch (role) {
        case 'admin':
          return '/admin/dashboard';
        case 'doctor':
          return '/doctor/dashboard';
        case 'receptionist':
          return '/reception/dashboard';
        case 'patient':
          return '/patient/dashboard';
        default:
          return '/login';
      }
    } catch (_) {
      return '/login';
    }
  }
}
