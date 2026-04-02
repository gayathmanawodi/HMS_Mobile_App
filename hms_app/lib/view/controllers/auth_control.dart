import 'package:flutter/material.dart';
import 'package:hospitrack/app/constants.dart';
import 'package:hospitrack/models/user_model.dart';
import 'package:hospitrack/services/mock_data_service.dart';

class AuthController extends ChangeNotifier {
  final MockDataService _db = MockDataService();

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  String? _error;
  String? get error => _error;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Demo login: matches by role selection
  bool login(String email, String password, String role) {
    _error = null;
    if (email.isEmpty || password.isEmpty) {
      _error = 'Please enter email and password';
      notifyListeners();
      return false;
    }

    final roleEnum = UserRole.values.firstWhere(
      (r) => r.name.toLowerCase() == role.toLowerCase(),
      orElse: () => UserRole.patient,
    );

    final user = _db.users.firstWhere(
      (u) => u.role == roleEnum,
      orElse: () => _db.users.first,
    );

    _currentUser = user;
    _db.currentUser = user;
    notifyListeners();
    return true;
  }

  void logout() {
    _currentUser = null;
    _db.currentUser = null;
    notifyListeners();
  }

  Future<bool> createAccount(
    String firstName,
    String lastName,
    String email,
    String phone,
    String password,
  ) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 800));
    final newUser = UserModel(
      id: 'u_${DateTime.now().millisecondsSinceEpoch}',
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      role: UserRole.patient,
      createdAt: DateTime.now(),
    );
    _db.users.add(newUser);
    _currentUser = newUser;
    _db.currentUser = newUser;
    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> resetPassword(String email) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 800));
    _isLoading = false;
    notifyListeners();
    return true;
  }
}
