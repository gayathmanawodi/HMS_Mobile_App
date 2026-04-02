import 'package:hospitrack/app/constants.dart';

class AppointmentModel {
  final String id;
  final String patientId;
  final String patientName;
  final String doctorId;
  final String doctorName;
  final String doctorSpecialization;
  final DateTime appointmentDate;
  final String timeSlot;
  final AppointmentStatus status;
  final String? notes;
  final String? symptoms;
  final bool isOnline;
  final DateTime createdAt;

  AppointmentModel({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialization,
    required this.appointmentDate,
    required this.timeSlot,
    this.status = AppointmentStatus.pending,
    this.notes,
    this.symptoms,
    this.isOnline = false,
    required this.createdAt,
  });

  bool get isToday {
    final now = DateTime.now();
    return appointmentDate.year == now.year &&
        appointmentDate.month == now.month &&
        appointmentDate.day == now.day;
  }

  bool get isUpcoming => appointmentDate.isAfter(DateTime.now()) && !isToday;
  bool get isPast => appointmentDate.isBefore(DateTime.now()) && !isToday;

  factory AppointmentModel.fromMap(Map<String, dynamic> map, String id) {
    return AppointmentModel(
      id: id,
      patientId: map['patientId'] ?? '',
      patientName: map['patientName'] ?? '',
      doctorId: map['doctorId'] ?? '',
      doctorName: map['doctorName'] ?? '',
      doctorSpecialization: map['doctorSpecialization'] ?? '',
      appointmentDate:
          DateTime.tryParse(map['appointmentDate'] ?? '') ?? DateTime.now(),
      timeSlot: map['timeSlot'] ?? '',
      status: AppointmentStatus.values.firstWhere(
        (s) => s.name == map['status'],
        orElse: () => AppointmentStatus.pending,
      ),
      notes: map['notes'],
      symptoms: map['symptoms'],
      isOnline: map['isOnline'] ?? false,
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'patientId': patientId,
      'patientName': patientName,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'doctorSpecialization': doctorSpecialization,
      'appointmentDate': appointmentDate.toIso8601String(),
      'timeSlot': timeSlot,
      'status': status.name,
      'notes': notes,
      'symptoms': symptoms,
      'isOnline': isOnline,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  AppointmentModel copyWith({AppointmentStatus? status, String? notes}) {
    return AppointmentModel(
      id: id,
      patientId: patientId,
      patientName: patientName,
      doctorId: doctorId,
      doctorName: doctorName,
      doctorSpecialization: doctorSpecialization,
      appointmentDate: appointmentDate,
      timeSlot: timeSlot,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      symptoms: symptoms,
      isOnline: isOnline,
      createdAt: createdAt,
    );
  }
}
