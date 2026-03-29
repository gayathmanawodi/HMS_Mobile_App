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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.doctorName, style: const TextStyle(fontSize: 16)),
            const Text('Online',
                style: TextStyle(fontSize: 12, color: Colors.white70)),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.call), onPressed: () {}),
          IconButton(icon: const Icon(Icons.videocam), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (_, i) {
                final msg = _messages[i];
                return _Bubble(msg: msg);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ctrl,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    onSubmitted: (_) => _send(),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: AppTheme.primaryTeal, shape: BoxShape.circle),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    onPressed: _send,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMsg {
  final String text;
  final bool isMe;
  final DateTime time;
  _ChatMsg(this.text, this.isMe, this.time);
}

class _Bubble extends StatelessWidget {
  final _ChatMsg msg;
  const _Bubble({required this.msg});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: msg.isMe ? AppTheme.primaryTeal : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(msg.isMe ? 16 : 4),
            bottomRight: Radius.circular(msg.isMe ? 4 : 16),
          ),
          boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 4)],
        ),
        child: Text(
          msg.text,
          style: TextStyle(
              color: msg.isMe ? Colors.white : AppTheme.textDark, fontSize: 14),
        ),
      ),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'title': 'Appointment Confirmed',
        'body':
            'Your appointment with Dr. Perera at 10:30 AM tomorrow is confirmed.',
        'time': '2 hrs ago',
        'icon': Icons.check_circle,
        'color': AppTheme.success
      },
      {
        'title': 'Prescription Ready',
        'body': 'Dr. Nadun Sampath has issued a new prescription for you.',
        'time': '5 hrs ago',
        'icon': Icons.description,
        'color': AppTheme.primaryTeal
      },
      {
        'title': 'Appointment Reminder',
        'body':
            'You have an appointment tomorrow at 11:00 AM with Dr. Silva (ENT).',
        'time': '1 day ago',
        'icon': Icons.notifications,
        'color': AppTheme.warning
      },
      {
        'title': 'Lab Results Available',
        'body':
            'Your blood test results are now available. Check your reports.',
        'time': '2 days ago',
        'icon': Icons.science,
        'color': AppTheme.info
      },
      {
        'title': 'Payment Received',
        'body': 'Payment of LKR 4,300 received for Bill BILL-2026-001.',
        'time': '5 days ago',
        'icon': Icons.payment,
        'color': AppTheme.accentGreen
      },
    ];

    return Scaffold(
      appBar: AppBar(
          leading: const AppBackButton(),
          title: const Text('Notifications'),
          actions: [
            TextButton(
                onPressed: () {},
                child: const Text('Mark all read',
                    style: TextStyle(color: Colors.white))),
          ]),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (_, i) {
          final n = notifications[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (n['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(n['icon'] as IconData, color: n['color'] as Color),
              ),
              title: Text(n['title'] as String,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(n['body'] as String,
                      style: const TextStyle(
                          fontSize: 12, color: AppTheme.textMedium)),
                  const SizedBox(height: 2),
                  Text(n['time'] as String,
                      style: const TextStyle(
                          fontSize: 11, color: AppTheme.textLight)),
                ],
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
