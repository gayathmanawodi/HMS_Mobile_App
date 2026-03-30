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
          const SizedBox(height: 20),
          const Text('Payment Method',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 12),
          ...[
            'Credit Card',
            'Debit Card',
            'Cash',
            'Online Transfer',
            'Insurance'
          ].map(
            (m) => GestureDetector(
              onTap: () => setState(() => _method = m),
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: _method == m
                      ? AppTheme.primaryTeal.withOpacity(0.1)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: _method == m
                          ? AppTheme.primaryTeal
                          : AppTheme.divider),
                ),
                child: Row(
                  children: [
                    Icon(_methodIcon(m),
                        color: _method == m
                            ? AppTheme.primaryTeal
                            : AppTheme.textMedium),
                    const SizedBox(width: 12),
                    Text(m,
                        style: TextStyle(
                          color: _method == m
                              ? AppTheme.primaryTeal
                              : AppTheme.textDark,
                          fontWeight: _method == m
                              ? FontWeight.w600
                              : FontWeight.normal,
                        )),
                    const Spacer(),
                    if (_method == m)
                      const Icon(Icons.check_circle,
                          color: AppTheme.primaryTeal, size: 20),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => setState(() => _paid = true),
            child: const Text('Pay LKR 4,000'),
          ),
        ],
      ),
    );
  }

  IconData _methodIcon(String m) {
    switch (m) {
      case 'Credit Card':
        return Icons.credit_card;
      case 'Debit Card':
        return Icons.payment;
      case 'Cash':
        return Icons.money;
      case 'Online Transfer':
        return Icons.account_balance;
      default:
        return Icons.health_and_safety;
    }
  }
}
