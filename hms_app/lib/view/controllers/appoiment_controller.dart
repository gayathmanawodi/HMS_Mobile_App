import 'package:flutter/material.dart';
import 'package:hospitrack/models/appointment_model.dart';
import 'package:hospitrack/app/constants.dart';
import 'package:hospitrack/services/mock_data_service.dart';
import 'package:uuid/uuid.dart';

class AppointmentController extends ChangeNotifier {
  final MockDataService _db = MockDataService();
  final _uuid = const Uuid();

  List<AppointmentModel> get all => _db.appointments;

  List<AppointmentModel> get todayAppointments => _db.getTodayAppointments();

  List<AppointmentModel> get upcomingAppointments =>
      _db.appointments.where((a) => a.isUpcoming).toList();

  List<AppointmentModel> get pastAppointments =>
      _db.appointments.where((a) => a.isPast).toList();

  List<AppointmentModel> forDoctor(String doctorId) =>
      _db.getAppointmentsForDoctor(doctorId);

  List<AppointmentModel> forPatient(String patientId) =>
      _db.getAppointmentsForPatient(patientId);

  void bookAppointment({
    required String patientId,
    required String patientName,
    required String doctorId,
    required String doctorName,
    required String doctorSpecialization,
    required DateTime date,
    required String timeSlot,
    String? symptoms,
    bool isOnline = false,
  }) {
    final appt = AppointmentModel(
      id: _uuid.v4(),
      patientId: patientId,
      patientName: patientName,
      doctorId: doctorId,
      doctorName: doctorName,
      doctorSpecialization: doctorSpecialization,
      appointmentDate: date,
      timeSlot: timeSlot,
      status: AppointmentStatus.confirmed,
      symptoms: symptoms,
      isOnline: isOnline,
      createdAt: DateTime.now(),
    );
    _db.addAppointment(appt);
    notifyListeners();
  }

  void updateStatus(String id, AppointmentStatus status) {
    _db.updateAppointmentStatus(id, status);
    notifyListeners();
  }

  void cancelAppointment(String id) {
    updateStatus(id, AppointmentStatus.cancelled);
  }

  void completeAppointment(String id) {
    updateStatus(id, AppointmentStatus.completed);
  }
}
