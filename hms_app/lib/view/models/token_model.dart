import 'package:hospitrack/app/constants.dart';

class TokenModel {
  final String id;
  final String patientId;
  final String patientName;
  final String patientPhone;
  final int tokenNumber;
  final String department;
  final DateTime issuedAt;
  final TokenStatus status;

  TokenModel({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.patientPhone,
    required this.tokenNumber,
    required this.department,
    required this.issuedAt,
    this.status = TokenStatus.waiting,
  });

  factory TokenModel.fromMap(Map<String, dynamic> map, String id) {
    return TokenModel(
      id: id,
      patientId: map['patientId'] ?? '',
      patientName: map['patientName'] ?? '',
      patientPhone: map['patientPhone'] ?? '',
      tokenNumber: map['tokenNumber'] ?? 0,
      department: map['department'] ?? '',
      issuedAt: DateTime.tryParse(map['issuedAt'] ?? '') ?? DateTime.now(),
      status: TokenStatus.values.firstWhere(
        (s) => s.name == map['status'],
        orElse: () => TokenStatus.waiting,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'patientId': patientId,
      'patientName': patientName,
      'patientPhone': patientPhone,
      'tokenNumber': tokenNumber,
      'department': department,
      'issuedAt': issuedAt.toIso8601String(),
      'status': status.name,
    };
  }

  TokenModel copyWith({TokenStatus? status}) {
    return TokenModel(
      id: id,
      patientId: patientId,
      patientName: patientName,
      patientPhone: patientPhone,
      tokenNumber: tokenNumber,
      department: department,
      issuedAt: issuedAt,
      status: status ?? this.status,
    );
  }
}
