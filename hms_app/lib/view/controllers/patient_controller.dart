import 'package:flutter/material.dart';
import 'package:hospitrack/models/patient_model.dart';
import 'package:hospitrack/services/mock_data_service.dart';
import 'package:uuid/uuid.dart';

class PatientController extends ChangeNotifier {
  final MockDataService _db = MockDataService();
  final _uuid = const Uuid();

  List<PatientModel> get all => List.unmodifiable(_db.patients);

  List<PatientModel> search(String query) {
    final q = query.toLowerCase();
    return _db.patients
        .where(
          (p) =>
              p.name.toLowerCase().contains(q) ||
              p.email.toLowerCase().contains(q) ||
              p.phone.contains(q),
        )
        .toList();
  }

  PatientModel? getById(String id) => _db.patients.firstWhere(
    (p) => p.id == id,
    orElse: () => _db.patients.first,
  );

  void addPatient({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String bloodGroup,
    required DateTime dateOfBirth,
    required String gender,
    String? allergies,
    String? medicalHistory,
    String? emergencyContact,
  }) {
    final patient = PatientModel(
      id: _uuid.v4(),
      name: name,
      email: email,
      phone: phone,
      address: address,
      bloodGroup: bloodGroup,
      dateOfBirth: dateOfBirth,
      gender: gender,
      allergies: allergies,
      medicalHistory: medicalHistory,
      emergencyContact: emergencyContact,
      registeredAt: DateTime.now(),
    );
    _db.addPatient(patient);
    notifyListeners();
  }

  void removePatient(String id) {
    _db.removePatient(id);
    notifyListeners();
  }
}
