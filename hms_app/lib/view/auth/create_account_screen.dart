import 'package:flutter/material.dart';
import 'package:hospitrack/widgets/app_back_button.dart';

class AppointmentCenter extends StatelessWidget {
  const AppointmentCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Appointment Center'),
      ),
      body: const Center(child: Text('See My Appointments via dashboard')),
    );
  }
}
