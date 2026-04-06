class PrescriptionModel {
  final String id;
  final String appointmentId;
  final String patientId;
  final String patientName;
  final String doctorId;
  final String doctorName;
  final List<MedicineItem> medicines;
  final String? diagnosis;
  final String? notes;
  final DateTime prescribedAt;

  PrescriptionModel({
    required this.id,
    required this.appointmentId,
    required this.patientId,
    required this.patientName,
    required this.doctorId,
    required this.doctorName,
    required this.medicines,
    this.diagnosis,
    this.notes,
    required this.prescribedAt,
  });

  factory PrescriptionModel.fromMap(Map<String, dynamic> map, String id) {
    return PrescriptionModel(
      id: id,
      appointmentId: map['appointmentId'] ?? '',
      patientId: map['patientId'] ?? '',
      patientName: map['patientName'] ?? '',
      doctorId: map['doctorId'] ?? '',
      doctorName: map['doctorName'] ?? '',
      medicines: (map['medicines'] as List<dynamic>? ?? [])
          .map((m) => MedicineItem.fromMap(m as Map<String, dynamic>))
          .toList(),
      diagnosis: map['diagnosis'],
      notes: map['notes'],
      prescribedAt:
          DateTime.tryParse(map['prescribedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'appointmentId': appointmentId,
      'patientId': patientId,
      'patientName': patientName,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'medicines': medicines.map((m) => m.toMap()).toList(),
      'diagnosis': diagnosis,
      'notes': notes,
      'prescribedAt': prescribedAt.toIso8601String(),
    };
  }
}

class MedicineItem {
  final String name;
  final String dosage;
  final String frequency;
  final int durationDays;
  final String? instructions;

  MedicineItem({
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.durationDays,
    this.instructions,
  });

  factory MedicineItem.fromMap(Map<String, dynamic> map) {
    return MedicineItem(
      name: map['name'] ?? '',
      dosage: map['dosage'] ?? '',
      frequency: map['frequency'] ?? '',
      durationDays: map['durationDays'] ?? 7,
      instructions: map['instructions'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dosage': dosage,
      'frequency': frequency,
      'durationDays': durationDays,
      'instructions': instructions,
    };
  }
}
