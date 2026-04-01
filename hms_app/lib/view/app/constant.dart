class AppConstants {
  static const String appName = 'HospiTrack';
  static const String appTagline = 'Your Health, Our Priority';

  static const List<String> userRoles = [
    'Admin',
    'Doctor',
    'Receptionist',
    'Patient',
  ];

  static const List<String> specializations = [
    'Cardiology',
    'Dermatology',
    'ENT',
    'General Medicine',
    'Gynecology',
    'Neurology',
    'Oncology',
    'Ophthalmology',
    'Orthopedics',
    'Pediatrics',
    'Psychiatry',
    'Pulmonology',
    'Radiology',
    'Surgery',
    'Urology',
  ];

  static const List<String> bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  static const List<String> wardTypes = [
    'General Ward',
    'ICU',
    'Private Room',
    'Semi-Private Room',
    'Emergency Ward',
    'Pediatric Ward',
    'Maternity Ward',
  ];

  static const List<String> appointmentStatuses = [
    'Pending',
    'Confirmed',
    'Completed',
    'Cancelled',
  ];

  static const List<String> commonConditions = [
    'Cold & Flu',
    'Headache / Migraine',
    'Fever',
    'Stomach Ache',
    'Back Pain',
    'Allergies',
    'Insomnia',
    'Skin Rash',
    'Anxiety',
    'Fatigue',
  ];

  // Payment methods
  static const List<String> paymentMethods = [
    'Credit Card',
    'Debit Card',
    'Cash',
    'Online Transfer',
    'Insurance',
  ];

  // Time slots
  static List<String> get timeSlots {
    final slots = <String>[];
    for (int h = 8; h <= 17; h++) {
      for (int m = 0; m < 60; m += 30) {
        final hour = h > 12 ? h - 12 : h;
        final ampm = h >= 12 ? 'PM' : 'AM';
        final minute = m == 0 ? '00' : '$m';
        slots.add('$hour:$minute $ampm');
      }
    }
    return slots;
  }
}

enum UserRole { admin, doctor, receptionist, patient }

enum AppointmentStatus { pending, confirmed, completed, cancelled }

enum BedStatus { available, occupied, maintenance }

enum TokenStatus { waiting, serving, completed }
