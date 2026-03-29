// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hospitrack/widgets/app_back_button.dart';
import 'package:hospitrack/app/theme.dart';

class MakePaymentScreen extends StatefulWidget {
  const MakePaymentScreen({super.key});

  @override
  State<MakePaymentScreen> createState() => _MakePaymentScreenState();
}

class _MakePaymentScreenState extends State<MakePaymentScreen> {
  String _method = 'Credit Card';
  bool _paid = false;

  @override
  Widget build(BuildContext context) {
    if (_paid) {
      return Scaffold(
        appBar: AppBar(
            leading: const AppBackButton(), title: const Text('Payment')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                    color: AppTheme.success, shape: BoxShape.circle),
                child: const Icon(Icons.check, color: Colors.white, size: 48),
              ),
              const SizedBox(height: 20),
              const Text('Payment Successful!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const Text('LKR 4,300.00',
                  style: TextStyle(fontSize: 18, color: AppTheme.textMedium)),
              const SizedBox(height: 32),
              ElevatedButton(
                  onPressed: () => setState(() => _paid = false),
                  child: const Text('New Payment')),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
          leading: const AppBackButton(), title: const Text('Make Payment')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Bill summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                gradient: AppTheme.cardGradient,
                borderRadius: BorderRadius.circular(16)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bill Summary',
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
                SizedBox(height: 4),
                Text('BILL-2026-002',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                SizedBox(height: 12),
                Text('Consultation Fee: LKR 1,500',
                    style: TextStyle(color: Colors.white70)),
                Text('Skin Biopsy: LKR 2,500',
                    style: TextStyle(color: Colors.white70)),
                Divider(color: Colors.white30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    Text('LKR 4,000',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  ],
                ),
              ],
            ),
          ),
