import 'package:flutter/material.dart';
import 'package:hospitrack/app/constants.dart';
import 'package:hospitrack/models/token_model.dart';
import 'package:hospitrack/services/mock_data_service.dart';
import 'package:uuid/uuid.dart';

class TokenController extends ChangeNotifier {
  final MockDataService _db = MockDataService();
  final _uuid = const Uuid();

  List<TokenModel> get all => List.unmodifiable(_db.tokens);

  List<TokenModel> get active => _db.getActiveTokens();

  TokenModel? get currentlyServing => _db.tokens.firstWhere(
    (t) => t.status == TokenStatus.serving,
    orElse: () => _db.tokens.isEmpty ? _db.tokens.first : _db.tokens.first,
  );

  int get waitingCount =>
      _db.tokens.where((t) => t.status == TokenStatus.waiting).length;

  TokenModel generateToken({
    required String patientId,
    required String patientName,
    required String patientPhone,
    required String department,
  }) {
    final token = TokenModel(
      id: _uuid.v4(),
      patientId: patientId,
      patientName: patientName,
      patientPhone: patientPhone,
      tokenNumber: _db.nextTokenNumber(),
      department: department,
      issuedAt: DateTime.now(),
    );
    _db.addToken(token);
    notifyListeners();
    return token;
  }

  void serveNext() {
    // Mark current serving as completed
    final serving = _db.tokens
        .where((t) => t.status == TokenStatus.serving)
        .toList();
    for (final t in serving) {
      _db.updateTokenStatus(t.id, TokenStatus.completed);
    }
    // Serve next waiting
    final waiting = _db.tokens
        .where((t) => t.status == TokenStatus.waiting)
        .toList();
    if (waiting.isNotEmpty) {
      waiting.sort((a, b) => a.tokenNumber.compareTo(b.tokenNumber));
      _db.updateTokenStatus(waiting.first.id, TokenStatus.serving);
    }
    notifyListeners();
  }

  void updateStatus(String id, TokenStatus status) {
    _db.updateTokenStatus(id, status);
    notifyListeners();
  }

  TokenModel? getTokenForPatient(String patientId) {
    try {
      return _db.tokens.lastWhere((t) => t.patientId == patientId);
    } catch (_) {
      return null;
    }
  }
}
