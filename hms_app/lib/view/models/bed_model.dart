import 'package:hospitrack/app/constants.dart';

class BedModel {
  final String id;
  final String bedNumber;
  final String ward;
  final BedStatus status;
  final String? patientId;
  final String? patientName;
  final DateTime? admittedAt;
  final String? notes;

  BedModel({
    required this.id,
    required this.bedNumber,
    required this.ward,
    this.status = BedStatus.available,
    this.patientId,
    this.patientName,
    this.admittedAt,
    this.notes,
  });

  bool get isAvailable => status == BedStatus.available;
  bool get isOccupied => status == BedStatus.occupied;

  factory BedModel.fromMap(Map<String, dynamic> map, String id) {
    return BedModel(
      id: id,
      bedNumber: map['bedNumber'] ?? '',
      ward: map['ward'] ?? '',
      status: BedStatus.values.firstWhere(
        (s) => s.name == map['status'],
        orElse: () => BedStatus.available,
      ),
      patientId: map['patientId'],
      patientName: map['patientName'],
      admittedAt: map['admittedAt'] != null
          ? DateTime.tryParse(map['admittedAt'])
          : null,
      notes: map['notes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bedNumber': bedNumber,
      'ward': ward,
      'status': status.name,
      'patientId': patientId,
      'patientName': patientName,
      'admittedAt': admittedAt?.toIso8601String(),
      'notes': notes,
    };
  }

  BedModel copyWith({
    BedStatus? status,
    String? patientId,
    String? patientName,
    DateTime? admittedAt,
    String? notes,
  }) {
    return BedModel(
      id: id,
      bedNumber: bedNumber,
      ward: ward,
      status: status ?? this.status,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      admittedAt: admittedAt ?? this.admittedAt,
      notes: notes ?? this.notes,
    );
  }
}
