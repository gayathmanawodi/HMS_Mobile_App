import 'package:go_router/go_router.dart';
import 'package:hospitrack/controllers/auth_controller.dart';

// Auth Views
import 'package:hospitrack/views/auth/logo_screen.dart';
import 'package:hospitrack/views/auth/login_screen.dart';
import 'package:hospitrack/views/auth/create_account_screen.dart';
import 'package:hospitrack/views/auth/reset_password_screen.dart';
import 'package:hospitrack/views/auth/settings_screen.dart';

// Doctor Views
import 'package:hospitrack/views/doctor/doctor_dashboard.dart';
import 'package:hospitrack/views/doctor/doctor_profile.dart';
import 'package:hospitrack/views/doctor/appointments_screen.dart';
import 'package:hospitrack/views/doctor/diagnosis_screen.dart';
import 'package:hospitrack/views/doctor/prescription_screen.dart';
import 'package:hospitrack/views/doctor/video_call_screen.dart';

// Patient Views
import 'package:hospitrack/views/patient/patient_dashboard.dart';
import 'package:hospitrack/views/patient/patient_profile.dart';
import 'package:hospitrack/views/patient/choose_doctor_screen.dart';
import 'package:hospitrack/views/patient/choose_time_screen.dart';
import 'package:hospitrack/views/patient/medical_form_screen.dart';
import 'package:hospitrack/views/patient/appointment_center.dart';
import 'package:hospitrack/views/patient/live_consultation_screen.dart';
import 'package:hospitrack/views/patient/patient_details.dart'
    as patient_details;

// Admin Views
import 'package:hospitrack/views/admin/admin_dashboard.dart';
import 'package:hospitrack/views/admin/admin_screens.dart';

// Reception Views
import 'package:hospitrack/views/reception/reception_dashboard.dart';
import 'package:hospitrack/views/reception/generate_token_screen.dart';

// AI Views
import 'package:hospitrack/views/ai/symptom_checker_screen.dart';
import 'package:hospitrack/views/ai/health_risk_screen.dart';
import 'package:hospitrack/views/ai/health_guidance_screen.dart';

// Reports Views
import 'package:hospitrack/views/reports/reports_screen.dart';
import 'package:hospitrack/views/reports/investigation_report_screen.dart'
    as inv_report;
import 'package:hospitrack/views/reports/birth_report_screen.dart'
    as birth_report;
import 'package:hospitrack/views/reports/death_report_screen.dart'
    as death_report;

// Billing Views
import 'package:hospitrack/views/billing/generate_bill_screen.dart';

// Communication Views
import 'package:hospitrack/views/communication/chat_screen.dart';

// Payment Views
import 'package:hospitrack/views/payment/make_payment_screen.dart';

class AppRouter {
  static GoRouter createRouter(AuthController auth) {
    return GoRouter(
      initialLocation: '/',
      refreshListenable: auth,
      redirect: (context, state) {
        final isLoggedIn = auth.isLoggedIn;
        final loc = state.matchedLocation;

        const publicRoutes = [
          '/',
          '/login',
          '/create-account',
          '/reset-password',
        ];
        if (!isLoggedIn && !publicRoutes.contains(loc)) return '/login';
        if (isLoggedIn && publicRoutes.contains(loc)) {
          final role = auth.currentUser?.role.name;
          if (role == 'admin') return '/admin/dashboard';
          if (role == 'doctor') return '/doctor/dashboard';
          if (role == 'receptionist') return '/reception/dashboard';
          return '/patient/dashboard';
        }
        return null;
      },
      routes: [
        // ──── AUTH ────
        GoRoute(path: '/', builder: (_, __) => const LogoScreen()),
        GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
        GoRoute(
          path: '/create-account',
          builder: (_, __) => const CreateAccountScreen(),
        ),
        GoRoute(
          path: '/reset-password',
          builder: (_, __) => const ResetPasswordScreen(),
        ),
        GoRoute(
          path: '/change-password',
          builder: (_, __) => const ResetPasswordScreen(),
        ),
        GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),

        // ──── DOCTOR ────
        GoRoute(
          path: '/doctor/dashboard',
          builder: (_, __) => const DoctorDashboard(),
        ),
        GoRoute(
          path: '/doctor/profile',
          builder: (_, __) => const DoctorProfile(),
        ),
        GoRoute(
          path: '/doctor/appointments',
          builder: (_, __) => const AppointmentsScreen(),
        ),
        GoRoute(
          path: '/doctor/diagnosis',
          builder: (_, __) => const DiagnosisScreen(),
        ),
        GoRoute(
          path: '/doctor/prescriptions',
          builder: (_, __) => const PrescriptionScreen(),
        ),
        GoRoute(
          path: '/doctor/prescription-details',
          builder: (_, state) {
            final id = state.uri.queryParameters['id'] ?? '';
            return PrescriptionDetailsScreen(prescriptionId: id);
          },
        ),
        GoRoute(
          path: '/doctor/video-call',
          builder: (_, state) {
            final patient = state.uri.queryParameters['patient'] ?? 'Patient';
            return VideoCallScreen(patientName: patient);
          },
        ),
        GoRoute(
          path: '/doctor/reports',
          builder: (_, __) => const ReportsScreen(),
        ),
        GoRoute(
          path: '/doctor/reports/investigation',
          builder: (_, __) => const inv_report.InvestigationReportScreen(),
        ),
        GoRoute(
          path: '/doctor/reports/birth',
          builder: (_, __) => const birth_report.BirthReportScreen(),
        ),
        GoRoute(
          path: '/doctor/reports/death',
          builder: (_, __) => const death_report.DeathReportScreen(),
        ),

        // ──── PATIENT ────
        GoRoute(
          path: '/patient/dashboard',
          builder: (_, __) => const PatientDashboard(),
        ),
        GoRoute(
          path: '/patient/profile',
          builder: (_, __) => const PatientProfile(),
        ),
        GoRoute(
          path: '/patient/choose-doctor',
          builder: (_, __) => const ChooseDoctorScreen(),
        ),
        GoRoute(
          path: '/patient/choose-time',
          builder: (_, state) {
            final id = state.uri.queryParameters['doctorId'] ?? '';
            return ChooseTimeScreen(doctorId: id);
          },
        ),
        GoRoute(
          path: '/patient/appointments',
          builder: (_, __) => const AppointmentsScreen(),
        ),
        GoRoute(
          path: '/patient/medical-form',
          builder: (_, __) => const MedicalFormScreen(),
        ),
        GoRoute(
          path: '/patient/appointment-center',
          builder: (_, __) => const AppointmentCenter(),
        ),
        GoRoute(
          path: '/patient/live-consultation',
          builder: (_, __) => const LiveConsultationScreen(),
        ),
        GoRoute(
          path: '/patient/notifications',
          builder: (_, __) => const NotificationScreen(),
        ),
        GoRoute(
          path: '/patient/payment',
          builder: (_, __) => const MakePaymentScreen(),
        ),
        GoRoute(
          path: '/patient/chat',
          builder: (_, state) {
            final doctor = state.uri.queryParameters['doctor'] ?? 'Doctor';
            return ChatScreen(doctorName: doctor);
          },
        ),
        GoRoute(
          path: '/patient/details',
          builder: (_, __) => const patient_details.PatientDetails(),
        ),

        // ──── ADMIN ────
        GoRoute(
          path: '/admin/dashboard',
          builder: (_, __) => const AdminDashboard(),
        ),
        GoRoute(
          path: '/admin/profile',
          builder: (_, __) => const AdminProfile(),
        ),
        GoRoute(
          path: '/admin/doctors',
          builder: (_, __) => const DoctorListScreen(),
        ),
        GoRoute(
          path: '/admin/add-doctor',
          builder: (_, __) => const AddDoctorScreen(),
        ),
        GoRoute(
          path: '/admin/patients',
          builder: (_, __) => const PatientListScreen(),
        ),
        GoRoute(
          path: '/admin/add-patient',
          builder: (_, __) => const AddPatientScreen(),
        ),

        // ──── RECEPTION ────
        GoRoute(
          path: '/reception/dashboard',
          builder: (_, __) => const ReceptionDashboard(),
        ),
        GoRoute(
          path: '/reception/profile',
          builder: (_, __) => const ReceptionProfile(),
        ),
        GoRoute(
          path: '/reception/generate-token',
          builder: (_, __) => const GenerateTokenScreen(),
        ),
        GoRoute(
          path: '/reception/active-token',
          builder: (_, __) => const ActiveTokenScreen(),
        ),

        // ──── AI ────
        GoRoute(
          path: '/ai/symptom-checker',
          builder: (_, __) => const SymptomCheckerScreen(),
        ),
        GoRoute(
          path: '/ai/health-risk',
          builder: (_, __) => const HealthRiskScreen(),
        ),
        GoRoute(
          path: '/ai/health-guidance',
          builder: (_, __) => const HealthGuidanceScreen(),
        ),

        // ──── BILLING ────
        GoRoute(
          path: '/billing/generate-bill',
          builder: (_, __) => const GenerateBillScreen(),
        ),
        GoRoute(
          path: '/billing/bed-assign',
          builder: (_, __) => const BedAssignScreen(),
        ),
        GoRoute(
          path: '/billing/bed-details',
          builder: (_, __) => const BedDetailsScreen(),
        ),
      ],
    );
  }
}
