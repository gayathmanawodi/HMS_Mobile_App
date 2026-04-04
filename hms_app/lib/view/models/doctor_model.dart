class DoctorModel {
  final String id;
  final String name;
  final String specialization;
  final String email;
  final String phone;
  final String hospitalName;
  final int experience; // years
  final double rating;
  final int totalPatients;
  final String? imageUrl;
  final String bio;
  final List<String> availableDays;
  final String consultationFee;
  final bool isAvailable;

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialization,
    required this.email,
    required this.phone,
    required this.hospitalName,
    required this.experience,
    this.rating = 4.5,
    this.totalPatients = 0,
    this.imageUrl,
    this.bio = '',
    this.availableDays = const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
    this.consultationFee = 'LKR 1500',
    this.isAvailable = true,
  });

  factory DoctorModel.fromMap(Map<String, dynamic> map, String id) {
    return DoctorModel(
      id: id,
      name: map['name'] ?? '',
      specialization: map['specialization'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      hospitalName: map['hospitalName'] ?? '',
      experience: map['experience'] ?? 0,
      rating: (map['rating'] ?? 4.5).toDouble(),
      totalPatients: map['totalPatients'] ?? 0,
      imageUrl: map['imageUrl'],
      bio: map['bio'] ?? '',
      availableDays: List<String>.from(map['availableDays'] ?? []),
      consultationFee: map['consultationFee'] ?? 'LKR 1500',
      isAvailable: map['isAvailable'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'specialization': specialization,
      'email': email,
      'phone': phone,
      'hospitalName': hospitalName,
      'experience': experience,
      'rating': rating,
      'totalPatients': totalPatients,
      'imageUrl': imageUrl,
      'bio': bio,
      'availableDays': availableDays,
      'consultationFee': consultationFee,
      'isAvailable': isAvailable,
    };
  }

  DoctorModel copyWith({bool? isAvailable, int? totalPatients}) {
    return DoctorModel(
      id: id,
      name: name,
      specialization: specialization,
      email: email,
      phone: phone,
      hospitalName: hospitalName,
      experience: experience,
      rating: rating,
      totalPatients: totalPatients ?? this.totalPatients,
      imageUrl: imageUrl,
      bio: bio,
      availableDays: availableDays,
      consultationFee: consultationFee,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}
