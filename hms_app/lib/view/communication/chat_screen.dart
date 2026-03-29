// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hospitrack/widgets/app_back_button.dart';
import 'package:hospitrack/app/theme.dart';

class ChatScreen extends StatefulWidget {
  final String doctorName;
  const ChatScreen({super.key, required this.doctorName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _ctrl = TextEditingController();
  final List<_ChatMsg> _messages = [
    _ChatMsg('Hello! How can I help you today?', false,
        DateTime.now().subtract(const Duration(minutes: 5))),
    _ChatMsg('I have been having chest pains since morning.', true,
        DateTime.now().subtract(const Duration(minutes: 4))),
    _ChatMsg(
        'I see. Is the pain sharp or dull? Does it radiate to your arm or jaw?',
        false,
        DateTime.now().subtract(const Duration(minutes: 3))),
  ];

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _send() {
    if (_ctrl.text.trim().isEmpty) return;
    setState(() {
      _messages.add(_ChatMsg(_ctrl.text.trim(), true, DateTime.now()));
      _ctrl.clear();
    });
    // Simulate doctor reply
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _messages.add(_ChatMsg(
              'Thank you for letting me know. I recommend you come in for a check-up as soon as possible.',
              false,
              DateTime.now()));
        });
      }
    });
  }
