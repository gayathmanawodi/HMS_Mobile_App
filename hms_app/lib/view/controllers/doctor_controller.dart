import 'package:flutter/material.dart';
import 'package:hospitrack/models/doctor_model.dart';
import 'package:hospitrack/services/mock_data_service.dart';
import 'package:uuid/uuid.dart';

class DoctorController extends ChangeNotifier {
  final MockDataService _db = MockDataService();
  final _uuid = const Uuid();

  List<DoctorModel> get all => List.unmodifiable(_db.doctors);

  List<DoctorModel> getBySpecialization(String spec) =>
      _db.doctors.where((d) => d.specialization == spec).toList();

  List<DoctorModel> search(String query) {
    final q = query.toLowerCase();
    return _db.doctors
        .where(
          (d) =>
              d.name.toLowerCase().contains(q) ||
              d.specialization.toLowerCase().contains(q),
        )
        .toList();
  }

  DoctorModel? getById(String id) => _db.doctors.firstWhere(
    (d) => d.id == id,
    orElse: () => _db.doctors.first,
  );

  void addDoctor({
    required String name,
    required String specialization,
    required String email,
    required String phone,
    required String hospitalName,
    required int experience,
    String consultationFee = 'LKR 1500',
  }) {
    final doc = DoctorModel(
      id: _uuid.v4(),
      name: name,
      specialization: specialization,
      email: email,
      phone: phone,
      hospitalName: hospitalName,
      experience: experience,
      consultationFee: consultationFee,
    );
    _db.addDoctor(doc);
    notifyListeners();
  }

  void removeDoctor(String id) {
    _db.removeDoctor(id);
    notifyListeners();
  }

  void toggleAvailability(String id) {
    final doc = _db.doctors.firstWhere((d) => d.id == id);
    _db.updateDoctor(doc.copyWith(isAvailable: !doc.isAvailable));
    notifyListeners();
  }
}
