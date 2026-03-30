// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hospitrack/widgets/app_back_button.dart';
import 'package:go_router/go_router.dart';
import 'package:hospitrack/app/constants.dart';
import 'package:hospitrack/app/theme.dart';
import 'package:hospitrack/controllers/appointment_controller.dart';
import 'package:hospitrack/controllers/auth_controller.dart';
import 'package:hospitrack/services/mock_data_service.dart';
import 'package:provider/provider.dart';

class ChooseTimeScreen extends StatefulWidget {
  final String doctorId;
  const ChooseTimeScreen({super.key, required this.doctorId});

  @override
  State<ChooseTimeScreen> createState() => _ChooseTimeScreenState();
}

class _ChooseTimeScreenState extends State<ChooseTimeScreen> {
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  String? _selectedSlot;
  String? _symptoms;
  bool _isOnline = false;

  void _book() {
    if (_selectedSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a time slot')),
      );
      return;
    }
    final db = MockDataService();
    final auth = context.read<AuthController>();
    final doctor = db.doctors.firstWhere((d) => d.id == widget.doctorId);
    context.read<AppointmentController>().bookAppointment(
      patientId: auth.currentUser?.id ?? 'p1',
      patientName: auth.currentUser?.fullName ?? 'Patient',
      doctorId: doctor.id,
      doctorName: doctor.name,
      doctorSpecialization: doctor.specialization,
      date: _selectedDate,
      timeSlot: _selectedSlot!,
      symptoms: _symptoms,
      isOnline: _isOnline,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Appointment booked successfully!'),
        backgroundColor: AppTheme.success,
      ),
    );
    context.go('/patient/appointments');
  }

  @override
  Widget build(BuildContext context) {
    final db = MockDataService();
    final doctor = db.doctors.firstWhere(
      (d) => d.id == widget.doctorId,
      orElse: () => db.doctors.first,
    );
    final slots = AppConstants.timeSlots;

    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text('Book · ${doctor.name}'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Doctor summary
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppTheme.primaryTeal.withOpacity(0.15),
                    child: const Icon(
                      Icons.person,
                      color: AppTheme.primaryTeal,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          doctor.specialization,
                          style: const TextStyle(
                            color: AppTheme.textMedium,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          'Fee: ${doctor.consultationFee}',
                          style: const TextStyle(
                            color: AppTheme.primaryTeal,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Date picker
          const Text(
            'Select Date',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 14,
              itemBuilder: (_, i) {
                final date = DateTime.now().add(Duration(days: i + 1));
                final isSelected =
                    date.day == _selectedDate.day &&
                    date.month == _selectedDate.month;
                return GestureDetector(
                  onTap: () => setState(() => _selectedDate = date),
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.primaryTeal : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(color: Color(0x14000000), blurRadius: 4),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          [
                            'Mon',
                            'Tue',
                            'Wed',
                            'Thu',
                            'Fri',
                            'Sat',
                            'Sun',
                          ][date.weekday - 1],
                          style: TextStyle(
                            fontSize: 11,
                            color: isSelected
                                ? Colors.white70
                                : AppTheme.textLight,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${date.day}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? Colors.white
                                : AppTheme.textDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Time slots
          const Text(
            'Available Time Slots',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: slots.map((slot) {
              final isSelected = slot == _selectedSlot;
              return GestureDetector(
                onTap: () => setState(() => _selectedSlot = slot),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.primaryTeal : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.primaryTeal
                          : AppTheme.divider,
                    ),
                  ),
                  child: Text(
                    slot,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.white : AppTheme.textMedium,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          // Consultation type
          Row(
            children: [
              const Text(
                'Online Consultation',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              Switch(
                value: _isOnline,
                onChanged: (v) => setState(() => _isOnline = v),
                activeColor: AppTheme.primaryTeal,
              ),
            ],
          ),
          // Symptoms
          TextField(
            decoration: const InputDecoration(
              labelText: 'Describe symptoms (optional)',
              alignLabelWithHint: true,
            ),
            maxLines: 3,
            onChanged: (v) => _symptoms = v,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _book,
              child: const Text('Confirm Appointment'),
            ),
          ),
        ],
      ),
    );
  }
}
