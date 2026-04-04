import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hospitrack/app/routes.dart';
import 'package:hospitrack/app/theme.dart';
import 'package:hospitrack/controllers/appointment_controller.dart';
import 'package:hospitrack/controllers/auth_controller.dart';
import 'package:hospitrack/controllers/billing_controller.dart';
import 'package:hospitrack/controllers/doctor_controller.dart';
import 'package:hospitrack/controllers/patient_controller.dart';
import 'package:hospitrack/controllers/theme_controller.dart';
import 'package:hospitrack/controllers/token_controller.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const HospiTrackApp());
}

class HospiTrackApp extends StatelessWidget {
  const HospiTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => DoctorController()),
        ChangeNotifierProvider(create: (_) => PatientController()),
        ChangeNotifierProvider(create: (_) => AppointmentController()),
        ChangeNotifierProvider(create: (_) => BillingController()),
        ChangeNotifierProvider(create: (_) => TokenController()),
        ChangeNotifierProvider(create: (_) => ThemeController()),
      ],
      child: Builder(
        builder: (context) {
          final auth = context.watch<AuthController>();
          final theme = context.watch<ThemeController>();
          final router = AppRouter.createRouter(auth);

          return MaterialApp.router(
            title: 'HospiTrack',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: theme.themeMode,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
