import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hospitrack/app/constants.dart';
import 'package:hospitrack/app/theme.dart';
import 'package:hospitrack/controllers/auth_controller.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;
  bool _remember = false;
  String _selectedRole = 'Patient';

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;
    final auth = context.read<AuthController>();
    final success = auth.login(
      _emailCtrl.text.trim(),
      _passCtrl.text,
      _selectedRole.toLowerCase(),
    );
    if (success) {
      final role = auth.currentUser?.role.name ?? 'patient';
      if (role == 'admin') {
        context.go('/admin/dashboard');
        // ignore: curly_braces_in_flow_control_structures
      } else if (role == 'doctor') {
        context.go('/doctor/dashboard');
      } else if (role == 'receptionist') {
        context.go('/reception/dashboard');
      } else {
        context.go('/patient/dashboard');
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(auth.error ?? 'Login failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 30),
              // Logo
              CircleAvatar(
                radius: 42,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/image.png',
                    width: 76,
                    height: 76,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.local_hospital,
                      size: 40,
                      color: AppTheme.primaryTeal,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'HospiTrack',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              // Login Card
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppTheme.backgroundLight,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(28),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          const Text(
                            'Welcome Back !',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textDark,
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Role Selector
                          DropdownButtonFormField<String>(
                            initialValue: _selectedRole,
                            decoration: const InputDecoration(
                              labelText: 'Login As',
                              prefixIcon: Icon(Icons.badge),
                            ),
                            items: AppConstants.userRoles
                                .map(
                                  (r) => DropdownMenuItem(
                                    value: r,
                                    child: Text(r),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) =>
                                setState(() => _selectedRole = v!),
                          ),
                          const SizedBox(height: 16),
                          // Email
                          TextFormField(
                            controller: _emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              hintText: 'Enter your email or Username',
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                            validator: (v) =>
                                v!.isEmpty ? 'Enter your email' : null,
                          ),
                          const SizedBox(height: 16),
                          // Password
                          TextFormField(
                            controller: _passCtrl,
                            obscureText: _obscure,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () =>
                                    setState(() => _obscure = !_obscure),
                              ),
                            ),
                            validator: (v) =>
                                v!.isEmpty ? 'Enter your password' : null,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Checkbox(
                                value: _remember,
                                onChanged: (v) =>
                                    setState(() => _remember = v!),
                                activeColor: AppTheme.primaryTeal,
                              ),
                              const Text(
                                'Remember me',
                                style: TextStyle(color: AppTheme.textMedium),
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () => context.go('/reset-password'),
                                child: const Text('Forget password?'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Login Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _login,
                              child: const Text('Login'),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Google Sign In
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              icon: Image.asset(
                                'assets/images/google_logo.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => const Icon(
                                  Icons.g_mobiledata,
                                  size: 20,
                                  color: Color(0xFF4285F4),
                                ),
                              ),
                              label: const Text('Google'),
                              onPressed: () {
                                setState(() => _selectedRole = 'Patient');
                                _emailCtrl.text = 'google@demo.com';
                                _passCtrl.text = 'demo123';
                                _login();
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: GestureDetector(
                              onTap: () => context.go('/create-account'),
                              child: RichText(
                                text: const TextSpan(
                                  text: "Don't have an account? ",
                                  style: TextStyle(color: AppTheme.textMedium),
                                  children: [
                                    TextSpan(
                                      text: 'Sign up',
                                      style: TextStyle(
                                        color: AppTheme.primaryTeal,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
