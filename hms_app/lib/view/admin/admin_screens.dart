// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hospitrack/widgets/app_back_button.dart';
import 'package:hospitrack/app/theme.dart';
import 'package:hospitrack/controllers/doctor_controller.dart';
import 'package:hospitrack/controllers/patient_controller.dart';
import 'package:hospitrack/widgets/shared_widgets.dart';
import 'package:provider/provider.dart';

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({super.key});

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  final _search = TextEditingController();
  String _q = '';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<DoctorController>();
    final doctors = _q.isEmpty ? ctrl.all : ctrl.search(_q);

    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Doctors'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryTeal,
        onPressed: () => context.push('/admin/add-doctor'),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _search,
              decoration: const InputDecoration(
                hintText: 'Search doctors...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (v) => setState(() => _q = v),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: doctors.length,
              itemBuilder: (_, i) {
                final d = doctors[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppTheme.primaryTeal.withOpacity(0.15),
                      child: Text(
                        d.name.split(' ').last[0],
                        style: const TextStyle(
                          color: AppTheme.primaryTeal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      d.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${d.specialization} · ${d.experience} yrs',
                      style: const TextStyle(fontSize: 12),
                    ),
                    trailing: Switch(
                      value: d.isAvailable,
                      onChanged: (_) => ctrl.toggleAvailability(d.id),
                      activeColor: AppTheme.primaryTeal,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AddDoctorScreen extends StatefulWidget {
  const AddDoctorScreen({super.key});

  @override
  State<AddDoctorScreen> createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _spec = TextEditingController();
  final _exp = TextEditingController();
  final _fee = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _spec.dispose();
    _exp.dispose();
    _fee.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Add Doctor'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _field(_name, 'Full Name'),
          const SizedBox(height: 12),
          _field(_email, 'Email', keyboard: TextInputType.emailAddress),
          const SizedBox(height: 12),
          _field(_phone, 'Phone', keyboard: TextInputType.phone),
          const SizedBox(height: 12),
          _field(_spec, 'Specialization'),
          const SizedBox(height: 12),
          _field(_exp, 'Experience (years)', keyboard: TextInputType.number),
          const SizedBox(height: 12),
          _field(_fee, 'Consultation Fee (LKR)'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.read<DoctorController>().addDoctor(
                name: _name.text.trim(),
                email: _email.text.trim(),
                phone: _phone.text.trim(),
                specialization: _spec.text.trim(),
                hospitalName: 'HospiTrack Medical',
                experience: int.tryParse(_exp.text) ?? 0,
                consultationFee: _fee.text.isEmpty
                    ? 'LKR 1500'
                    : 'LKR ${_fee.text.trim()}',
              );
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Doctor added successfully')),
              );
            },
            child: const Text('Add Doctor'),
          ),
        ],
      ),
    );
  }

  Widget _field(
    TextEditingController ctrl,
    String label, {
    TextInputType? keyboard,
  }) {
    return TextField(
      controller: ctrl,
      keyboardType: keyboard,
      decoration: InputDecoration(labelText: label),
    );
  }
}

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  final _search = TextEditingController();
  String _q = '';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<PatientController>();
    final patients = _q.isEmpty ? ctrl.all : ctrl.search(_q);

    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Patients'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _search,
              decoration: const InputDecoration(
                hintText: 'Search patients...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (v) => setState(() => _q = v),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: patients.length,
              itemBuilder: (_, i) {
                final p = patients[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppTheme.info.withOpacity(0.15),
                      child: Text(
                        p.name[0],
                        style: const TextStyle(
                          color: AppTheme.info,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      p.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${p.age} yrs · ${p.bloodGroup} · ${p.phone}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: AppTheme.textLight,
                    ),
                    onTap: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({super.key});

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _dob = TextEditingController();
  String _bg = 'O+';
  String _gender = 'Male';

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _dob.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Add Patient'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: _name,
            decoration: const InputDecoration(labelText: 'Full Name'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _phone,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(labelText: 'Phone'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _dob,
            decoration: const InputDecoration(
              labelText: 'Date of Birth (YYYY-MM-DD)',
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _gender,
            decoration: const InputDecoration(labelText: 'Gender'),
            items: [
              'Male',
              'Female',
              'Other',
            ].map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
            onChanged: (v) => setState(() => _gender = v!),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _bg,
            decoration: const InputDecoration(labelText: 'Blood Group'),
            items: [
              'A+',
              'A-',
              'B+',
              'B-',
              'O+',
              'O-',
              'AB+',
              'AB-',
            ].map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
            onChanged: (v) => setState(() => _bg = v!),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.read<PatientController>().addPatient(
                name: _name.text.trim(),
                email: _email.text.trim(),
                phone: _phone.text.trim(),
                address: 'Not specified',
                gender: _gender,
                bloodGroup: _bg,
                dateOfBirth: _dob.text.isNotEmpty
                    ? DateTime.tryParse(_dob.text.trim()) ?? DateTime(1990)
                    : DateTime(1990),
              );
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Patient added successfully!')),
              );
            },
            child: const Text('Add Patient'),
          ),
        ],
      ),
    );
  }
}

class AdminProfile extends StatelessWidget {
  const AdminProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Admin Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppTheme.cardGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white24,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/profileadmin.png',
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Image.asset(
                        'assets/image1.png',
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.admin_panel_settings,
                          color: Colors.white,
                          size: 45,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Hospital Administrator',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'HospiTrack Medical',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  InfoTile(
                    icon: Icons.email,
                    label: 'Email',
                    value: 'admin@hospitrack.lk',
                  ),
                  Divider(),
                  InfoTile(
                    icon: Icons.phone,
                    label: 'Phone',
                    value: '+94 11 222 3333',
                  ),
                  Divider(),
                  InfoTile(
                    icon: Icons.location_on,
                    label: 'Hospital',
                    value: 'HospiTrack Medical, Colombo 3',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReceptionProfile extends StatelessWidget {
  const ReceptionProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Receptionist Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppTheme.cardGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white24,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/receptionprofile.png',
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.front_hand,
                        color: Colors.white,
                        size: 45,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Receptionist',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Front Desk - HospiTrack',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  InfoTile(
                    icon: Icons.email,
                    label: 'Email',
                    value: 'reception@hospitrack.lk',
                  ),
                  Divider(),
                  InfoTile(
                    icon: Icons.phone,
                    label: 'Phone',
                    value: '+94 11 222 4444',
                  ),
                  Divider(),
                  InfoTile(
                    icon: Icons.badge,
                    label: 'Role',
                    value: 'Chief Receptionist',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
