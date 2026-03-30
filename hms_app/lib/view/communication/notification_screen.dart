import 'package:flutter/material.dart';
import 'package:hospitrack/widgets/app_back_button.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const AppBackButton(), title: const Text('Notifications')),
      body: const Center(
          child: Text('Notifications screen - see chat_screen.dart')),
    );
  }
}
