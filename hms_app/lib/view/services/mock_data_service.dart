import 'package:hospitrack/app/constants.dart';
import 'package:hospitrack/models/appointment_model.dart';
import 'package:hospitrack/models/bed_model.dart';
import 'package:hospitrack/models/doctor_model.dart';
import 'package:hospitrack/models/patient_model.dart';
import 'package:hospitrack/models/payment_model.dart';
import 'package:hospitrack/models/prescription_model.dart';
import 'package:hospitrack/models/report_model.dart';
import 'package:hospitrack/models/token_model.dart';
import 'package:hospitrack/models/user_model.dart';

class MockDataService {
  static final MockDataService _instance = MockDataService._internal();
  factory MockDataService() => _instance;
  MockDataService._internal() {
    _initializeData();
  }

  // ─── Data Stores ─────────────────────────────────────────────────────────
  late List<DoctorModel> doctors;
  late List<PatientModel> patients;
  late List<AppointmentModel> appointments;
  late List<PrescriptionModel> prescriptions;
  late List<ReportModel> reports;
  late List<TokenModel> tokens;
  late List<PaymentModel> payments;
  late List<BedModel> beds;
  late List<UserModel> users;

  // ─── Logged-in User ───────────────────────────────────────────────────────
  UserModel? currentUser;

  void _initializeData() {
    _initDoctors();
    _initPatients();
    _initAppointments();
    _initPrescriptions();
    _initReports();
    _initTokens();
    _initPayments();
    _initBeds();
    _initUsers();
  }

  void _initDoctors() {
    doctors = [
      DoctorModel(
        id: 'd1',
        name: 'Dr. Nadun Sampath',
        specialization: 'Cardiology',
        email: 'nadun@hospitrack.lk',
        phone: '077 122 4567',
        hospitalName: 'HospiTrack Medical Hospital',
        experience: 12,
        rating: 4.8,
        totalPatients: 120,
        bio:
            'I am Nadun Sampath, an Emergency Medicine specialist with over 12 years of experience. My goal is to ensure patient safety, comfort, and long-term health.',
        consultationFee: 'LKR 2000',
        availableDays: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
      ),
      DoctorModel(
        id: 'd2',
        name: 'Dr. Perera',
        specialization: 'Cardiology',
        email: 'perera@hospitrack.lk',
        phone: '077 234 5678',
        hospitalName: 'HospiTrack Medical Hospital',
        experience: 8,
        rating: 4.6,
        totalPatients: 89,
        consultationFee: 'LKR 1800',
      ),
      DoctorModel(
        id: 'd3',
        name: 'Dr. Sitha Fernando',
        specialization: 'Dermatology',
        email: 'sitha@hospitrack.lk',
        phone: '077 345 6789',
        hospitalName: 'HospiTrack Medical Hospital',
        experience: 10,
        rating: 4.7,
        totalPatients: 95,
        consultationFee: 'LKR 1500',
      ),
      DoctorModel(
        id: 'd4',
        name: 'Dr. Silva',
        specialization: 'ENT',
        email: 'silva@hospitrack.lk',
        phone: '077 456 7890',
        hospitalName: 'HospiTrack Medical Hospital',
        experience: 15,
        rating: 4.9,
        totalPatients: 200,
        consultationFee: 'LKR 2500',
      ),
      DoctorModel(
        id: 'd5',
        name: 'Dr. Ayesha Rathnayas',
        specialization: 'Pediatrics',
        email: 'ayesha@hospitrack.lk',
        phone: '077 567 8901',
        hospitalName: 'HospiTrack Medical Hospital',
        experience: 6,
        rating: 4.5,
        totalPatients: 150,
        consultationFee: 'LKR 1500',
      ),
      DoctorModel(
        id: 'd6',
        name: 'Dr. Amy Dhananj',
        specialization: 'General Medicine',
        email: 'amy@hospitrack.lk',
        phone: '077 678 9012',
        hospitalName: 'HospiTrack Medical Hospital',
        experience: 5,
        rating: 4.4,
        totalPatients: 80,
        consultationFee: 'LKR 1200',
      ),
      DoctorModel(
        id: 'd7',
        name: 'Dr. Nimal Perera',
        specialization: 'Neurology',
        email: 'nimal@hospitrack.lk',
        phone: '077 789 0123',
        hospitalName: 'HospiTrack Medical Hospital',
        experience: 18,
        rating: 4.9,
        totalPatients: 300,
        consultationFee: 'LKR 3000',
      ),
    ];
  }

  void _initPatients() {
    patients = [
      PatientModel(
        id: 'p1',
        name: 'John Silva',
        email: 'john@email.com',
        phone: '071 111 2222',
        address: 'No. 12, Galle Road, Colombo',
        bloodGroup: 'B+',
        dateOfBirth: DateTime(1990, 3, 15),
        gender: 'Male',
        allergies: 'Penicillin',
        medicalHistory: 'Hypertension, Diabetes',
        registeredAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
      PatientModel(
        id: 'p2',
        name: 'Nimal Perera',
        email: 'nimal.p@email.com',
        phone: '071 222 3333',
        address: 'No. 45, Kandy Road, Peradeniya',
        bloodGroup: 'O+',
        dateOfBirth: DateTime(1985, 7, 22),
        gender: 'Male',
        registeredAt: DateTime.now().subtract(const Duration(days: 15)),
      ),
      PatientModel(
        id: 'p3',
        name: 'Sitha Fernando',
        email: 'sitha.f@email.com',
        phone: '071 333 4444',
        address: 'No. 8, Temple Road, Galle',
        bloodGroup: 'A-',
        dateOfBirth: DateTime(1995, 12, 5),
        gender: 'Female',
        allergies: 'Dust, Pollen',
        registeredAt: DateTime.now().subtract(const Duration(days: 10)),
      ),
      PatientModel(
        id: 'p4',
        name: 'Ayasha Kumari',
        email: 'ayasha@email.com',
        phone: '071 444 5555',
        address: 'No. 23, Park Street, Matara',
        bloodGroup: 'AB+',
        dateOfBirth: DateTime(2000, 5, 18),
        gender: 'Female',
        registeredAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      PatientModel(
        id: 'p5',
        name: 'Roshan Bandara',
        email: 'roshan@email.com',
        phone: '071 555 6666',
        address: 'No. 67, Station Road, Kurunegala',
        bloodGroup: 'O-',
        dateOfBirth: DateTime(1978, 9, 30),
        gender: 'Male',
        medicalHistory: 'Asthma',
        registeredAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];
  }

  void _initAppointments() {
    final now = DateTime.now();
    appointments = [
      AppointmentModel(
        id: 'a1',
        patientId: 'p1',
        patientName: 'John Silva',
        doctorId: 'd2',
        doctorName: 'Dr. Perera',
        doctorSpecialization: 'Cardiology',
        appointmentDate: now,
        timeSlot: '10:30 AM',
        status: AppointmentStatus.confirmed,
        symptoms: 'Chest pain, shortness of breath',
        createdAt: now.subtract(const Duration(days: 2)),
      ),
      AppointmentModel(
        id: 'a2',
        patientId: 'p2',
        patientName: 'Nimal Perera',
        doctorId: 'd4',
        doctorName: 'Dr. Silva',
        doctorSpecialization: 'ENT',
        appointmentDate: now,
        timeSlot: '11:00 AM',
        status: AppointmentStatus.pending,
        createdAt: now.subtract(const Duration(days: 1)),
      ),
      AppointmentModel(
        id: 'a3',
        patientId: 'p3',
        patientName: 'Sitha Fernando',
        doctorId: 'd3',
        doctorName: 'Dr. Sitha Fernando',
        doctorSpecialization: 'Dermatology',
        appointmentDate: now,
        timeSlot: '2:00 PM',
        status: AppointmentStatus.pending,
        createdAt: now.subtract(const Duration(hours: 5)),
      ),
      AppointmentModel(
        id: 'a4',
        patientId: 'p5',
        patientName: 'Roshan Bandara',
        doctorId: 'd6',
        doctorName: 'Dr. Amy Dhananj',
        doctorSpecialization: 'General Medicine',
        appointmentDate: now.add(const Duration(days: 1)),
        timeSlot: '9:00 AM',
        status: AppointmentStatus.confirmed,
        createdAt: now.subtract(const Duration(hours: 2)),
      ),
      AppointmentModel(
        id: 'a5',
        patientId: 'p4',
        patientName: 'Ayasha Kumari',
        doctorId: 'd5',
        doctorName: 'Dr. Ayesha Rathnayas',
        doctorSpecialization: 'Pediatrics',
        appointmentDate: now.add(const Duration(days: 2)),
        timeSlot: '10:30 AM',
        status: AppointmentStatus.confirmed,
        createdAt: now.subtract(const Duration(hours: 1)),
      ),
      AppointmentModel(
        id: 'a6',
        patientId: 'p1',
        patientName: 'John Silva',
        doctorId: 'd1',
        doctorName: 'Dr. Nadun Sampath',
        doctorSpecialization: 'Cardiology',
        appointmentDate: now.subtract(const Duration(days: 5)),
        timeSlot: '3:00 PM',
        status: AppointmentStatus.completed,
        createdAt: now.subtract(const Duration(days: 7)),
      ),
    ];
  }

  void _initPrescriptions() {
    prescriptions = [
      PrescriptionModel(
        id: 'rx1',
        appointmentId: 'a6',
        patientId: 'p1',
        patientName: 'John Silva',
        doctorId: 'd1',
        doctorName: 'Dr. Nadun Sampath',
        diagnosis: 'Hypertension Stage 1',
        notes: 'Reduce sodium intake, avoid stress, light exercise daily.',
        medicines: [
          MedicineItem(
            name: 'Amlodipine 5mg',
            dosage: '1 tablet',
            frequency: 'Once daily (morning)',
            durationDays: 30,
            instructions: 'Take with water after breakfast',
          ),
          MedicineItem(
            name: 'Aspirin 75mg',
            dosage: '1 tablet',
            frequency: 'Once daily (night)',
            durationDays: 30,
            instructions: 'Take after dinner',
          ),
        ],
        prescribedAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
    ];
  }

  void _initReports() {
    reports = [
      ReportModel(
        id: 'r1',
        patientId: 'p1',
        patientName: 'John Silva',
        type: ReportType.investigation,
        title: 'Blood Test Report',
        description: 'Complete blood count and lipid profile',
        fields: {
          'HbA1c': '6.4%',
          'LDL Cholesterol': '142 mg/dL',
          'HDL Cholesterol': '48 mg/dL',
          'Triglycerides': '180 mg/dL',
          'Blood Glucose': '118 mg/dL',
        },
        createdBy: 'Lab Technician',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      ReportModel(
        id: 'r2',
        patientId: 'p4',
        patientName: 'Ayasha Kumari',
        type: ReportType.birth,
        title: 'Birth Report',
        description: 'Newborn delivery report',
        fields: {
          'Baby Name': 'Baby Kumari',
          'Date of Birth': '2026-03-01',
          'Time of Birth': '14:32',
          'Birth Weight': '3.2 kg',
          'Birth Length': '50 cm',
          'Delivery Type': 'Normal',
          'Mother': 'Ayasha Kumari',
          'Attending Doctor': 'Dr. Ayesha Rathnayas',
        },
        createdBy: 'Dr. Ayesha Rathnayas',
        createdAt: DateTime.now().subtract(const Duration(days: 9)),
      ),
    ];
  }

  void _initTokens() {
    tokens = [
      TokenModel(
        id: 't1',
        patientId: 'p2',
        patientName: 'Nimal Perera',
        patientPhone: '071 222 3333',
        tokenNumber: 1,
        department: 'General OPD',
        issuedAt: DateTime.now().subtract(const Duration(minutes: 30)),
        status: TokenStatus.serving,
      ),
      TokenModel(
        id: 't2',
        patientId: 'p3',
        patientName: 'Sitha Fernando',
        patientPhone: '071 333 4444',
        tokenNumber: 2,
        department: 'General OPD',
        issuedAt: DateTime.now().subtract(const Duration(minutes: 20)),
        status: TokenStatus.waiting,
      ),
      TokenModel(
        id: 't3',
        patientId: 'p5',
        patientName: 'Roshan Bandara',
        patientPhone: '071 555 6666',
        tokenNumber: 3,
        department: 'General OPD',
        issuedAt: DateTime.now().subtract(const Duration(minutes: 15)),
        status: TokenStatus.waiting,
      ),
    ];
  }

  void _initPayments() {
    payments = [
      PaymentModel(
        id: 'pay1',
        patientId: 'p1',
        patientName: 'John Silva',
        billNumber: 'BILL-2026-001',
        items: [
          BillItem(
            description: 'Consultation Fee',
            quantity: 1,
            unitPrice: 2000,
          ),
          BillItem(description: 'Blood Test', quantity: 1, unitPrice: 1500),
          BillItem(description: 'ECG', quantity: 1, unitPrice: 800),
        ],
        totalAmount: 4300,
        paidAmount: 4300,
        paymentMethod: 'Credit Card',
        isPaid: true,
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        paidAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      PaymentModel(
        id: 'pay2',
        patientId: 'p3',
        patientName: 'Sitha Fernando',
        billNumber: 'BILL-2026-002',
        items: [
          BillItem(
            description: 'Consultation Fee',
            quantity: 1,
            unitPrice: 1500,
          ),
          BillItem(description: 'Skin Biopsy', quantity: 1, unitPrice: 2500),
        ],
        totalAmount: 4000,
        paidAmount: 0,
        paymentMethod: 'Cash',
        isPaid: false,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];
  }

  void _initBeds() {
    beds = [
      BedModel(
        id: 'b1',
        bedNumber: 'GW-001',
        ward: 'General Ward',
        status: BedStatus.occupied,
        patientId: 'p2',
        patientName: 'Nimal Perera',
        admittedAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      BedModel(id: 'b2', bedNumber: 'GW-002', ward: 'General Ward'),
      BedModel(id: 'b3', bedNumber: 'GW-003', ward: 'General Ward'),
      BedModel(
        id: 'b4',
        bedNumber: 'ICU-001',
        ward: 'ICU',
        status: BedStatus.occupied,
        patientId: 'p1',
        patientName: 'John Silva',
        admittedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      BedModel(id: 'b5', bedNumber: 'ICU-002', ward: 'ICU'),
      BedModel(id: 'b6', bedNumber: 'PR-001', ward: 'Private Room'),
      BedModel(id: 'b7', bedNumber: 'PR-002', ward: 'Private Room'),
      BedModel(
        id: 'b8',
        bedNumber: 'MAT-001',
        ward: 'Maternity Ward',
        status: BedStatus.occupied,
        patientId: 'p4',
        patientName: 'Ayasha Kumari',
        admittedAt: DateTime.now().subtract(const Duration(days: 9)),
      ),
      BedModel(id: 'b9', bedNumber: 'MAT-002', ward: 'Maternity Ward'),
      BedModel(
        id: 'b10',
        bedNumber: 'PED-001',
        ward: 'Pediatric Ward',
        status: BedStatus.maintenance,
      ),
    ];
  }

  void _initUsers() {
    users = [
      UserModel(
        id: 'u_admin',
        firstName: 'Admin',
        lastName: 'User',
        email: 'admin@hospitrack.lk',
        phone: '077 000 0001',
        role: UserRole.admin,
        createdAt: DateTime.now().subtract(const Duration(days: 365)),
      ),
      UserModel(
        id: 'u_doctor',
        firstName: 'Nadun',
        lastName: 'Sampath',
        email: 'nadun@hospitrack.lk',
        phone: '077 122 4567',
        role: UserRole.doctor,
        createdAt: DateTime.now().subtract(const Duration(days: 180)),
      ),
      UserModel(
        id: 'u_reception',
        firstName: 'Reception',
        lastName: 'Staff',
        email: 'reception@hospitrack.lk',
        phone: '077 000 0003',
        role: UserRole.receptionist,
        createdAt: DateTime.now().subtract(const Duration(days: 90)),
      ),
      UserModel(
        id: 'u_patient',
        firstName: 'John',
        lastName: 'Silva',
        email: 'john@email.com',
        phone: '071 111 2222',
        role: UserRole.patient,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
    ];
  }

  // ─── Helper Methods ────────────────────────────────────────────────────────
  List<AppointmentModel> getAppointmentsForDoctor(String doctorId) =>
      appointments.where((a) => a.doctorId == doctorId).toList();

  List<AppointmentModel> getAppointmentsForPatient(String patientId) =>
      appointments.where((a) => a.patientId == patientId).toList();

  List<AppointmentModel> getTodayAppointments() =>
      appointments.where((a) => a.isToday).toList();

  List<BedModel> getAvailableBeds() =>
      beds.where((b) => b.isAvailable).toList();

  List<TokenModel> getActiveTokens() =>
      tokens.where((t) => t.status != TokenStatus.completed).toList();

  String nextBillNumber() {
    final count = payments.length + 1;
    return 'BILL-2026-${count.toString().padLeft(3, '0')}';
  }

  int nextTokenNumber() {
    final today = tokens.where((t) {
      final now = DateTime.now();
      return t.issuedAt.year == now.year &&
          t.issuedAt.month == now.month &&
          t.issuedAt.day == now.day;
    }).toList();
    return today.isEmpty
        ? 1
        : today.map((t) => t.tokenNumber).reduce((a, b) => a > b ? a : b) + 1;
  }

  // CRUD helpers
  void addDoctor(DoctorModel doc) => doctors.add(doc);
  void updateDoctor(DoctorModel doc) {
    final idx = doctors.indexWhere((d) => d.id == doc.id);
    if (idx != -1) doctors[idx] = doc;
  }

  void removeDoctor(String id) => doctors.removeWhere((d) => d.id == id);

  void addPatient(PatientModel p) => patients.add(p);
  void updatePatient(PatientModel p) {
    final idx = patients.indexWhere((x) => x.id == p.id);
    if (idx != -1) patients[idx] = p;
  }

  void removePatient(String id) => patients.removeWhere((p) => p.id == id);

  void addAppointment(AppointmentModel a) => appointments.add(a);
  void updateAppointmentStatus(String id, AppointmentStatus status) {
    final idx = appointments.indexWhere((a) => a.id == id);
    if (idx != -1)
      appointments[idx] = appointments[idx].copyWith(status: status);
  }

  void addToken(TokenModel t) => tokens.add(t);
  void updateTokenStatus(String id, TokenStatus status) {
    final idx = tokens.indexWhere((t) => t.id == id);
    if (idx != -1) tokens[idx] = tokens[idx].copyWith(status: status);
  }

  void addPayment(PaymentModel p) => payments.add(p);

  void addBed(BedModel b) => beds.add(b);
  void updateBed(BedModel b) {
    final idx = beds.indexWhere((x) => x.id == b.id);
    if (idx != -1) beds[idx] = b;
  }

  void addPrescription(PrescriptionModel rx) => prescriptions.add(rx);
  void addReport(ReportModel r) => reports.add(r);
}
