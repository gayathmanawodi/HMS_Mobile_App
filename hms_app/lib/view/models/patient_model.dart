class PatientModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String bloodGroup;
  final DateTime dateOfBirth;
  final String gender;
  final String? imageUrl;
  final String? emergencyContact;
  final String? allergies;
  final String? medicalHistory;
  final DateTime registeredAt;

  PatientModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.bloodGroup,
    required this.dateOfBirth,
    required this.gender,
    this.imageUrl,
    this.emergencyContact,
    this.allergies,
    this.medicalHistory,
    required this.registeredAt,
  });

  int get age {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  factory PatientModel.fromMap(Map<String, dynamic> map, String id) {
    return PatientModel(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      bloodGroup: map['bloodGroup'] ?? 'O+',
      dateOfBirth:
          DateTime.tryParse(map['dateOfBirth'] ?? '') ?? DateTime(1990, 1, 1),
      gender: map['gender'] ?? 'Male',
      imageUrl: map['imageUrl'],
      emergencyContact: map['emergencyContact'],
      allergies: map['allergies'],
      medicalHistory: map['medicalHistory'],
      registeredAt:
          DateTime.tryParse(map['registeredAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'bloodGroup': bloodGroup,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'imageUrl': imageUrl,
      'emergencyContact': emergencyContact,
      'allergies': allergies,
      'medicalHistory': medicalHistory,
      'registeredAt': registeredAt.toIso8601String(),
    };
  }
}
